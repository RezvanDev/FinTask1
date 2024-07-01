//
//  SettingsTableViewCell.swift
//  FinTask
//
//  Created by Timofey on 30.06.24.
//

import UIKit

class SettingsTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "SettingsTableViewCell"
    
    //UI elements
    private lazy var imageIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "crown")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage?, title: String) {
        //setup the elements
    }
    
}
