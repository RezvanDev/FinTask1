//
//  FinanceTableViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 26.06.2024.
//

import UIKit

class FinanceTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "FinanceTableViewCell"
    
    private lazy var imageIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "folder")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = image.bounds.height / 2
        return image
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var categoryTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Category"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    private lazy var note: UILabel = {
        let lbl = UILabel()
        lbl.text = "Note"
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .light)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    private lazy var moneyCount: UILabel = {
        let lbl = UILabel()
        lbl.text = "0.0$"
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: Any, data: AnyObject) {
        if let category = category as? CategoryIncome {
            categoryTitle.text = category.name
        } else if let category = category as? CategoryExpense {
            categoryTitle.text = category.name
        }
        
        if let income = data as? Income {
            note.text = income.note
            moneyCount.text = String(income.amount)
        } else if let expense = data as? Expense {
            note.text = expense.note
            moneyCount.text = String(expense.amount)
        }
    }
    
    private func setup() {
        addSubview(imageIcon)
        addSubview(vStack)
        vStack.addArrangedSubview(categoryTitle)
        vStack.addArrangedSubview(note)
        addSubview(moneyCount)
        
        NSLayoutConstraint.activate([
            imageIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageIcon.heightAnchor.constraint(equalToConstant: 50),
            imageIcon.widthAnchor.constraint(equalToConstant: 50),
            
            vStack.centerYAnchor.constraint(equalTo: imageIcon.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: imageIcon.leadingAnchor, constant: 60),
            moneyCount.centerYAnchor.constraint(equalTo: imageIcon.centerYAnchor),
            moneyCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
    
}
