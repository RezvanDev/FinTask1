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
        setupSubviews()
    }
    //setup mainView
    private lazy var greenViewMain: UIView = {
        let viewMain = UIView()
        viewMain.backgroundColor = .green
        viewMain.translatesAutoresizingMaskIntoConstraints = false
        return viewMain
    }()
    
    //setup mainViewController
    private func setupViewContoller() {
        view.backgroundColor = .white
    }
    //setup subviews
    private func setupSubviews() {
        view.addSubview(greenViewMain)
        
    }
    //setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            greenViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            greenViewMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            greenViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            greenViewMain.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
