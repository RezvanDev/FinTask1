//
//  MontlyPaymentHomeCollectionViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 04.07.2024.
//

import UIKit

class MontlyPaymentHomeCollectionViewCell: UICollectionViewCell, CellProtocols {
    
    static var reuseId: String = "MontlyPaymentHomeCollectionViewCell"
    private lazy var leftMain: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "test"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    private lazy var moneyTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "test"
        lbl.numberOfLines = 2
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
    
    func config(monthlyPayment: MonthlyPayment) {
        title.text = monthlyPayment.name
        moneyTitle.text = "\(monthlyPayment.amount) \n \(Helpers.shared.formatDate(monthlyPayment.date))"
    }
    
    private func setup() {
        addSubview(leftMain)
        addSubview(title)
        addSubview(moneyTitle)
            
        NSLayoutConstraint.activate([
            leftMain.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            leftMain.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            leftMain.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            leftMain.widthAnchor.constraint(equalToConstant: 5),
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: leftMain.trailingAnchor, constant: 10),
            
            moneyTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            moneyTitle.leadingAnchor.constraint(equalTo: leftMain.trailingAnchor, constant: 10)
            
        ])
    }
}
