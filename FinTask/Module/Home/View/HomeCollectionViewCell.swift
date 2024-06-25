//
//  HomeCollectionViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 25.06.2024.
//

import UIKit


class HomeCollectionViewCell: UICollectionViewCell, CellProtocols {
    
    static var reuseId = "HomeCollectionViewCell"
    
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage, text: String) {
        self.image.image = image
        self.title.text = text
    }
    
    // setup
    private func setup() {
        addSubview(image)
        addSubview(title)
        setupConstraints()
        setupBorders()
    }
    
    // setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50),
            
            title.centerYAnchor.constraint(equalTo: image.centerYAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }
    
    // setup borders
    private func setupBorders() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
    }
    
}

