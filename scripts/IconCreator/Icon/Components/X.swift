//
//  X.swift
//
//
//  Created by Giovani Schiar on 08/12/22.
//

struct X: Tag {
    let x: Double
    let y: Double
    
    let dimensions = Traits.shared.dimensions
    let theme = Traits.shared.theme
    var strokeWidth: Double { dimensions.strokeWidth }
    var color: String { theme.xColor }
    
    var body: [any Tag] {
        Path()
            .d(XPathData(x: x, y: y, width: dimensions.xSize, height: dimensions.xSize))
            .stroke(color: color)
            .stroke(width: strokeWidth)
            .fill(opacity: 1)
            .fill(with: color)
    }
}
