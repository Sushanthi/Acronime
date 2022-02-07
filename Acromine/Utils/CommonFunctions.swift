//
//  CommonFunctions.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//

import Foundation
import UIKit

func readMockJSON(_ fileName:String) -> Data {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
          } catch {
                print("Error \(fileName)")
          }
    }
    return Data()
}

func showLoding() {
    DispatchQueue.main.async {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tag = 1001
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        if let topView = UIApplication.getTopViewController()?.view {
            topView.addSubview(spinner)
            spinner.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        }
    }
    
}
func hideLoding() {
    DispatchQueue.main.async {
        if let topView = UIApplication.getTopViewController()?.view {
            if let spinner = topView.viewWithTag(1001) as? UIActivityIndicatorView {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
        }
    }
}
extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {

       if let nav = base as? UINavigationController {
           return getTopViewController(base: nav.visibleViewController)

       } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
           return getTopViewController(base: selected)

       } else if let presented = base?.presentedViewController {
           return getTopViewController(base: presented)
       }
       return base
   }
}
