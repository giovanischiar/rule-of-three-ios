/**
    This script generates an SVG File that represents the icon of the application. It needs the palette directory as a first parameter. This palette directory needs to include backgroundColor, rectColor, hashColor, xColor, questionMarkColor colorset files. After running this script prints a svg string.
 */

import Foundation

struct SvgQuestionMark {
    private let x: Double
    private let y: Double
    private let color: String
    private let strokeWidth: Double

    init(x: Double, y: Double, color: String, strokeWidth: Double) {
        self.x = 50 - 9.15 + x
        self.y = 50 - 9.6 + y
        self.color = color
        self.strokeWidth = strokeWidth
    }

    func svg() -> String {
        return "<svg x=\"\(x)%\" y=\"\(y)%\" width=\"20%\" height=\"20%\" viewBox=\"0 0 39.601 76.401\" xmlns=\"http://www.w3.org/2000/svg\">\n<g id=\"svgGroup\" stroke-linecap=\"round\" fill-rule=\"evenodd\" style=\"stroke:\(color);stroke-width:\(strokeWidth)%;fill:\(color)\">\n<path d=\"M 19.9 54.5 L 12.1 54.5 Q 11.6 52.8 11.35 50.8 Q 11.1 48.8 11.1 47.1 Q 11.1 42.692 12.519 39.517 A 12.998 12.998 0 0 1 13 38.55 Q 14.9 35.1 17.7 32.55 A 102.193 102.193 0 0 1 22.6 28.356 A 93.203 93.203 0 0 1 23.3 27.8 A 26.994 26.994 0 0 0 26.448 24.914 A 22.845 22.845 0 0 0 28 23.05 Q 29.9 20.5 29.9 17 A 8.241 8.241 0 0 0 27.605 11.27 A 11.006 11.006 0 0 0 27.2 10.85 A 9.012 9.012 0 0 0 22.652 8.472 A 13.221 13.221 0 0 0 19.9 8.2 A 14.436 14.436 0 0 0 14.641 9.146 A 13.602 13.602 0 0 0 12.5 10.2 A 20.638 20.638 0 0 0 8.336 13.565 A 25.722 25.722 0 0 0 6.5 15.7 L 0 10.5 A 34.396 34.396 0 0 1 5.209 5.308 A 29.133 29.133 0 0 1 8.9 2.8 A 20.688 20.688 0 0 1 15.376 0.471 A 28.67 28.67 0 0 1 20.7 0 A 24.161 24.161 0 0 1 25.885 0.533 A 18.912 18.912 0 0 1 30.55 2.2 A 18.017 18.017 0 0 1 35.134 5.53 A 16.193 16.193 0 0 1 37.2 8.1 Q 39.6 11.8 39.6 16.3 Q 39.6 21.4 37.6 24.8 Q 35.6 28.2 32.7 30.75 Q 29.8 33.3 26.85 35.75 Q 23.9 38.2 21.9 41.25 A 11.744 11.744 0 0 0 20.283 45.172 Q 19.9 46.888 19.9 48.9 L 19.9 54.5 Z M 11.863 74.462 A 6.418 6.418 0 0 0 16.5 76.4 A 8.605 8.605 0 0 0 17.122 76.378 A 6.461 6.461 0 0 0 21.3 74.55 Q 23.2 72.7 23.2 69.7 A 6.225 6.225 0 0 0 22.621 67.029 A 6.955 6.955 0 0 0 21.15 65 A 8.478 8.478 0 0 0 20.629 64.532 A 6.325 6.325 0 0 0 16.5 63 A 8.813 8.813 0 0 0 14.647 63.185 A 5.979 5.979 0 0 0 11.6 64.8 A 5.927 5.927 0 0 0 10.032 67.64 A 8.624 8.624 0 0 0 9.8 69.7 Q 9.8 72.4 11.8 74.4 A 8.317 8.317 0 0 0 11.863 74.462 Z\"/>\n</g>\n</svg>"
    }
}

struct SvgHash {
    private let x: Double
    private let y: Double
    private let color: String
    private let strokeWidth: Double

