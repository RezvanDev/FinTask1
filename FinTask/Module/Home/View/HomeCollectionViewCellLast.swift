//
//  HomeCollectionViewCellLast.swift
//  FinTask
//
//  Created by Иван Незговоров on 26.06.2024.
//

import UIKit

class HomeCollectionViewCellLast: UICollectionViewCell, CellProtocols {
    
    static var reuseId: String = "HomeCollectionViewCellLast"
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "Ежемесячный платеж"
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(title)
        setupBorders()
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])
    }
    
    private func setupBorders() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
    }
    
    
}
