//
//  SettingsViewController.swift
//  FinTask
//
//  Created by Timofey on 30.06.24.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var tapGesture: UITapGestureRecognizer?
    
    private lazy var settingsCell: [(image: UIImage?, title: String)] = [
        (UIImage(systemName: "square.and.arrow.up"),"Категории расходов"),
        (UIImage(systemName: "square.and.arrow.down"),"Категории доходов"),
        (UIImage(systemName: "dollarsign.circle"),"Валюта по умолчанию"),
        (UIImage(systemName: "globe"),"Язык интерфейса"),
        (UIImage(named: "sliders"),"Дополнительно")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(settingsTitle)
        view.addSubview(tableView)
        view.addSubview(mainView)
        view.addSubview(clearMainView)
        view.addSubview(supportButton)
        mainView.addSubview(premiumStackView)
        premiumStackView.addArrangedSubview(crownImageView)
        premiumStackView.addArrangedSubview(premiumLabel)
        
        //MARK: --Constraints
        //settingsTitle constraints
        NSLayoutConstraint.activate([
            settingsTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            settingsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            //table constraints
            tableView.topAnchor.constraint(equalTo: settingsTitle.bottomAnchor, constant: 200),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 500),
            
            //mainView constraints
            mainView.topAnchor.constraint(equalTo: settingsTitle.bottomAnchor, constant: 16),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainView.heightAnchor.constraint(equalToConstant: 150),
            
            //stackView constraints
            premiumStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            premiumStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15),
            premiumStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            premiumStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            premiumStackView.heightAnchor.constraint(equalToConstant: 100),
            premiumStackView.widthAnchor.constraint(equalToConstant: 120),
            
            //crownImage constraints
            crownImageView.heightAnchor.constraint(equalToConstant: 10),
            crownImageView.widthAnchor.constraint(equalToConstant: 100),
            
            //clearMainView constraints
            clearMainView.topAnchor.constraint(equalTo: view.topAnchor),
            clearMainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            clearMainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            clearMainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //supportButton constraints
            supportButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            supportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            supportButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            supportButton.heightAnchor.constraint(equalToConstant: 50),
            supportButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
        
    }
    
    //MARK: --ViewSetup
    //main settings title
    private lazy var settingsTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lbl.text = "Настройки"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var tableView: UITableView = {
        let tbView = UITableView()
        tbView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseId)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.translatesAutoresizingMaskIntoConstraints = false
        tbView.layer.cornerRadius = 20
        tbView.isScrollEnabled = false
        return tbView
    }()
    
    //setup mainView
    private lazy var mainView: UIView = {
        let mainObj = UIView()
        mainObj.backgroundColor = AppColors.mainGreen
        mainObj.translatesAutoresizingMaskIntoConstraints = false
        mainObj.layer.cornerRadius = 20
        return mainObj
    }()
    
    //setup buyPremiumLabel
    private lazy var premiumLabel: UILabel = {
        let label = UILabel()
        label.text = "Купить премиум"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    //setup stackView
    private lazy var premiumStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 23
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //setup crown image
    private lazy var crownImageView: UIImageView = {
        let mainImg = UIImageView()
        mainImg.image = UIImage(named: "crown")
        mainImg.translatesAutoresizingMaskIntoConstraints = false
        mainImg.contentMode = .scaleAspectFill
        return mainImg
    }()
    
    //setup clearMainView
    private lazy var clearMainView: UIView = {
        let clearView = UIView()
        clearView.backgroundColor = .clear
        clearView.translatesAutoresizingMaskIntoConstraints = false
        return clearView
    }()
    
    //setup supportButton
    private lazy var supportButton: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = AppColors.mediumGreen
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // setup gesture
    func setupTapGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        clearMainView.addGestureRecognizer(tapGesture!)
        tapGesture?.isEnabled = false
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        settingsCell.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseId, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        let item = settingsCell[indexPath.section]
        
        //rounded edges
        if indexPath.section == 4 ? true: false {
            let cornerRadius: CGFloat = 20.0
            let maskPath = UIBezierPath(roundedRect: cell.bounds,
                                        byRoundingCorners: [.bottomLeft, .bottomRight],
                                        cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            cell.layer.mask = maskLayer
        }
        
        cell.configure(contact: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    //MARK: --Objc
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let vc = HomeViewController()
        present(vc, animated: true)
    }
    
}
