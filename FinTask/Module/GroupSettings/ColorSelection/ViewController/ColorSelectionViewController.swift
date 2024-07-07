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
    private let colors = ColorModel().hexColors
    private var selectedIndexPath: IndexPath?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        button.setTitle(String(localized: "Cancel"), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 110, y: 0, width: 100, height: 45))
        button.setTitle(String(localized: "Save"), for: .normal)
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
            Alerts.shared.alertSetColorError(title: String(localized: "Error"), decription: String(localized: "Choose_Color"), presenter: self)
        }
    }
}


