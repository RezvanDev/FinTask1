//
//  HomeViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 24.06.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Data
    let homeModelCellMockData = HomeModelCellMockData()
    let homeModelDate = HomeModelDate()
    
    // header view background
    private lazy var headerViewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.mainGreen
        return view
    }()
    
    
    // header view
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var imageHeaderView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        return image
    }()
    private lazy var titleHeaderView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FinTask"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        label.tintColor = .black
        return label
    }()
    
    // label on view background
    private lazy var mainTextOnViewBackground: UILabel = {
        let label = UILabel()
        label.text = "Основной счет"
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        
        label.tintColor = .black
        return label
    }()
    private lazy var countTextOnViewBackground: UILabel = {
        let label = UILabel()
        label.text = "RUB   0000.00"
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        
        label.tintColor = .black
        return label
    }()
    
    // collection view
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width / 2) - 30, height: (view.bounds.width / 2) - 50)
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseId)
        collection.register(HomeCollectionCollectionViewCellSecondLast.self, forCellWithReuseIdentifier: HomeCollectionCollectionViewCellSecondLast.reuseId)
        collection.register(HomeCollectionViewCellLast.self, forCellWithReuseIdentifier: HomeCollectionViewCellLast.reuseId)
        return collection
    }()
    
    // view end day
    private lazy var viewTime: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = AppColors.lightGrayMain
        return view
    }()
    private lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium, width: .compressed)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Test"
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timeLabel.text = homeModelDate.timeUntilEndOfDay()
        fetchData()
    }
    
}

// MARK: -- Set layer
private extension HomeViewController {
    
    func setup() {
        view.backgroundColor = .white
        fetchData()
        setupConstraintsHeaderViewBackground()
        setupHeaderView()
        setupLabelsOnViewBackground()
        setupCollectionView()
        setupViewTime()
        setupHeaderDate()
    }
    
    // setup constraints header view background
    func setupConstraintsHeaderViewBackground() {
        view.addSubview(headerViewBackground)
        
        NSLayoutConstraint.activate([
            headerViewBackground.topAnchor.constraint(equalTo: view.topAnchor),
            headerViewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerViewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerViewBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
    }
    
    // setup constraints header view
    func setupHeaderView() {
        view.addSubview(headerView)
        headerView.addSubview(imageHeaderView)
        headerView.addSubview(titleHeaderView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            imageHeaderView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            imageHeaderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            imageHeaderView.heightAnchor.constraint(equalToConstant: 50),
            imageHeaderView.widthAnchor.constraint(equalToConstant: 50),
            
            titleHeaderView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 5),
            titleHeaderView.leadingAnchor.constraint(equalTo: imageHeaderView.trailingAnchor)
        ])
    }
    
    // setup constraints labels on view background
    func setupLabelsOnViewBackground() {
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.alignment = .leading
            stack.distribution = .fill
            stack.spacing = 10
            stack.addArrangedSubview(mainTextOnViewBackground)
            stack.addArrangedSubview(countTextOnViewBackground)
            return stack
        }()
        
        headerViewBackground.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    // setup constraints collection
    func setupCollectionView() {
        view.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerViewBackground.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40)
        ])
    }
    
    // setup constraints view time
    func setupViewTime() {
        view.addSubview(viewTime)
        viewTime.addSubview(timeLabel)
        timeLabel.text = homeModelDate.timeUntilEndOfDay()
        
        NSLayoutConstraint.activate([
            viewTime.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            viewTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            viewTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            viewTime.heightAnchor.constraint(equalToConstant: 50),
            
            timeLabel.centerYAnchor.constraint(equalTo: viewTime.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: viewTime.leadingAnchor, constant: 5),
            timeLabel.trailingAnchor.constraint(equalTo: viewTime.trailingAnchor, constant: 5)
        ])
    }
    
    func setupHeaderDate() {
        // guard let user = StorageManager.shared.getUser() else { return }
        // сделать чтобы данные в header загружались
        // countTextOnViewBackground.text = user.wallets.
    }
}

// MARK: -- UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeModelCellMockData.homeModelCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseId, for: indexPath) as! HomeCollectionViewCell
            
            let provaider = homeModelCellMockData.homeModelCells
            let data: [Double] = [StorageManager.shared.totalIncome(), StorageManager.shared.totalExpense(), StorageManager.shared.totalSavings()]
            
            cell.configure(image: provaider[indexPath.row].image, text: provaider[indexPath.row].title, data: String(data[indexPath.row]))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellLast.reuseId, for: indexPath)
            return cell
        }
    }
}


