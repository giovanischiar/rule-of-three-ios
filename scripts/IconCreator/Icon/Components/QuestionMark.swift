//
//  QuestionMark.swift
//
//
//  Created by Giovani Schiar on 08/12/22.
//

struct QuestionMark: Tag {
    var x: Double
    var y: Double
    let dimensions = Traits.shared.dimensions
    let theme = Traits.shared.theme
    
    var size: Double { dimensions.iconSize }
    var color: String { theme.questionMarkColor }
    
    
    var body: [any Tag] {
        Path()
            .d(QuestionMarkPathData(x: x, y: y))
            .stroke(color: color)
            .stroke(width: 1)
            .fill(opacity: 1)
            .fill(with: color)
            .scaled(factor: size * 0.00203704)
    }
}
