//
//  Utility.swift
//  WeatherMap
//
//  Created by Lokesh on 10/10/18.
//

import UIKit
import SVProgressHUD

class Utility: NSObject {
   class func showAlert(message: String) {
        let alert = UIAlertController(title:Constants.weather , message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    class func showProgress(message: String = "") {
        SVProgressHUD.show(withStatus: message)
    }
    
    class func dissmissProgress() {
        SVProgressHUD.dismiss()
    }
    
    
}
