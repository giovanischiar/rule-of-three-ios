//
//  IconBackground.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct IconBackground: Tag {
    let dimensions = Traits.shared.dimensions
    let theme = Traits.shared.theme
    var backgroundColor: String { theme.backgroundColor }
    var size: Double { dimensions.iconSize }
    
    func radius(backgroundType: BackgroundType) -> Double {
        switch (backgroundType) {
            case .square: return 0
            case .squircle: return 10 %% size
            case .circle: return size/2.0
        }
    }

    @TagBuilder func contentBody(type: BackgroundType = .square) -> [any Tag] {
        Square(x: 0, y: 0, size: size, radius: radius(backgroundType: type))
            .fill(color: backgroundColor)
    }

    var body: [any Tag] {
        Vector(viewBox: [0, 0, size, size]) {
            contentBody(type: .square)
        }
    }
}

extension IconBackground {
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }
}
