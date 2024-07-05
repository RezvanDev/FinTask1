//
//  ColorSelectionCollectionViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 05.07.2024.
//

import UIKit

class ColorSelectionCollectionViewCell: UICollectionViewCell, CellProtocols {
    static var reuseId: String = "ColorSelectionCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with color: UIColor?) {
        backgroundColor = color
    }
}
