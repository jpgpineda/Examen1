//
//  UIViewController+Ext.swift
//  Bankodemia
//
//  Created by javier pineda on 29/10/26.
//

import UIKit

extension UIViewController {
    // El loader se agrega al navigationController (si existe), así que hay que buscarlo ahí
    private var loaderChild: LoaderViewController? {
        let host: UIViewController = navigationController ?? self
        return host.children.first { $0 is LoaderViewController } as? LoaderViewController
    }
    
    func showLoader() {
        guard loaderChild == nil else { return }
        
        let host: UIViewController = navigationController ?? self
        let loader = LoaderViewController(nibName: "LoaderViewController", bundle: nil)
        
        host.addChild(loader)
        loader.view.frame = host.view.bounds
        loader.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loader.view.alpha = 0
        host.view.addSubview(loader.view)
        loader.didMove(toParent: host)
        UIView.animate(withDuration: 0.2) {
            loader.view.alpha = 1
        }
    }
    
    func hideLoader() {
        let host: UIViewController = navigationController ?? self
        guard let loader = host.children.first(where: {$0 is LoaderViewController }) else { return }
        
        loader.willMove(toParent: nil)
        UIView.animate(withDuration: 0.2, animations: {
            loader.view.alpha = 0
        }, completion: { _ in
            loader.view.removeFromSuperview()
            loader.removeFromParent()
        })
    }
}
