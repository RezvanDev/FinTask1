//
//  MonthlyPaymentTableViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 04.07.2024.
//

import UIKit

class MonthlyPaymentTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "MonthlyPaymentTableViewCell"
    
    private lazy var nameSaving: UILabel = {
        let lbl = UILabel()
        lbl.text = "Test"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var countSaving: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        lbl.text = "test / test"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var stackVLabels: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var backgroundMainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = AppColors.grayForSavigCells
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func configure(item: MonthlyPayment) {
        nameSaving.text = item.name
        countSaving.text = "\(item.amount) / \(Helpers.shared.formatDate(item.date))"
    }
    
    private func setup() {
        addSubview(backgroundMainView)
        backgroundMainView.addSubview(stackVLabels)
        stackVLabels.addArrangedSubview(nameSaving)
        stackVLabels.addArrangedSubview(countSaving)
        
        NSLayoutConstraint.activate([
        
            backgroundMainView.topAnchor.constraint(equalTo: topAnchor),
            backgroundMainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundMainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundMainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackVLabels.topAnchor.constraint(equalTo: backgroundMainView.topAnchor, constant: 30),
            stackVLabels.leadingAnchor.constraint(equalTo: backgroundMainView.leadingAnchor, constant: 20),
            stackVLabels.trailingAnchor.constraint(equalTo: backgroundMainView.trailingAnchor, constant: -20),
        ])
    }
}
