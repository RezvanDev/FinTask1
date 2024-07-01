//
//  ViewController.swift
//  FinTask
//
//  Created by Иван Незговоров, Timofey Zykov, Ivan Nezgovorov on 23.06.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let tabs: [(image: UIImage?, title: String)] = [
        (UIImage(systemName: "creditcard.and.123"), "Финансы"),
        (UIImage(systemName: "folder"), "Лимиты"),
        (UIImage(systemName: "house"), "Главная"),
        (UIImage(systemName: "eye"), "Аналитика"),
        (UIImage(systemName: "gearshape"), "Настройки")
    ]
    
    private var tabButtons: [UIButton] = []
    
    private lazy var tabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.tabBarGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var selectedItem = UIAction { [weak self] sender in
        guard
            let self = self,
            let sender = sender.sender as? UIButton
        else { return }
        
        self.updateButtonColors(selectedButton: sender)
        self.selectedIndex = sender.tag
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 2
        updateButtonColors(selectedButton: tabButtons[selectedIndex])
    }
}

// MARK: -- Setup layer
private extension TabBarViewController {
    func setup() {
        setupTabBarButton()
        setControllers()
        
    }
    
    // setup tab button
    func setupTabBarButton() {
        let stackView = UIStackView(frame: tabBarView.bounds)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        tabs.enumerated().forEach { index, tab in
            guard let image = tab.image else { return }
                                   
            let tabButton = createTabBarButton(icon: image, title: tab.title, tag: index)
            tabButtons.append(tabButton)
            stackView.addArrangedSubview(tabButton)
        }
        
        view.addSubview(tabBarView)
        view.addSubview(stackView)
        
        setupConstraints(stack: stackView)
    }
    
    // create tab bar button
    func createTabBarButton(icon: UIImage, title: String, tag: Int) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = icon
        config.title = title
        config.imagePadding = 2
        config.imagePlacement = .top
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = .systemFont(ofSize: 9, weight: .light)
        attributedTitle.foregroundColor = .white
        
        config.attributedTitle = attributedTitle

        
        let button = UIButton(configuration: config, primaryAction: selectedItem)
        button.tag = tag
        button.tintColor = AppColors.lightGrayMain
        return button
    }
    
    // SETUP constraints for stack, and tab bar view
    func setupConstraints(stack: UIStackView) {
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 80),
            
            stack.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: -20)
        ])
    }

    // Set view controller
    func setControllers() {
        let controllers = [
            FinanceViewController(),
            LimitViewController(),
            HomeViewController(),
            AnalyticViewController(),
            SettingViewController()
        ]
        setViewControllers([controllers[0], controllers[1], controllers[2], controllers[3], controllers[4]], animated: true)
    }
    
    // Update button colors
        func updateButtonColors(selectedButton: UIButton) {
            tabButtons.forEach { $0.tintColor = .lightGray }
            selectedButton.tintColor = AppColors.mainGreen
        }
}

