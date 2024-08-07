//
//  HomeCollectionCollectionViewCellSecondLast.swift
//  FinTask
//
//  Created by Иван Незговоров on 03.07.2024.
//

import UIKit

class HomeCollectionCollectionViewCellSecondLast: UICollectionViewCell, CellProtocols {
    
    static var reuseId: String = "HomeCollectionCollectionViewCellSecondLast"
    
    private var savings: [Saving]?
    private var timer: Timer?
    private var currentIndex = 0
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "folder")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "test"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
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
        collection.register(SavingHomeCollectionViewCell.self, forCellWithReuseIdentifier: SavingHomeCollectionViewCell.reuseId)
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
    
    func configure(image: UIImage, text: String, savings: [Saving]?) {
        self.image.image = image
        self.title.text = text
        self.savings = savings
        collectionSaving.reloadData()
    }
}

// Setup layer
private extension HomeCollectionCollectionViewCellSecondLast {
    func setup() {
        addSubview(image)
        addSubview(title)
        addSubview(collectionSaving)
        setupConstraints()
        setupBorders()
    }
    
    // setup constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50),
            
            title.centerYAnchor.constraint(equalTo: image.centerYAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            
            collectionSaving.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            collectionSaving.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            collectionSaving.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            collectionSaving.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    // setup borders
    func setupBorders() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
    }
    
}

// MARK: -- UICollectionViewDelegate, UICollectionViewDataSource
extension HomeCollectionCollectionViewCellSecondLast: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        savings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavingHomeCollectionViewCell.reuseId, for: indexPath) as! SavingHomeCollectionViewCell
        let provaider = savings![indexPath.row]
        cell.config(saving: provaider)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeCollectionCollectionViewCellSecondLast: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 80) // Adjust item size as needed
    }
}
