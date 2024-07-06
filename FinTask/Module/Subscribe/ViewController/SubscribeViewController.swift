//
//  SubscribeViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 06.07.2024.
//

import UIKit

class SubscribeViewController: UIViewController {
    
    private var dataCarousel: [Subscribe]?
    private var dataTable: [SubscribeTable]?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var titleLBL: UILabel = {
        let lbl = UILabel()
        lbl.text = "Получите доступ ко всем функция в"
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return lbl
    }()
    private lazy var titleLBLChartTwo: UILabel = {
        let lbl = UILabel()
        lbl.text = "Премиум версии"
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    private lazy var lblStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.bounds.width, height: 150)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SubscribeCollectionViewCell.self, forCellWithReuseIdentifier: SubscribeCollectionViewCell.reuseId)
        return collectionView
    }()
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = dataCarousel!.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    private lazy var tableButton: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.separatorStyle = .none
        tb.delegate = self
        tb.dataSource = self
        tb.isScrollEnabled = false
        tb.register(SubscribeTableViewCell.self, forCellReuseIdentifier: SubscribeTableViewCell.reuseId)
        return tb
    }()
    private lazy var infoText: UILabel = {
        let lbl = UILabel()
        lbl.text = "Оплата будет произведена с Вашего Apple ID аккаунта. Подписка автоматически обновляется, пока она не будет отменена не позже, чем за 24 часа до конца текущего периода. Оплата за обновление подписки будет произведена втечение 24 часов до конца текущего периода. Вы можете отменить подписку в настройках аккаунта Арр Store после покупки."
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .systemGray2
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var politicsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: view.bounds.height - 160, width: 200, height: 50))
        button.setTitle("Политика \nконфиденциальности", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.titleLabel?.textAlignment = .right
        button.setTitleColor(.systemGray4, for: .normal)
        button.addTarget(self, action: #selector(openPrivacyPolicy), for: .touchUpInside)
        return button
    }()
    private lazy var userAgreeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 200, y: view.bounds.height - 160, width: 200, height: 50))
        button.setTitle("Пользовательское \nсоглашение", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.systemGray4, for: .normal)
        button.addTarget(self, action: #selector(openUserAgreement), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setup()
        SubscriptionManager.shared.fetchProducts()
    }
    
}
// MARK: -- Setup layer
private extension SubscribeViewController {
    func setup() {
        view.backgroundColor = .white
        setupStack()
        setupCollection()
        setupPageControl()
        setupTableView()
        setupInfoText()
        view.addSubview(cancelButton)
        view.addSubview(politicsButton)
        view.addSubview(userAgreeButton)
    }
    
    func setupStack() {
        view.addSubview(lblStack)
        lblStack.addArrangedSubview(titleLBL)
        lblStack.addArrangedSubview(titleLBLChartTwo)
        
        NSLayoutConstraint.activate([
            lblStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            lblStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lblStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lblStack.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupCollection() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: lblStack.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupPageControl() {
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableButton)
        
        NSLayoutConstraint.activate([
            tableButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            tableButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableButton.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    func setupInfoText() {
        view.addSubview(infoText)
        
        NSLayoutConstraint.activate([
            infoText.topAnchor.constraint(equalTo: tableButton.bottomAnchor, constant: 20),
            infoText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func goToVC(isLoaded: Bool) {
        let vc = HelpViewController()
        vc.isLoader = isLoaded
        present(vc, animated: true)
    }
}

// MARK: -- Fetch
private extension SubscribeViewController {
    func fetchData() {
        let subscribeModel = SubscribeModel()
        dataTable = subscribeModel.tableData
        dataCarousel = subscribeModel.carouselData
    }
}

// MARK: -- UICollectionView DataSource & Delegate
extension SubscribeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCarousel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubscribeCollectionViewCell.reuseId, for: indexPath) as! SubscribeCollectionViewCell
        cell.configure(imageName: dataCarousel![indexPath.item].image, text: dataCarousel![indexPath.item].text)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.bounds.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

// MARK: --
extension SubscribeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataTable?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubscribeTableViewCell.reuseId, for: indexPath) as! SubscribeTableViewCell
        cell.borderColor = AppColors.mainGreen
        cell.cornerRadius = 10
        cell.configure(item: dataTable![indexPath.section], isFirst: indexPath.section == 0 ? true: false)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if let product = SubscriptionManager.shared.products.first(where: { $0.productIdentifier == "com.yourapp.monthly" }) {
                SubscriptionManager.shared.buyProduct(product)
            }
        case 1:
            if let product = SubscriptionManager.shared.products.first(where: { $0.productIdentifier == "com.yourapp.threemonths" }) {
                SubscriptionManager.shared.buyProduct(product)
            }
            
        case 2:
            if let product = SubscriptionManager.shared.products.first(where: { $0.productIdentifier == "com.yourapp.lifetime" }) {
                SubscriptionManager.shared.buyProduct(product)
            }
        default:
            break
        }
    }
}




// MARK: -- OBJC
private extension SubscribeViewController {
    @objc func cancelButtonTap() {
        dismiss(animated: true)
    }
    
    @objc private func openPrivacyPolicy() {
        goToVC(isLoaded: true)
    }
    
    @objc private func openUserAgreement() {
        goToVC(isLoaded: false)
    }
}
