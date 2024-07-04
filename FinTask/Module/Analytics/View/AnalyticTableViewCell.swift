//
//  AnalyticTableViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 04.07.2024.
//

import UIKit


class AnalyticTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "AnalyticTableViewCell"
    
    private lazy var nameCategory: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Test"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    private lazy var money: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Test"
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .black
        return lbl
    }()
    private lazy var circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with category: Any, wallet: Wallet, color: UIColor) {
        var amount = 0.0
        if let category = category as? CategoryExpense {
            nameCategory.text = category.name
            category.expenses.forEach({amount += $0.amount})
            money.text = "-\(Int(amount)) \(wallet.nameCurrency)"
        } else if let category = category as? CategoryIncome {
            nameCategory.text = category.name
            category.incomes.forEach({amount += $0.amount})
            money.text = "\(Int(amount)) \(wallet.nameCurrency)"
        }
        circleView.backgroundColor = color
      
    }
    
    private func setup() {
        addSubview(nameCategory)
        addSubview(money)
        addSubview(circleView)
        
        NSLayoutConstraint.activate([
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            circleView.heightAnchor.constraint(equalToConstant: 10),
            circleView.widthAnchor.constraint(equalToConstant: 10),
            
            nameCategory.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameCategory.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 10),
            
            money.centerYAnchor.constraint(equalTo: centerYAnchor),
            money.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
}
