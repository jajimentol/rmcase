//
//  ViewController.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import UIKit

typealias BaseViewController = BaseVC & BaseVCProtocol

protocol BaseVCProtocol {
    func setInterface()
}

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

