//
//  Utility.swift
//  Animo mApps
//
//  Created by Mac on 8/28/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class Utility {
    
    static func showAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "حسنا", style: .cancel, handler: nil))
        
        return alert
    }
    
    static func showAlertNew(message: String, context: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "حسنا", style: .cancel, handler: nil))
        
        context.present(alert, animated: true, completion: nil)
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    static func getDefaultColor() -> UIColor{
        return UIColor(red: 40/255.0, green: 163/255.0, blue: 230/255.0, alpha: 1.0)
    }
    
    static func showProgressDialog(view: UIView){
       view.isUserInteractionEnabled = false
        SVProgressHUD.setBackgroundColor(UIColor(named: "Primary")!)
       SVProgressHUD.setForegroundColor(UIColor.white)
       SVProgressHUD.show()
    }
    
    static func hideProgressDialog(view: UIView){
        view.isUserInteractionEnabled = true
        SVProgressHUD.dismiss()
    }
    
    static func openLogin(){
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController

        if #available(iOS 13.0, *){
            if let scene = UIApplication.shared.connectedScenes.first{
                guard let windowScene = (scene as? UIWindowScene) else { return }
                print(">>> windowScene: \(windowScene)")
                let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
                window.windowScene = windowScene //Make sure to do this
                window.rootViewController = vc
                window.makeKeyAndVisible()
                appDelegate.window = window
            }
        } else {
            appDelegate.window?.rootViewController = vc
            appDelegate.window?.makeKeyAndVisible()
        }*/
    }
    
    static func loginRedirectAlert(context: UIViewController){
        let confirmAlert = UIAlertController(title: "", message: "تحتاج لتسجيل الدخول او عمل حساب للقيام بهذا الاجراء", preferredStyle: UIAlertController.Style.alert)

        confirmAlert.addAction(UIAlertAction(title: "فتح صفحة التسجيل", style: .default, handler: { (action: UIAlertAction!) in
            openLogin()
        }))

        confirmAlert.addAction(UIAlertAction(title: "لا شكرا", style: .default, handler: nil))

        context.present(confirmAlert, animated: true, completion: nil)
    }
    
    static func isLoggedIn(context: UIViewController) -> Bool {
        if Global.sharedInstance.userData == nil {
            loginRedirectAlert(context: context)
            return false
        }
        
        return true
    }
    
}
