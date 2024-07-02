//
//  SettingsTableViewCell.swift
//  FinTask
//
//  Created by Timofey on 30.06.24.
//

import UIKit

class SettingsTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "SettingsTableViewCell"
    
    private lazy var chevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Test"
        lbl.font = .systemFont(ofSize: 20, weight: .regular)
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
        [chevronIcon, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            chevronIcon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            chevronIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            chevronIcon.heightAnchor.constraint(equalToConstant: 30),
            chevronIcon.widthAnchor.constraint(equalToConstant: 30),
            
            //title label constraints
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            
            //
        ])
    }
    
    func configure(contact: (image: UIImage?, title: String)) {
        
    }
    
}
