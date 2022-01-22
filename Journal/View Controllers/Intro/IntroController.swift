//
//  IntroController.swift
//  Journal
//
//  Created by Abdeen on 1/11/22.
//

import UIKit
import MaterialComponents

class IntroController: UIViewController {
    
    // MARK: - View Model
    
    // MARK: - Properties
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    private func initViews(){
        //Signup button
        btnSignup.layer.cornerRadius = 25
        btnSignup.addShadow()
        
        //Login button
        btnLogin.addBorder(color: UIColor(rgb: 0xFFFFFF), width: 1)
        btnLogin.layer.cornerRadius = 25
        btnLogin.addShadow()
    }
    
    // MARK: - Actions
    
    
    @IBAction func didTapSignUpBtn(_ sender: Any) {
        performSegue(withIdentifier: "openSignupSegue", sender: nil)
    }
    
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        performSegue(withIdentifier: "openLoginSegue", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "openLoginSegue") {
            let loginController = segue.destination as! LoginController
            loginController.introController = self
        }
        
        if(segue.identifier == "openSignupSegue") {
            let signUpController = segue.destination as! SignUpController
            signUpController.introController = self
        }
        
    }
    

}
