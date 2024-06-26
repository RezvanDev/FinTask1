//
//  OnboardingViewController.swift
//  FinTask
//
//  Created by Timofey on 25.06.24.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContoller()
        addSubviews()
        setupConstraints()
    }

    // setup main title
    private lazy var titleHeaderView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Добро пожаловать в FinTask"
        label.font = UIFont(name: "Poppins", size: 30)
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.tintColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()

    // setup mainView
    private lazy var mainView: UIView = {
        let viewMain = UIView()
        viewMain.backgroundColor = UIColor(red: 241/255, green: 255/255, blue: 243/255, alpha: 1)
        viewMain.translatesAutoresizingMaskIntoConstraints = false
        viewMain.layer.cornerRadius = 60
        return viewMain
    }()
    
    //setup secondRoundedView
    private lazy var roundedView: UIView = {
        let roundView = UIView()
        roundView.translatesAutoresizingMaskIntoConstraints = false
        roundView.backgroundColor = UIColor(red: 181/255, green: 237/255, blue: 188/255, alpha: 1)
        roundView.layer.cornerRadius = 100
        return roundView
    }()
    //setup imageView
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "coins")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //setup mainButton
    private lazy var mainButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Далее", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        btn.setTitleColor(.black, for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 160).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    //setup nextButtonImage
    private lazy var nextImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "next")
        image.contentMode = .scaleAspectFill
        return image
    }()

    // setup mainViewController
    private func setupViewContoller() {
        view.backgroundColor = UIColor(red: 0/255, green: 208/255, blue: 158/255, alpha: 1)
    }

    // setup subviews
    private func addSubviews() {
        view.addSubview(titleHeaderView)
        view.addSubview(mainView)
        view.addSubview(roundedView)
        view.addSubview(imageView)
        view.addSubview(mainButton)
        view.addSubview(nextImage)
    }

    // setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            //titleHeaderView constraints
            titleHeaderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            titleHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            titleHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            //mainView constraints
            mainView.topAnchor.constraint(equalTo: titleHeaderView.bottomAnchor, constant: 50),
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 1000),
            
            //roundedView constraints
            roundedView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            roundedView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 50),
            roundedView.widthAnchor.constraint(equalToConstant: 200),
            roundedView.heightAnchor.constraint(equalToConstant: 200),
            
            //imageView constraints
            imageView.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 220),
            imageView.widthAnchor.constraint(equalToConstant: 240),
            
            //mainButton constraints
            mainButton.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            mainButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            mainButton.heightAnchor.constraint(equalToConstant: 20),
            mainButton.widthAnchor.constraint(equalToConstant: 100),
            
            //nextButtonImage constraints
            nextImage.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            nextImage.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 20),
            nextImage.heightAnchor.constraint(equalToConstant: 10),
            nextImage.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}

