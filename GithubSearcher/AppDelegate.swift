//
//  AppDelegate.swift
//  GithubSearcher
//
//  Created by Damir Sitdikov on 15.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        start()
        return true
    }
    
}

extension AppDelegate {
    private func start() {
        let searchViewController = SearchModuleAssembler().build()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

