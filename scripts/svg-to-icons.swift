/**
    This script receives a SVG String as a input and generates all necessary app icon PNG files described in AppIcon.appiconset/Contents.json using the svg2png, copies all the files to AppIcon.appiconset/ directory and update the Contents.json files with the respecting names of the PNG files.
 */

import Foundation

struct Info: Codable {
    let author: String
    let version: Int
}

struct Image: Codable {
    var filename: String?
    let idiom: String
    let scale: String?
    let platform: String?
    let size: String
}

struct AppIconJSON: Codable {
    var images: [Image]
    let info: Info
}

struct File: Codable {
    let directory: String
    let nameSuffix: String
    let height: Double
    let width: Double
}

struct SVG2PNGJSON: Codable {
    let files: [File]
}

extension SVG2PNGJSON {
    func nameSuffixes() -> [String] {
        return self.files.map { $0.nameSuffix }
    }
}

class JSONFetcher<T: Codable> {
    private let url: URL

    init(path: String) {
        url = URL(fileURLWithPath: path)
    }

    func fetch() -> T? {
        var json: T? = nil
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            json = try decoder.decode(T.self, from: data)
        } catch {
            print("error:\(error)")
            return nil
        }

        return json
    }
}

class AssetFetcher<T: Codable>: JSONFetcher<T> {
    init(appName: String, name: String, suffix: String) {
        super.init(path: "\(appName)/Assets.xcassets/\(name).\(suffix)/Contents.json")
    }
}

extension AppIconJSON {
    func convertToSVG2PNGJSON(directory: String) -> SVG2PNGJSON {
        return SVG2PNGJSON(files: self.images.map {
            let size = $0.size.split(separator: "x")
            let scaleText = $0.scale ?? ""
            var scale = 1.0
            if (scaleText != "") {
                let index = scaleText.index(scaleText.startIndex, offsetBy: 0)
                let character = scaleText[index]
                scale = Double(character.wholeNumberValue ?? 1)
            }
            let widthString = size[0]
            let heightString = size[1]
            let width = (Double(widthString) ?? 0) * scale
            let height = (Double(heightString) ?? 0) * scale
            let nameSuffix =  "-\($0.size)\(scaleText != "" ? "@\(scaleText)" : scaleText)"
            return File(directory: directory, nameSuffix: nameSuffix, height: height, width: width)
        })
    }

    func imagesNamesRenamed(fileName: String, fileSuffixes: [String]) -> AppIconJSON {
        var copy = self
        let imagesWithNames = self.images.enumerated().map { (index, element) in
            var newElement = element
            newElement.filename = "\(fileName)\(fileSuffixes[index]).png"
            return newElement
        }

        copy.images = imagesWithNames
        return copy
    }
}

struct SVGFileCreator {
    private let svgContent: String

    init(svgContent: String) {
        self.svgContent = svgContent
    }

    func create(at filePath: String) {
        if (FileManager.default.createFile(atPath: filePath, contents: Data(svgContent.utf8), attributes: nil)) {
            print("\(filePath) created successfully.")
        } else {
            print("\(filePath) not created.")
        }
    }
}

struct SVG2PNGJSONCreator {
    private let svg2PNGJSON: SVG2PNGJSON

    init(svg2PNGJSON: SVG2PNGJSON) {
        self.svg2PNGJSON = svg2PNGJSON
    }

    func create(at filePath: String) {
        do {
            let svg2PNGJSONData = try JSONEncoder().encode(svg2PNGJSON)
            if let jsonString = String(data: svg2PNGJSONData, encoding: .utf8) {
                if (FileManager.default.createFile(atPath: filePath, contents: Data(jsonString.utf8), attributes: nil)) {
                    print("\(filePath) created successfully.")
                } else {
                    print("\(filePath) not created.")
                }
            }
        } catch let err {
            print("Failed to encode JSON \(err)")
        }
    }
}

struct AppIconFileRecreator {
    private let appIconJSON: AppIconJSON
    private let appIconName: String
    private let appName: String

    init(appName: String, appIconJSON: AppIconJSON, appIconName: String) {
        self.appName = appName
        self.appIconJSON = appIconJSON
        self.appIconName = appIconName
    }

