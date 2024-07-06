//
//  SubscribeTableViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 06.07.2024.
//

import UIKit

class SubscribeTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "SubscribeTableViewCell"
    
    private lazy var firstLBL: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = AppColors.mainGreen
        return lbl
    }()
    private lazy var secondLBL: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        return lbl
    }()
    
    var cornerRadius: CGFloat = 20 {
          didSet {
              layer.cornerRadius = cornerRadius
              layer.masksToBounds = true
          }
      }
    
    var borderColor: UIColor = .clear {
           didSet {
               layer.borderColor = borderColor.cgColor
           }
       }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: SubscribeTable, isFirst: Bool) {
        firstLBL.text = item.firstLBL
        secondLBL.text = item.secondLBL
        if isFirst {
            backgroundColor = AppColors.mainGreen
            firstLBL.textColor = .white
            secondLBL.textColor = .white
        } else {
            firstLBL.textColor = AppColors.mainGreen
            secondLBL.textColor = .black
        }
    }
    
    private func setup() {
        addSubview(firstLBL)
        addSubview(secondLBL)
        layer.borderWidth = 2.0
    
        
        NSLayoutConstraint.activate([
            firstLBL.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            firstLBL.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            secondLBL.topAnchor.constraint(equalTo: firstLBL.bottomAnchor, constant: 5),
            secondLBL.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
    
}
