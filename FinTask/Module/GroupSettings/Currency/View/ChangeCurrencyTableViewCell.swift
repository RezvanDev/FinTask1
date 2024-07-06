//
//  ChangeCurrencyTableViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 06.07.2024.
//

import UIKit

class ChangeCurrencyTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "ChangeCurrencyTableViewCell"
    
    private lazy var nameCurrency: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()
    private lazy var codeCurrency: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, code: String) {
        nameCurrency.text = name
        codeCurrency.text = code
    }
    
    private func setup() {
        addSubview(nameCurrency)
        addSubview(codeCurrency)
        
        NSLayoutConstraint.activate([
            nameCurrency.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameCurrency.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            codeCurrency.centerYAnchor.constraint(equalTo: centerYAnchor),
            codeCurrency.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
