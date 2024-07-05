//
//  ColorSelectionViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 05.07.2024.
//

import UIKit

protocol ColorSelectionDelegate: AnyObject {
    func didSelectColor(_ color: String)
}

class ColorSelectionViewController: UIViewController {
    
    weak var delegate: ColorSelectionDelegate?
    private var hexColor: String?
    private let colors: [String] = [
        "#FFF8DC", "#F4A460", "#DC143C", "#FF6347", "#00FFFF", "#FFE4B5",
        "#FF00FF", "#6B8E23", "#ebad81", "#6A5ACD", "#32CD32",
        "#ADFF2F",  "#32CD32",
        "#98FB98", "#00FA9A", "#00FF7F", "#66CDAA", "#8FBC8F", "#20B2AA",
        "#87CEFA", "#1E90FF", "#0000FF", "#000080", "#800080", "#EE82EE",
        "#FF00FF",  "#B22222", "#FFA07A", "#FA8072",
        "#E9967A", "#F08080", "#CD5C5C", "#DC143C", "#F5F5F5", "#D3D3D3",
        "#C0C0C0", "#A9A9A9", "#696969",
        "#FFB3BA", "#FFDFBA", "#FFFFBA", "#BAFFC9", "#BAE1FF", "#E6E6FA",
        "#FFD1DC", "#E0BBE4", "#957DAD", "#D291BC", "#FEC8D8", "#FFDFD3",
        "#FFE4E1", "#FFFACD", "#FAFAD2", "#D8BFD8", "#E0FFFF", "#F0E68C",
        "#F5DEB3", "#FFDEAD",
        "#FFFF00", // Yellow
        "#EE82EE", // Violet
        "#FFC0CB", // Pink
        "#FFB6C1", // Light Pink
        "#FFFFE0", // Light Yellow
        "#FF0000", // Red
        "#FFA07A", // Light Red
        "#FFD700", // Bright Yellow
        "#FF4500", // Orange
        "#FF6347"  // Bright Red
    ]
    private var selectedIndexPath: IndexPath?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 100, y: 0, width: 100, height: 45))
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(AppColors.mainGreen, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ColorSelectionCollectionViewCell.self, forCellWithReuseIdentifier: ColorSelectionCollectionViewCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: -- Setup Layer
private extension ColorSelectionViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        setupCollectionView()
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: -- UICollectionViewDataSource, UICollectionViewDelegate
extension ColorSelectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorSelectionCollectionViewCell.reuseId, for: indexPath) as! ColorSelectionCollectionViewCell
        let hexColor = colors[indexPath.item]
        cell.configure(with: UIColor(hexString: hexColor))
        cell.layer.borderWidth = (indexPath == selectedIndexPath) ? 2 : 0
        cell.layer.borderColor = (indexPath == selectedIndexPath) ? UIColor.black.cgColor : nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        var indexPathsToReload = [indexPath]
        if let previousIndexPath = previousIndexPath {
            indexPathsToReload.append(previousIndexPath)
        }
        hexColor = colors[indexPath.item]
        delegate?.didSelectColor(hexColor!)
        collectionView.reloadItems(at: indexPathsToReload)
        
    }
}

// MARK: -- Objc
private extension ColorSelectionViewController {
    @objc func cancelButtonTap() {
        dismiss(animated: true)
    }
    @objc func saveButtonTap() {
        if hexColor != nil {
            dismiss(animated: true)
        } else {
            Alerts.shared.alertSetColorError(title: "Ошибка", decription: "Выберите цвет", presenter: self)
        }
    }
}


