//
//  SubscribeCollectionViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 06.07.2024.
//

import UIKit

class SubscribeCollectionViewCell: UICollectionViewCell, CellProtocols {
    
    static var reuseId: String = "SubscribeCollectionViewCell"
    
    private let imageView: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFit
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
     
     private let textLabel: UILabel = {
         let label = UILabel()
         label.textAlignment = .center
         label.font = UIFont.systemFont(ofSize: 16)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         contentView.addSubview(imageView)
         contentView.addSubview(textLabel)
         
         NSLayoutConstraint.activate([
             imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
             imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
             imageView.heightAnchor.constraint(equalToConstant: 100),
             
             textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
             textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
         ])
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func configure(imageName: String, text: String) {
         imageView.image = UIImage(named: imageName)
         textLabel.text = text
     }
 }


