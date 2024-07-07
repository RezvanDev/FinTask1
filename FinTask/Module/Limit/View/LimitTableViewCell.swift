//
//  LimitTableViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 01.07.2024.
//

import UIKit

class LimitTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "LimitTableViewCell"
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "test"
        lbl.numberOfLines = 1
        return lbl
    }()
    private lazy var imageMain: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "folder")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var setLimitButton: UIButton = {
        let button = UIButton()
        button.setTitle(String(localized: "Limit_Set_Limit_Button"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var limitView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var filledView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var allExpensesText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        return label
    }()
    private lazy var limitText: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(category: CategoryExpense) {
        title.text = category.name
        imageMain.image = UIImage(named: category.image)
        
        // Получаем начало и конец текущего месяца
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        let currentMonthExpenses = category.expenses.filter("date >= %@ AND date <= %@", startOfMonth, endOfMonth)
        let totalExpenses = currentMonthExpenses.reduce(0) { $0 + $1.amount }
        
        if category.limits > 0 {
            let ratio = min(Double(totalExpenses) / category.limits, 1.0)
            updateProgressBar(ratio: ratio)
            
            allExpensesText.text = String(totalExpenses)
            limitText.text = String(category.limits)
            
            allExpensesText.isHidden = false
            limitText.isHidden = false
            setLimitButton.isHidden = true
            limitView.isHidden = false
        } else {
            allExpensesText.isHidden = true
            limitText.isHidden = true
            limitView.isHidden = true
            setLimitButton.isHidden = false
        }
    }
    
    private func setup() {
        addSubview(mainView)
        mainView.addSubview(imageMain)
        mainView.addSubview(title)
        mainView.addSubview(limitView)
        limitView.addSubview(filledView)
        filledView.addSubview(percentageLabel)
        mainView.addSubview(setLimitButton)
        mainView.addSubview(allExpensesText)
        mainView.addSubview(limitText)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageMain.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            imageMain.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            imageMain.heightAnchor.constraint(equalToConstant: 30),
            imageMain.widthAnchor.constraint(equalToConstant: 30),
            
            title.topAnchor.constraint(equalTo: imageMain.bottomAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.widthAnchor.constraint(equalToConstant: 100),
            
            
            limitView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 10),
            limitView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 20),
            limitView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            limitView.heightAnchor.constraint(equalToConstant: 30),
            
            filledView.topAnchor.constraint(equalTo: limitView.topAnchor),
            filledView.leadingAnchor.constraint(equalTo: limitView.leadingAnchor),
            filledView.bottomAnchor.constraint(equalTo: limitView.bottomAnchor),
            
            percentageLabel.centerYAnchor.constraint(equalTo: limitView.centerYAnchor),
            percentageLabel.leadingAnchor.constraint(equalTo: limitView.leadingAnchor, constant: 4),
            percentageLabel.trailingAnchor.constraint(equalTo: limitView.trailingAnchor, constant: -4),
            
            setLimitButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            setLimitButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            
            allExpensesText.bottomAnchor.constraint(equalTo: limitView.topAnchor, constant: -5),
            allExpensesText.leadingAnchor.constraint(equalTo: limitView.leadingAnchor),
            
            limitText.bottomAnchor.constraint(equalTo: limitView.topAnchor, constant: -5),
            limitText.trailingAnchor.constraint(equalTo: limitView.trailingAnchor),
        ])
    }
    private func updateProgressBar(ratio: Double) {
        let percentText = String(format: "%.0f%%", ratio * 100)
        percentageLabel.text = percentText
        
        
        self.filledView.widthAnchor.constraint(equalTo: self.limitView.widthAnchor, multiplier: CGFloat(ratio)).isActive = true
        self.layoutIfNeeded()
    }
    
}

