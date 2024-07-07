//
//  HomeCollectionViewCellLast.swift
//  FinTask
//
//  Created by Иван Незговоров on 26.06.2024.
//

import UIKit

class HomeCollectionViewCellLast: UICollectionViewCell, CellProtocols {
    
    static var reuseId: String = "HomeCollectionViewCellLast"
    var monthlyPayment: [MonthlyPayment]?
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.text = String(localized: "Main_Cell_Monthly_Payment")
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var collectionSaving: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.register(MontlyPaymentHomeCollectionViewCell.self, forCellWithReuseIdentifier: MontlyPaymentHomeCollectionViewCell.reuseId)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(monthlyPayments: [MonthlyPayment]) {
        monthlyPayment = monthlyPayments
        collectionSaving.reloadData()
    }
    
    
    private func setup() {
        addSubview(title)
        addSubview(collectionSaving)
        setupBorders()
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            collectionSaving.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            collectionSaving.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            collectionSaving.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            collectionSaving.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    private func setupBorders() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
    }
}

// MARK: -- UICollectionViewDelegate, UICollectionViewDataSource
extension HomeCollectionViewCellLast: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        monthlyPayment?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MontlyPaymentHomeCollectionViewCell.reuseId, for: indexPath) as! MontlyPaymentHomeCollectionViewCell
        let provaider = monthlyPayment![indexPath.row]
        cell.config(monthlyPayment: provaider)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeCollectionViewCellLast: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 80) // Adjust item size as needed
    }
}

