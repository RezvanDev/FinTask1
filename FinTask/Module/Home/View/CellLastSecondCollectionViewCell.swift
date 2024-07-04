//
//  CellLastSecondCollectionViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 03.07.2024.
//

import UIKit

class CellLastSecondCollectionViewCell: UICollectionViewCell, CellProtocols{
    
    static var reuseId: String = "CellLastSecondCollectionViewCell"
    
    private lazy var nameSaving: UILabel = {
        let lbl = UILabel()
        lbl.text = "test"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .black
        return lbl
    }()
    private lazy var money: UILabel = {
        let lbl = UILabel()
        lbl.text = "test"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .light)
        lbl.textColor = .black
        return lbl
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(saving: Saving) {
        nameSaving.text = saving.name
        money.text = "\(saving.haveAmount) / \(saving.needAmount)"
    }
    
    private func setup() {
        addSubview(nameSaving)
        addSubview(money)
        
        NSLayoutConstraint.activate([
            nameSaving.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameSaving.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            
            money.topAnchor.constraint(equalTo: nameSaving.bottomAnchor, constant: 5),
            money.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
