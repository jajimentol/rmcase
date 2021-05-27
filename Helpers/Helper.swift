//
//  Helper.swift
//  rmcase
//
//  Created by ANIL Turan on 27.05.2021.
//

import Foundation
import UIKit

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

func showAlert(message: String) {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: "Error", message:message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        if let appDelegateObj = UIApplication.shared.delegate! as? AppDelegate {
            appDelegateObj.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
