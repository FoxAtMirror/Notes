//
//  SceneDelegate.swift
//  notes
//
//  Created by Владислав on 01.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		self.window = UIWindow(windowScene: scene)
		self.window?.rootViewController = UINavigationController(rootViewController: NotesViewController())
		self.window?.makeKeyAndVisible()
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
}
