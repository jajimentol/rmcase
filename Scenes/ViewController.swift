//
//  ViewController.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import UIKit
import SnapKit

typealias BaseViewController = BaseVC & BaseVCProtocol

protocol BaseVCProtocol {
    func setInterface()
}

class BaseVC: UIViewController {

    lazy var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
        }
    }


    func loading() {
        spinner.startAnimating()
//        view.isUserInteractionEnabled = false
    }
    
    func loaded() {
        spinner.stopAnimating()
//        view.isUserInteractionEnabled = true
    }
}

