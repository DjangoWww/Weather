//
//  AppDelegate.swift
//  CarSelect
//
//  Created by Django on 2/8/22.
//

import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder, UIApplicationDelegate {
    /// the main window
    public var window: UIWindow?
}

// MARK: - entrance
extension AppDelegate {
    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.

        // setup for some UI related
        let toastDuration: Double
        #if DEBUG
        toastDuration = 10
        #else
        toastDuration = 3
        #endif
        ToastManager.shared.duration = toastDuration

        let rootVC = UINavigationController(rootViewController: WeatherListVC())
        rootVC.navigationBar.tintColor = .blue // setup the tintColor
        let window = UIWindow()
        window.rootViewController = rootVC
        self.window = window
        self.window?.makeKeyAndVisible()

        return true
    }
}

// MARK: - open url
extension AppDelegate {
    public func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        return true
    }
}

// MARK: - wake up
extension AppDelegate {
    public func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        return true
    }
}
