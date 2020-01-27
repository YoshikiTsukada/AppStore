//
//  BaseViewController.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/08.
//

import UIKit

class BaseViewController: UIViewController {
    override func loadView() {
        if let view = UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
}
