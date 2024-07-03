//
//  SavingTableViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 03.07.2024.
//

import UIKit

class SavingTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "SavingTableViewCell"
    
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
    private lazy var savingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.lightGrayForSavigcells
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    private let filledView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
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
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(saving: Saving) {
        nameSaving.text = saving.name
        countSaving.text = String(saving.haveAmount) + " / " + String(saving.needAmount)
            
        if saving.haveAmount > 0 {
            let ratio = min(Double(saving.haveAmount) / Double(saving.needAmount), 1.0)
            updateProgressBar(ratio: ratio)
        }
    }
    
    private func setup() {
        addSubview(backgroundMainView)
        backgroundMainView.addSubview(stackVLabels)
        stackVLabels.addArrangedSubview(nameSaving)
        stackVLabels.addArrangedSubview(countSaving)
        backgroundMainView.addSubview(savingView)
        savingView.addSubview(filledView)
        
        NSLayoutConstraint.activate([
        
            backgroundMainView.topAnchor.constraint(equalTo: topAnchor),
            backgroundMainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundMainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundMainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackVLabels.topAnchor.constraint(equalTo: backgroundMainView.topAnchor, constant: 20),
            stackVLabels.leadingAnchor.constraint(equalTo: backgroundMainView.leadingAnchor, constant: 20),
            stackVLabels.trailingAnchor.constraint(equalTo: backgroundMainView.trailingAnchor, constant: -20),
            
            
            savingView.topAnchor.constraint(equalTo: stackVLabels.bottomAnchor, constant: 20),
            savingView.leadingAnchor.constraint(equalTo: backgroundMainView.leadingAnchor, constant: 20),
            savingView.trailingAnchor.constraint(equalTo: backgroundMainView.trailingAnchor, constant: -20),
            savingView.heightAnchor.constraint(equalToConstant: 5),
            
            filledView.topAnchor.constraint(equalTo: savingView.topAnchor),
            filledView.leadingAnchor.constraint(equalTo: savingView.leadingAnchor),
            filledView.bottomAnchor.constraint(equalTo: savingView.bottomAnchor),
        ])
    }
    
    private func updateProgressBar(ratio: Double) {
        self.filledView.widthAnchor.constraint(equalTo: self.savingView.widthAnchor, multiplier: CGFloat(ratio)).isActive = true
        self.layoutIfNeeded()
    }
}
