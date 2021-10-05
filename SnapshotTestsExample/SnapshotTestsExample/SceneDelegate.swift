//
//  SceneDelegate.swift
//  SnapshotTestsExample
//
//  Created by Harshad Dange on 04/10/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController(rootViewController: ViewController())
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
