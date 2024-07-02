//
//  SettingsViewController.swift
//  FinTask
//
//  Created by Timofey on 30.06.24.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var settingsCell: [(image: UIImage?, title: String)] = [
        (UIImage(systemName: "wallet"),"Категории расходов"),
        (UIImage(systemName: "chart.bar"),"Категории расходов"),
        (UIImage(systemName: "dollarsign.circle"),"Валюта по умолчанию"),
        (UIImage(systemName: "globe"),"Язык интерфейса"),
        (UIImage(systemName: "sliders.horizontal"),"Дополнительно")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(settingsTitle)
        view.addSubview(tableView)
        //settingsTitle constraints
        NSLayoutConstraint.activate([
            settingsTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            settingsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            //table constraints
            tableView.topAnchor.constraint(equalTo: settingsTitle.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
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
        return tbView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseId, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        let item = settingsCell[indexPath.row]
        cell.configure(contact: item)
        return cell
    }
}
