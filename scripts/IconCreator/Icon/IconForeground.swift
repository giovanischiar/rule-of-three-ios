//
//  IconForeground.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct IconForeground: Tag {
    let theme = Traits.shared.theme
    let dimensions = Traits.shared.dimensions
    
    var squareColor: String { theme.squareStrokeColor }
    var iconSize: Double { dimensions.iconSize }
    var squareSize: Double { dimensions.squareSize }
    var strokeWidth: Double { dimensions.strokeWidth }
    var xSize: Double { dimensions.xSize }
    var hashSize: Double { dimensions.hashSize }

    var disposition = 21.0
    var scaleFactor = 1.0
    
    @TagBuilder var contentBody: [any Tag] {
        Square(x: -disposition, y: -disposition, size: squareSize) {
            Hash(x: -disposition, y: -disposition)
        }
        .stroke(color: squareColor)
        .stroke(width: strokeWidth)

        Square(x: disposition, y: -disposition, size: squareSize) {
            Hash(x: disposition, y: -disposition)
        }
        .stroke(color: squareColor)
        .stroke(width: strokeWidth)

        X(x: 0, y: 0).body

        Square(x: -disposition, y: disposition, size: squareSize) {
            Hash(x: -disposition, y: disposition)
        }
        .stroke(color: squareColor)
        .stroke(width: strokeWidth)

        Square(x: disposition, y: disposition, size: squareSize) {
            QuestionMark(x: disposition, y: disposition)
        }
        .stroke(color: squareColor)
        .stroke(width: strokeWidth)
    }
    
    var body: [any Tag] {
        Vector(viewBox: [0, 0, iconSize, iconSize]) {
            contentBody
                .scaled(factor: scaleFactor)
                .center()
        }
    }
}

extension IconForeground {
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }

    func disposition(_ value: Double) -> IconForeground {
        IconForeground(disposition: disposition)
    }

    func scaleFactor(_ value: Double) -> IconForeground {
        IconForeground(scaleFactor: scaleFactor)
    }
}

