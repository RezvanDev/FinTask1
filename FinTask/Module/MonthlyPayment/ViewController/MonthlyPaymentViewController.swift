//
//  MonthlyPaymentViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 04.07.2024.
//

import UIKit

class MonthlyPaymentViewController: UIViewController {

    private var monthlyPayment: [MonthlyPayment]?
    var closure: ((Bool) -> ())?
    
    private lazy var titleMain: UILabel = {
        let lbl = UILabel()
        lbl.text = "Ежемесячный платеж"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return lbl
    }()
    private lazy var savingNotTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Ежемесячных платежей нет"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(MonthlyPaymentTableViewCell.self, forCellReuseIdentifier: MonthlyPaymentTableViewCell.reuseId)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        return tv
    }()
    private lazy var buttonAppend: UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 50 - 40, y: view.bounds.height - 50 - 120, width: 70, height: 50))
        button.addTarget(self, action: #selector(buttonAppendTap), for: .touchUpInside)
        button.backgroundColor = AppColors.mainGreen
        button.layer.cornerRadius = 25
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSavings()
        setup()
    }
}


// MARK: -- Setup Layer
private extension MonthlyPaymentViewController {
    
    func setup() {
        view.backgroundColor = .white
        setupTitleMain()
        setupSavingNotTitle()
        setupTableView()
        view.addSubview(buttonAppend)
    }
    
    func setupTitleMain() {
        view.addSubview(titleMain)
        
        NSLayoutConstraint.activate([
            titleMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    // Setup saving not title
    func setupSavingNotTitle() {
        if monthlyPayment == nil || monthlyPayment?.isEmpty == true {
            tableView.isHidden = true
            savingNotTitle.isHidden = false
        } else {
            tableView.isHidden = false
            savingNotTitle.isHidden = true
        }
        view.addSubview(savingNotTitle)
        
        NSLayoutConstraint.activate([
            savingNotTitle.topAnchor.constraint(equalTo: titleMain.bottomAnchor, constant: 20),
            savingNotTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // Setup table view
    func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleMain.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

// MARK: -- Fetch
private extension MonthlyPaymentViewController {
    func fetchSavings() {
        monthlyPayment = StorageManager.shared.getAllMonthlyPayment()
        tableView.reloadData()
    }
}

// MARK: -- Objc methods
 extension MonthlyPaymentViewController {
    @objc func buttonAppendTap() {
        let addMontlyPaymentVC = AddMonthlyPaymentViewController()
        addMontlyPaymentVC.closure = {[weak self] res in
            if res {
                self?.fetchSavings()
                self?.setupSavingNotTitle()
                self?.closure?(true)
                self?.tableView.reloadData()
            }
        }
        present(addMontlyPaymentVC, animated: true)
    }
}

// MARK: -- UITableViewDelegate, UITableViewDataSource
extension MonthlyPaymentViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        monthlyPayment?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MonthlyPaymentTableViewCell.reuseId, for: indexPath) as! MonthlyPaymentTableViewCell
        let provaider = monthlyPayment![indexPath.section]
        cell.configure(item: provaider)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        113
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}
