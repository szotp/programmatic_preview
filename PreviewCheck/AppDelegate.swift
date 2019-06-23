//
//  AppDelegate.swift
//  PreviewCheck
//
//  Created by szotp on 19/06/2019.
//  Copyright © 2019 szotp. All rights reserved.
//

import UIKit
import SwiftUI

class Styles {
    required init() {}
    
    var colorsBackground: UIColor {
        return UIColor.white
    }
    
    func bg(view: UIView) {
        view.backgroundColor = UIColor.white
    }
}
let styles = Styles()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().style {
            $0.isTranslucent = false
            $0.barTintColor = UIColor.black
            $0.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        }
        
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

