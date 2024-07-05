//
//  IconSelectionViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 05.07.2024.
//

import UIKit

protocol IconSelectionDelegate: AnyObject {
    func didIcon(_ icon: String)
}

class IconSelectionViewController: UIViewController {
    
    weak var delegate: IconSelectionDelegate?
    private var icon: String?
    var isIncome: Bool = true
    private let iconsExpense: [String] = [
        "bisness", "car", "entertainment", "food", "gift1", "meal", "transfer"
    ]
    private let iconsIncome: [String] = [
        "bank", "freelance", "gift", "work"
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
        collectionView.register(IconSelectionCollectionViewCell.self, forCellWithReuseIdentifier: IconSelectionCollectionViewCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: -- Setup Layer
private extension IconSelectionViewController {
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
extension IconSelectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isIncome {
            return iconsIncome.count
        } else {
            return iconsExpense.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconSelectionCollectionViewCell.reuseId, for: indexPath) as! IconSelectionCollectionViewCell
        
        var icon: String = ""
        
        if isIncome {
            icon = iconsIncome[indexPath.row]
        } else {
            icon = iconsExpense[indexPath.row]
        }
        
        cell.configure(with: icon)
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
    
        if isIncome {
            icon = iconsIncome[indexPath.row]
        } else {
            icon = iconsExpense[indexPath.row]
        }
        
        delegate?.didIcon(icon!)
        collectionView.reloadItems(at: indexPathsToReload)
        
    }
}

// MARK: -- Objc
private extension IconSelectionViewController {
    @objc func cancelButtonTap() {
        dismiss(animated: true)
    }
    @objc func saveButtonTap() {
        if icon != nil {
            dismiss(animated: true)
        } else {
            Alerts.shared.alertSetColorError(title: "Ошибка", decription: "Выберите иконку", presenter: self)
        }
    }
}

