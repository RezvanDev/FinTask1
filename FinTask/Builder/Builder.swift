//
//  Builder.swift
//  FinTask
//
//  Created by Иван Незговоров on 24.06.2024.
//

import UIKit

protocol BuilderProtocol {
    static func createTabBarController() -> UIViewController
    static func createOnboardingViewController() -> UIViewController
}

class Builder: BuilderProtocol {
    static func createOnboardingViewController() -> UIViewController {
        let onboardingView = OnboardingViewController()
        return onboardingView
    }
    
    static func createTabBarController() -> UIViewController {
        let tabBarView = TabBarViewController()
        return tabBarView
    }
    
    
    
    
}
