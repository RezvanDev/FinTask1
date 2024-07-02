//
//  SceneDelegate.swift
//  FinTask
//
//  Created by Иван Незговоров on 23.06.2024.
//

import UIKit
import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        var viewController: UIViewController?
        if UserDefaults.standard.bool(forKey: "firstLaunch") == false {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            viewController = Builder.createOnboardingViewController()
        } else {
            viewController = Builder.createTabBarController()
        }
        guard let viewController else { return }
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}

extension SceneDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        determineCurrencyForCurrentLocation(location: location) { [weak self] success in
                   if success {
                       self?.locationManager.stopUpdatingLocation()
                   }
               }
    }
    
    private func determineCurrencyForCurrentLocation(location: CLLocation? = nil, completion: @escaping (Bool) -> Void) {
        guard let location = location ?? locationManager.location else {
            print("error location")
            return
        }
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else {
                print("error reverse geocode location")
                return
            }
            
            let countryCode = placemark.isoCountryCode
            var currency: String?
            switch countryCode {
            case "KZ":
                currency = "KZT"
            case "RU":
                currency = "RUB"
            default:
                currency = "USD"
            }
            
            StorageManager.shared.createInitialUserIfNeeded(locationManager: self.locationManager, currency: currency)
            completion(true)
        }
    }
}
