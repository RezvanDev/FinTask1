//
//  SettingsViewController.swift
//  FinTask
//
//  Created by Timofey on 30.06.24.
//

import UIKit

class SettingsViewController: UITableViewController {
    
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
        
        //settingsTitle contraints
        NSLayoutConstraint.activate([
            settingsTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        //regestration of cell
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
    }
    //main settings title
    private lazy var settingsTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.text = "Настройки"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //возращает количество ячеек
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return settingsCell.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        let item = settingsCell[indexPath.row]
        //cell.configure(item)
        return cell
    }
}
