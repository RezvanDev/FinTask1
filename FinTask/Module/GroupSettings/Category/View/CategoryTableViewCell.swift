//
//  CategoryTableViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 05.07.2024.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "CategoryTableViewCell"
    
    private lazy var imageMain: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var nameTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lbl.tintColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var viewColor: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    private lazy var arrowLeft: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(item: Any) {
        if let category  = item as? CategoryExpense {
            nameTitle.text = category.name
            imageMain.image = UIImage(named: category.image)
            viewColor.backgroundColor = UIColor(hexString: category.colorString)
        } else if let category = item as? CategoryIncome {
            nameTitle.text = category.name
            imageMain.image = UIImage(named: category.image)
            viewColor.backgroundColor = UIColor(hexString: category.colorString)
        }
    }
    
}

// MARK: -- Setup layer
private extension CategoryTableViewCell {
    func setup() {
        addSubview(imageMain)
        addSubview(nameTitle)
        addSubview(viewColor)
        addSubview(arrowLeft)
        
        NSLayoutConstraint.activate([
            imageMain.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageMain.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageMain.heightAnchor.constraint(equalToConstant: 25),
            imageMain.widthAnchor.constraint(equalToConstant: 25),
            
            nameTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameTitle.leadingAnchor.constraint(equalTo: imageMain.trailingAnchor, constant: 20),
            nameTitle.widthAnchor.constraint(equalToConstant: 100),
            
            viewColor.centerYAnchor.constraint(equalTo: centerYAnchor),
            viewColor.leadingAnchor.constraint(equalTo: nameTitle.trailingAnchor, constant: 5),
            viewColor.heightAnchor.constraint(equalToConstant: 20),
            viewColor.widthAnchor.constraint(equalToConstant: 20),
           
            arrowLeft.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowLeft.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            arrowLeft.heightAnchor.constraint(equalToConstant: 20),
            arrowLeft.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}
