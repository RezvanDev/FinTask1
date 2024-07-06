//
//  ColorModel.swift
//  FinTask
//
//  Created by Иван Незговоров on 06.07.2024.
//

import Foundation

struct Color {
    var hexColor: String
}

class ColorModel {
    
    var hexColors: [String] = []
    
    init() {
        downloadHexColors()
    }
    
    func downloadHexColors() {
        hexColors = [
            "#FFF8DC", "#F4A460", "#DC143C", "#FF6347", "#00FFFF", "#FFE4B5",
            "#FF00FF", "#6B8E23", "#ebad81", "#6A5ACD", "#32CD32",
            "#ADFF2F",  "#32CD32",
            "#98FB98", "#00FA9A", "#00FF7F", "#66CDAA", "#8FBC8F", "#20B2AA",
            "#87CEFA", "#1E90FF", "#0000FF", "#000080", "#800080", "#EE82EE",
            "#FF00FF",  "#B22222", "#FFA07A", "#FA8072",
            "#E9967A", "#F08080", "#CD5C5C", "#DC143C", "#F5F5F5", "#D3D3D3",
            "#C0C0C0", "#A9A9A9", "#696969",
            "#FFB3BA", "#FFDFBA", "#FFFFBA", "#BAFFC9", "#BAE1FF", "#E6E6FA",
            "#FFD1DC", "#E0BBE4", "#957DAD", "#D291BC", "#FEC8D8", "#FFDFD3",
            "#FFE4E1", "#FFFACD", "#FAFAD2", "#D8BFD8", "#E0FFFF", "#F0E68C",
            "#F5DEB3", "#FFDEAD",
            "#FFFF00",
            "#EE82EE",
            "#FFC0CB",
            "#FFB6C1",
            "#FFFFE0",
            "#FF0000",
            "#FFA07A",
            "#FFD700",
            "#FF4500",
            "#FF6347"
        ]
    }
}
