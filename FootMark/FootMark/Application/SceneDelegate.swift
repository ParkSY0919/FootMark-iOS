//
//  SceneDelegate.swift
//  FootMark
//
//  Created by 박신영 on 3/21/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   
   var window: UIWindow?
   
   func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
      guard let windowScene = (scene as? UIWindowScene) else { return }
      
      self.window = UIWindow(windowScene: windowScene)
      
      let navigationController = UINavigationController(rootViewController: LoginViewController())
      
      self.window?.rootViewController = navigationController
      
      self.window?.makeKeyAndVisible()
   }
}
