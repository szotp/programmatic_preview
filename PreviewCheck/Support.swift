//
//  Support.swift
//  PreviewCheck
//
//  Created by szotp on 19/06/2019.
//  Copyright © 2019 szotp. All rights reserved.
//

import UIKit

#if DEBUG
import SwiftUI


@available(iOS 13.0, *)
private final class Wrapper: UINavigationController, UIViewControllerRepresentable {
    let factory: () -> UIViewController

    init(factory: @escaping () -> UIViewController) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refresh() {
        let vc = factory()
        vc.loadViewIfNeeded()
        setViewControllers([factory()], animated: false)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Wrapper>) -> UIViewController {
        refresh()
        return self
    }
    
    func updateUIViewController(_ vc: UIViewController, context: UIViewControllerRepresentableContext<Wrapper>) {
        refresh()
    }
}

class Previewer<T: UIViewController> {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        return Wrapper {
            let vc = T.init()
            setup(instance: vc)
            return vc
        }.previewLayout(.sizeThatFits)
    }
    
    /// Override this to provide custom parameters
    class func setup(instance: T) {
        
    }
}

#endif

extension UIAppearance {
    typealias Styler = (Self) -> Void
    
    @discardableResult func style(_ block: Styler) -> Self {
        block(self)
        return self
    }
    
    @discardableResult func styles(_ block: Styler...) -> Self {
        for b in block {
            b(self)
        }
        return self
    }
}

extension UIAppearance where Self: UIView {
    init(style: Styler) {
        self.init()
        style(self)
    }
}

@_functionBuilder struct LegacyViewBuilder<T: UIView> {
    static func buildBlock(_ views: UIView...) -> [UIView] {
        views
    }
}

struct Style<T> {
    var block: (T) -> Void
}

extension UIStackView {
    func horizontal(@LegacyViewBuilder<UIStackView> _ views: () -> [UIView]) -> Self {
        axis = .horizontal
        for view in views() {
            addArrangedSubview(view)
        }
        return self
    }
    
    func vertical(@LegacyViewBuilder<UIStackView> _ views: () -> [UIView]) -> Self {
        axis = .vertical
        for view in views() {
            addArrangedSubview(view)
        }
        return self
    }
}

struct Containment {
    let builder: (UIView, UIView) -> Void
    
    func apply(superview: UIView, subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(subview)
        
        builder(superview, subview)
    }
    
    static let fillToMargins = Containment { superview, subview in
        let guide = superview.layoutMarginsGuide
        guide.leadingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
        guide.trailingAnchor.constraint(equalTo: subview.trailingAnchor).isActive = true
        guide.topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
        guide.bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
    }
    
    static let center = Containment { superview, subview in
        superview.centerXAnchor.constraint(equalTo: subview.centerXAnchor).isActive = true
        superview.centerYAnchor.constraint(equalTo: subview.centerYAnchor).isActive = true
    }
    
    static let fill = Containment { superview, subview in
        let guide = superview
        guide.leadingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
        guide.trailingAnchor.constraint(equalTo: subview.trailingAnchor).isActive = true
        guide.topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
        guide.bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
    }
}

extension UIAppearance where Self: UIView {
    @discardableResult func contain(_ containment: Containment = .fillToMargins, _ factory: () -> UIView) -> Self {
        containment.apply(superview: self, subview: factory())
        return self
    }
}

extension UIEdgeInsets {
    init(all: CGFloat) {
        self = UIEdgeInsets(top: all, left: all, bottom: all, right: all)
    }
}
