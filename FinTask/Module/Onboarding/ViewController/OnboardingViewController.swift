//
//  OnboardingViewController.swift
//  FinTask
//
//  Created by Timofey on 25.06.24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private lazy var pageControl: UIPageControl = {
        let pg = UIPageControl()
        pg.translatesAutoresizingMaskIntoConstraints = false
        return pg
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainView: UIView = {
        let viewMain = UIView()
        viewMain.backgroundColor = AppColors.lightGreen
        viewMain.translatesAutoresizingMaskIntoConstraints = false
        viewMain.layer.cornerRadius = 60
        return viewMain
    }()
    
    private lazy var roundedView: UIView = {
        let roundView = UIView()
        roundView.translatesAutoresizingMaskIntoConstraints = false
        roundView.backgroundColor = AppColors.mediumGreen
        roundView.layer.cornerRadius = 122
        return roundView
    }()
    
    
    private let images = [UIImage(named: "coins"), UIImage(named: "bankmobile")]
    private let titles = ["Далее", "Погнали"]
    private let texts = ["Добро пожаловать в FinTask", "Ты готов управлять своими финансами и целями"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: -- Setup Layer
private extension OnboardingViewController {
    
    func setup() {
        view.backgroundColor = AppColors.mainGreen
        configurePageControl()
        setupGesture()
    }
    
    func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(titleLabelTapped))
        titleLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    func configurePageControl() {
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = AppColors.mainGreen
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        view.addSubview(pageControl)
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(descriptionLabel)
        view.addSubview(mainView)
        mainView.addSubview(roundedView)
        mainView.addSubview(imageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(pageControl)
        
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 250),
            
            mainView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            
            roundedView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -40),
            roundedView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            roundedView.heightAnchor.constraint(equalToConstant: 244),
            roundedView.widthAnchor.constraint(equalToConstant: 244),
            
            imageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 287),
            imageView.widthAnchor.constraint(equalToConstant: 287),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            
            pageControl.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        ])
        
        
        // Initialize content with initial values
        updateContent(forPage: pageControl.currentPage)
    }
    

    func updateContent(forPage pageIndex: Int) {
        imageView.image = images[pageIndex]
        titleLabel.text = titles[pageIndex]
        descriptionLabel.text = texts[pageIndex]
    }
    
    // MARK: -- @objc
    @objc  func pageControlTapped(_ sender: UIPageControl) {
        updateContent(forPage: sender.currentPage)
    }
    
    @objc func titleLabelTapped() {
        if pageControl.currentPage == 1 {
            // link for window
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return
            }
            
            let tabBarMainController = TabBarViewController()
            
            // install new root ViewController
            window.rootViewController = tabBarMainController
            
            // Delete root controller
            if let currentViewController = window.rootViewController as? OnboardingViewController {
                currentViewController.removeFromParent()
            }
        }
        
        let nextPage = (pageControl.currentPage + 1) % pageControl.numberOfPages
        pageControl.currentPage = nextPage
        updateContent(forPage: nextPage)
    }
}

