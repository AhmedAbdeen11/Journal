//
//  ForgotPasswordController.swift
//  Journal
//
//  Created by Abdeen on 1/11/22.
//

import UIKit
import MaterialComponents

class ForgotPasswordController: UIViewController {

    // MARK: - View Model
    
    // MARK: - Properties

    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var textFieldEmail: MDCOutlinedTextField!
    
    @IBOutlet weak var btnSubmit: MDCButton!
    
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
        
        
        //Button Signup
        btnSubmit.backgroundColor = UIColor(named: "Primary")
        btnSubmit.setTitle("Send Reset Link", for: .normal)
        btnSubmit.layer.cornerRadius = 25
        btnSubmit.isUppercaseTitle = false
        
        btnSubmit.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
    }
    
    // MARK: - Actions

    @IBAction func didTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
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
