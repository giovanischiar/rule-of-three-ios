//
//  Square.swift
//
//
//  Created by Giovani Schiar on 08/12/22.
//

struct Square: Tag {
    let x: Double
    let y: Double
    let size: Double
    let radius: Double
    let content: [any Tag]
    
    let dimensions = Traits.shared.dimensions
    var strokeWidth: Double { dimensions.strokeWidth }
    
    
    init(x: Double, y: Double, size: Double, radius: Double = 0) {
        self.init(x: x, y: y, size: size, radius: radius) { [] as [any Tag] }
    }
    
    init(x: Double, y: Double, size: Double, radius: Double = 0, @TagBuilder content: () -> [any Tag]) {
        self.x = x
        self.y = y
        self.size = size
        self.radius = radius
        self.content = content()
    }
    
    var body: [any Tag] {
        Path()
            .d(RectPathData(
                x: x,
                y: y,
                width: size,
                height: size,
                rx: radius
            )
        )
        content
    }
}
