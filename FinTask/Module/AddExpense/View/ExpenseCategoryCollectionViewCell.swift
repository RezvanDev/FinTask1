//
//  ExpenseCategoryCollectionViewCell.swift
//  FinTask
//
//  Created by Иван Незговоров on 29.06.2024.
//

import UIKit

class ExpenseCategoryCollectionViewCell: UICollectionViewCell, CellProtocols {
    
    static var reuseId: String = "ExpenseCategoryCollectionViewCell"
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "folder")
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var viewMain: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        view.layer.borderWidth = 3.0  // Толщина бордюра
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = 24
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with category: CategoryExpense) {
        title.text = category.name
        image.image = UIImage(named: category.image)
        if let color = UIColor(hexString: category.colorString) {
            viewMain.backgroundColor = color
        }
        viewMain.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func setup() {
        addSubview(title)
        addSubview(viewMain)
        viewMain.addSubview(image)
        
        NSLayoutConstraint.activate([
            
            viewMain.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            viewMain.heightAnchor.constraint(equalToConstant: 48),
            viewMain.widthAnchor.constraint(equalToConstant: 48),
            viewMain.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            image.centerYAnchor.constraint(equalTo: viewMain.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: viewMain.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 47),
            image.widthAnchor.constraint(equalToConstant: 47),
            
            
            title.topAnchor.constraint(equalTo: viewMain.bottomAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override var isSelected: Bool {
            didSet {
                // При изменении isSelected, обновляем цвет бордюра viewMain
                if isSelected {
                    viewMain.layer.borderColor = AppColors.mainGreen.cgColor
                } else {
                    viewMain.layer.borderColor = UIColor.clear.cgColor
                }
            }
        }
}
