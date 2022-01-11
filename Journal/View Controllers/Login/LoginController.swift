//
//  LoginController.swift
//  Journal
//
//  Created by Abdeen on 1/11/22.
//

import UIKit
import MaterialComponents

class LoginController: UIViewController {
    // MARK: - View Model
    
    // MARK: - Properties

    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var textFieldEmail: MDCOutlinedTextField!
    
    @IBOutlet weak var textFieldPassword: MDCOutlinedTextField!
    
    @IBOutlet weak var btnLogin: MDCButton!
    
    // MARK: - Variables
    var introController: IntroController!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    private func initViews(){
        //Btn back
        
        btnBack.layer.borderWidth = 1
        btnBack.layer.borderColor = UIColor.white.cgColor
        btnBack.layer.cornerRadius = 20
        
        
        //Text Field Email
        textFieldEmail.label.text = "Email"
        textFieldEmail.setOutlineColor(UIColor.white, for: .editing)
        textFieldEmail.setOutlineColor(UIColor.white, for: .normal)
        textFieldEmail.setTextColor(UIColor.white, for: .editing)
        textFieldEmail.setFloatingLabelColor(UIColor.white, for: .editing)
        textFieldEmail.setTextColor(UIColor.white, for: .normal)
        textFieldEmail.setFloatingLabelColor(UIColor.white, for: .normal)
        textFieldEmail.setNormalLabelColor(UIColor.white, for: .editing)
        textFieldEmail.setNormalLabelColor(UIColor.white, for: .normal)
        textFieldEmail.font = UIFont(name: "Helvetica Neue", size: 15)
        
        
        //Text Field Password
        textFieldPassword.label.text = "Password"
        textFieldPassword.setOutlineColor(UIColor.white, for: .editing)
        textFieldPassword.setOutlineColor(UIColor.white, for: .normal)
        textFieldPassword.setTextColor(UIColor.white, for: .editing)
        textFieldPassword.setFloatingLabelColor(UIColor.white, for: .editing)
        textFieldPassword.setTextColor(UIColor.white, for: .normal)
        textFieldPassword.setFloatingLabelColor(UIColor.white, for: .normal)
        textFieldPassword.setNormalLabelColor(UIColor.white, for: .editing)
        textFieldPassword.setNormalLabelColor(UIColor.white, for: .normal)
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.font = UIFont(name: "Helvetica Neue", size: 15)
        
        //Button Signup
        btnLogin.backgroundColor = UIColor(named: "Primary")
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.layer.cornerRadius = 25
        btnLogin.isUppercaseTitle = false
        
        btnLogin.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
    }
    
    // MARK: - Actions

    @IBAction func didTapBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        
    }
    
    @IBAction func didTapSignUp(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        introController.didTapSignUpBtn(sender)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