    init(x: Double, y: Double, color: String, strokeWidth: Double) {
        self.x = 50 - 0.25 + x
        self.y = 50 - 9.6 + y
        self.color = color
        self.strokeWidth = strokeWidth
    }

    func svg() -> String {
        return "\(verticalLines())\n\(horizontalLines())"
    }

    private func verticalLines() -> String {
        let x2 = x - 5.2
        let y2 = y + 19.2
        return "<line x1=\"\(x)%\" y1=\"\(y)%\" x2=\"\(x2)%\" y2=\"\(y2)%\" style=\"stroke:\(color); stroke-width:\(strokeWidth)%\" />\n<line x1=\"\(x + 4.9)%\" y1=\"\(y)%\" x2=\"\(x2 + 4.9)%\" y2=\"\(y2)%\" style=\"stroke:\(color); stroke-width:\(strokeWidth)%\" />"

    }

    private func horizontalLines() -> String {
        let x1 = x - 5.7
        let y1 = y + 6.7
        let x2 = x1 + 12.5
        let y2 = y1
        return "<line x1=\"\(x1)%\" y1=\"\(y1)%\" x2=\"\(x2)%\" y2=\"\(y2)%\" style=\"stroke:\(color); stroke-width:\(strokeWidth - 0.6)%\" />\n<line x1=\"\(x1 - 1.6)%\" y1=\"\(y1 + 5.9)%\" x2=\"\(x2 - 1.6)%\" y2=\"\(y2 + 5.9)%\" style=\"stroke:\(color); stroke-width:\(strokeWidth - 0.6)%\" />"
    }
}

struct SvgRect {
    private let x: Double
    private let y: Double
    private let width: Double
    private let height: Double
    private let strokeWidth: Double
    private let strokeColor: String
    private let fontColor: String
    private let svgHash: SvgHash

    init(x: Double, y: Double, width: Double, height: Double, strokeWidth: Double, strokeColor: String, fontColor: String) {
        svgHash = SvgHash(x: x, y: y, color: fontColor, strokeWidth: 1.8)
        self.x = 50 - width/2 + x
        self.y = 50 - height/2 + y
        self.width = width
        self.height = height
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor
        self.fontColor = fontColor

    }

    func svg() -> String {
        return "<rect x=\"\(x)%\" y=\"\(y)%\" width=\"\(width)%\" height=\"\(height)%\" stroke-width=\"\(strokeWidth)%\" stroke=\"\(strokeColor)\" fill=\"none\" />" + "\n" + svgHash.svg()
    }
}

struct SvgRectQuestion {
    private let x: Double
    private let y: Double
    private let width: Double
    private let height: Double
    private let strokeWidth: Double
    private let strokeColor: String
    private let fontColor: String
    private let svgQuestionMark: SvgQuestionMark

    init(x: Double, y: Double, width: Double, height: Double, strokeWidth: Double, strokeColor: String, fontColor: String) {
        svgQuestionMark = SvgQuestionMark(x: x, y: y, color: fontColor, strokeWidth: strokeWidth)
        self.x = 50 - width/2 + x
        self.y = 50 - height/2 + y
        self.width = width
        self.height = height
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor
        self.fontColor = fontColor

    }

    func svg() -> String {
        return "<rect x=\"\(x)%\" y=\"\(y)%\" width=\"\(width)%\" height=\"\(height)%\" stroke-width=\"\(strokeWidth)%\" stroke=\"\(strokeColor)\" fill=\"none\" />" + "\n" + svgQuestionMark.svg()
    }
}

struct AppIconSvgGenerator {
    private let backgroundColor: String
    private let rectColor: String
    private let hashColor: String
    private let xColor: String
    private let questionMarkColor: String
    private let header = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<svg viewBox=\"0 0 240 240\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" version=\"1.1\" xml:space=\"preserve\">"
    private let background: String
    private let centerX: String

