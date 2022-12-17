//
//  Theme.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

class Theme {
    var backgroundColor = "#00E5E8"
    var squareStrokeColor = "#4C1A57"
    var hashColor = "#F0F600"
    var xColor = "#007C77"
    var questionMarkColor = "#FF3CC7"
    
    init() {}
    
    init(_ dict: [String:String]) {
        backgroundColor = dict["backgroundColor"] ?? backgroundColor
        squareStrokeColor = dict["squareStrokeColor"] ?? squareStrokeColor
        hashColor = dict["hashColor"] ?? hashColor
        xColor = dict["xColor"] ?? xColor
        questionMarkColor = dict["#FF3CC7"] ?? questionMarkColor
    }
}
