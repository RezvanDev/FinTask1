//
//  SavingViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 03.07.2024.
//

import UIKit

class SavingViewController: UIViewController {
    
    private var savings: [Saving]?
    var closure: ((Bool) -> ())?
    
    private lazy var titleMain: UILabel = {
        let lbl = UILabel()
        lbl.text = "Накопления"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return lbl
    }()
    private lazy var savingNotTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Накоплений нет"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.isHidden = true
        return lbl
    }()
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(SavingTableViewCell.self, forCellReuseIdentifier: SavingTableViewCell.reuseId)
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
        setup()
        fetchSavings()
    }
}

// MARK: -- Setup Layer
private extension SavingViewController {
    func setup() {
        view.backgroundColor = .white
        setupTitleMain()
        setupSavingNotTitle()
        setupTableView()
        view.addSubview(buttonAppend)
    }
    
    // Setup title main
    func setupTitleMain() {
        view.addSubview(titleMain)
        
        NSLayoutConstraint.activate([
            titleMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    // Setup saving not title
    func setupSavingNotTitle() {
        // logic work with this title
        //
        //
        
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
private extension SavingViewController {
    func fetchSavings() {
        savings = StorageManager.shared.getSavings()
    }
}

// MARK: -- Objc methods
private extension SavingViewController {
    @objc func buttonAppendTap() {
        let vc = AddSavingViewController()
        vc.closure = { [weak self] res in
            if res {
                self?.fetchSavings()
                self?.tableView.reloadData()
            }
        }
        
        present(vc, animated: true)
    }
}

extension SavingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        savings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavingTableViewCell.reuseId, for: indexPath) as! SavingTableViewCell
        guard let savings else { return UITableViewCell() }
        let provaider = savings[indexPath.section]
        cell.selectionStyle = .none
        cell.configure(saving: provaider)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditSavingViewController()
        let provaider = savings![indexPath.section]
        vc.currentSaving = provaider
        vc.closure = {[weak self] res in
            if res {
                self?.fetchSavings()
                self?.tableView.reloadData()
                self?.closure?(true)
            }
        }
        present(vc, animated: true)
    }
}