    init(backgroundColor: String, rectColor: String, hashColor: String, xColor: String, questionMarkColor: String) {
        self.backgroundColor = backgroundColor
        self.rectColor = rectColor
        self.hashColor = hashColor
        self.xColor = xColor
        self.questionMarkColor = questionMarkColor
        background = "<rect id=\"background\" width=\"100%\" height=\"100%\" x=\"0\" y=\"0\" fill=\"\(backgroundColor)\" />"
        centerX = "<line x1=\"47%\" y1=\"47%\" x2=\"53%\" y2=\"53%\" style=\"stroke:\(xColor); stroke-width:1%\" />\n<line x1=\"47%\" y1=\"53%\" x2=\"53%\" y2=\"47%\" style=\"stroke:\(xColor); stroke-width:1%\" />"
    }

    func svg() -> String {
        let rectWidth = 30.0
        let strokeWidth = 1.8
        return header + "\n" +
        "<g>" + "\n" +
        background + "\n"
        + SvgRect(
            x: -20,
            y: -20,
            width: rectWidth,
            height: rectWidth,
            strokeWidth: strokeWidth,
            strokeColor: rectColor,
            fontColor: hashColor
        ).svg() + "\n"
        + SvgRect(
            x: 20,
            y: -20,
            width: rectWidth,
            height: rectWidth,
            strokeWidth: strokeWidth,
            strokeColor: rectColor,
            fontColor: hashColor
        ).svg() + "\n"
        + centerX
        + SvgRect(
            x: -20,
            y: 20,
            width: rectWidth,
            height: rectWidth,
            strokeWidth: strokeWidth,
            strokeColor: rectColor,
            fontColor: hashColor
        ).svg() + "\n"
        + SvgRectQuestion(
            x: 20,
            y: 20,
            width: rectWidth,
            height: rectWidth,
            strokeWidth: strokeWidth,
            strokeColor: rectColor,
            fontColor: questionMarkColor
        ).svg() + "\n"
        + "</g>" + "\n"
        + "</svg>"
    }
}

struct Component: Codable {
    let alpha: String
    let blue: String
    let green: String
    let red: String
}

struct Appearance: Codable {
    let appearance: String
    let value: String
}

struct Color: Codable {
    let colorSpace: String
    let components: Component

    enum CodingKeys: String, CodingKey {
        case colorSpace = "color-space"
        case components
    }
}

struct Info: Codable {
    let author: String
    let version: Int
}

struct ColorKey: Codable {
    let appearances: [Appearance]?
    let color: Color
    let idiom: String
}

struct ResponseData: Codable {
    let colors: [ColorKey]
}

struct ColorSetFetcher {
    private let assetsPath: String

    init(assetsPath: String) {
        self.assetsPath = assetsPath
    }

    private func getHexColor(red: String, green: String, blue: String) -> String {
        return "#\(red.dropFirst(2))\(green.dropFirst(2))\(blue.dropFirst(2))"
    }

    func fetchHexColor(name: String) -> String {
        let url = URL(fileURLWithPath: "\(assetsPath)/\(name).colorset/Contents.json")
        var colors: [ColorKey] = []
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data)
            colors = jsonData.colors
        } catch {
            print("error: \(error)")
            return "#FFFFFF"
        }
        let color = colors[0].color
        let components = color.components
        return getHexColor(red: components.red, green: components.green, blue: components.blue)
    }
}

let arguments = CommandLine.arguments
if (arguments.count != 3 || arguments[1] != "--palette-dir") {
    print("Usage: \(arguments[0]) --palette-dir path/to/colorAssets.xcassets")
} else {
    let assetDirectory = arguments[2]
    let colorSetFetcher = ColorSetFetcher(assetsPath: assetDirectory)
    print(AppIconSvgGenerator(
        backgroundColor: colorSetFetcher.fetchHexColor(name: "backgroundColor"),
        rectColor: colorSetFetcher.fetchHexColor(name: "rectColor"),
        hashColor: colorSetFetcher.fetchHexColor(name: "hashColor"),
        xColor: colorSetFetcher.fetchHexColor(name: "xColor"),
        questionMarkColor: colorSetFetcher.fetchHexColor(name: "questionMarkColor")
    ).svg())
}
