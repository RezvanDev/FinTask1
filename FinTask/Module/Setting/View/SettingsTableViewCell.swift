//
//  SettingsTableViewCell.swift
//  FinTask
//
//  Created by Timofey on 30.06.24.
//

import UIKit

class SettingsTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "SettingsTableViewCell"
    
    private lazy var iconImage: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "folder")
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Test"
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [iconImage, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        backgroundColor = AppColors.lightGrayMain
        // 1  Нужно чтобы были не ячейки а секции и в каждой секции ячейка
        NSLayoutConstraint.activate([
            
            //title label constraints
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 80),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            //iconImage constraints
            iconImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalToConstant: 35),
            iconImage.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func configure(contact: (image: UIImage?, title: String)) {
        print(contact.title)
        iconImage.image = contact.image
        titleLabel.text = contact.title
        
    }
    
}//recognizer