    func recreate() {
        do {
            let appIconJSONData = try JSONEncoder().encode(appIconJSON)
            if let jsonString = String(data: appIconJSONData, encoding: .utf8) {
                let filePath = "\(appName)/Assets.xcassets/\(appIconName).appiconset/Contents.json"
                if (FileManager.default.createFile(atPath: filePath, contents: Data(jsonString.utf8), attributes: nil)) {
                    print("\(filePath) recreated successfully.")
                } else {
                    print("\(filePath) not created.")
                }
            }
        } catch let err {
            print("Failed to encode JSON \(err)")
        }
    }
}

func shell(_ command: String) {
    print(command)
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.standardInput = nil
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    if (!output.isEmpty) { print(output) }
}

func findIconName(appName: String) -> String {
    let enumerator = FileManager.default.enumerator(atPath: "\(appName)/Assets.xcassets/")
    let filePaths = enumerator?.allObjects as! [String]
    let txtFilePaths = filePaths.filter{$0.contains(".appiconset") && !$0.contains("/")}
    return !txtFilePaths.isEmpty ? String(txtFilePaths[0].split(separator: ".")[0]) : "AppIcon"
}

func findCurrentDirectory() -> String {
    let arguments = CommandLine.arguments[0].split(separator: "/")
    return arguments[0...(arguments.count-2)].joined(separator: "/")
}

let arguments = CommandLine.arguments
var svgContent = ""
var svgFileName = ""

for (index, argument) in arguments.enumerated() {
    switch argument {
        case "--svg-content":
            if (index + 1 >= arguments.count) { break }
            svgContent = arguments[index+1]
            continue;
        case "--svg-file-name":
            if (index + 1 >= arguments.count) { break }
            svgFileName = arguments[index+1]
            continue;
        default: continue
    }
}

if (svgContent == "" || svgFileName == "") {
    print("usage: \(arguments[0]) --svg-content <svg><!-- a valid svg --></svg> --svg-file-name path/to/svgfile.svg")
} else {
    let currentDirectory = findCurrentDirectory()
    let appName = "RuleOfThree"
    let iosIconName = findIconName(appName: appName)
    let iconFileName = "icon-launcher"
    
    let outputFolderName = "output"
    let outputFolderPath = "\(currentDirectory)/\(outputFolderName)"
    
    let svgFolderPath = "\(outputFolderPath)/\(svgFileName)"
    
    let svg2PNGJSONFileName = "ios-icon-format.json"
    let svg2PNGJSONFilePath = "\(outputFolderPath)/\(svg2PNGJSONFileName)"
    
    let iconPNGOutputFolderName = "ios-icons"
    let iconPNGOutputFolderPath = "\(outputFolderPath)/\(iconPNGOutputFolderName)"
    
    shell("mkdir -p \(outputFolderPath)")
    shell("find \(outputFolderPath) -name \"*.svg\" -type f -delete")
    SVGFileCreator(svgContent: svgContent).create(at: svgFolderPath)
    let appIconJSON = AssetFetcher<AppIconJSON>(appName: appName, name: iosIconName, suffix: "appiconset").fetch()
    if let appIconJSON = appIconJSON {
        let svg2PNGJSON = appIconJSON.convertToSVG2PNGJSON(directory: "\(iconPNGOutputFolderPath)")
        SVG2PNGJSONCreator(svg2PNGJSON: svg2PNGJSON).create(at: "\(svg2PNGJSONFilePath)")
        let appIconJSONRenamed = appIconJSON.imagesNamesRenamed(fileName: iconFileName, fileSuffixes: svg2PNGJSON.nameSuffixes())
        shell("find \(iconPNGOutputFolderPath) -name \"*.png\" -type f -delete")
        shell("\(currentDirectory)/svg2png -f \(svgFolderPath) -c \(svg2PNGJSONFilePath)")
        shell("find \(appName)/Assets.xcassets/\(iosIconName).appiconset -name \"*.png\" -type f -delete")
        shell("cp \(iconPNGOutputFolderPath)/* \(appName)/Assets.xcassets/\(iosIconName).appiconset/")
        AppIconFileRecreator(appName: appName, appIconJSON: appIconJSONRenamed, appIconName: iosIconName).recreate()
    }
}
