//
//  ViewController.swift
//  PreviewCheck
//
//  Created by szotp on 19/06/2019.
//  Copyright © 2019 szotp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func loadView() {
        super.loadView()
        title = "Hello world"
        
        view = UIView().style({
            $0.backgroundColor = UIColor.white
        }).contain(.center) {
            UIView().style ({
                $0.backgroundColor = UIColor.black
                $0.layoutMargins = UIEdgeInsets(all: 8)
                $0.layer.cornerRadius = 4
            }).contain {
                UIStackView().style({
                    $0.widthAnchor.constraint(equalToConstant: 200).isActive = true
                    $0.spacing = 4
                }).vertical {
                    UITextField {
                        $0.placeholder = "Login"
                        $0.backgroundColor = UIColor.white
                    }
                    UITextField {
                        $0.isSecureTextEntry = true
                        $0.backgroundColor = UIColor.white
                    }
                    UIButton(type: .system).style {
                        $0.setTitle("Login", for: .normal)
                        $0.tintColor = UIColor.orange
                    }
                }
            }
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
class ViewController_Previews: Previewer<ViewController>, PreviewProvider {
}
#endif
