//
//  CassiniViewController.swift
//  Cassini
//
//  Created by 1C on 04/06/2022.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let imageUrl = DemoURLs.NASA[identifier] {
                if let imageVC = segue.destination.contents as? ImageViewController {
                    imageVC.imageURL = imageUrl
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        splitViewController?.delegate = self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
     
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {

        if let _ = secondaryViewController.contents as? ImageViewController {
            return true
        }
        return false

    }
    
}

extension UIViewController {
    var contents: UIViewController {
        if let naviController = self as? UINavigationController {
            return naviController.visibleViewController ?? naviController
        } else {
            return self
        }
    }
}
