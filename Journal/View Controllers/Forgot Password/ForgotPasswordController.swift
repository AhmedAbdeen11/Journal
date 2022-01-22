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

    
    @IBOutlet weak var textFieldEmail: MDCFilledTextField!
    
    @IBOutlet weak var btnSubmit: MDCButton!
    
    @IBOutlet weak var fbClose: MDCFloatingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        initViews()
    }
    
    private func initViews(){
        //Btn Close
        fbClose.backgroundColor = UIColor.white
        fbClose.setImage(#imageLiteral(resourceName: "big_x"), for: .normal)
        
        //Text Field Email
        textFieldEmail.style(title: "Email Address")
        
        //Button Submit
        btnSubmit.style(color: UIColor(named: "Primary")!, title: "Send Reset Link")
        btnSubmit.addShadow()
    }
    
    // MARK: - Actions

    @IBAction func didTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        self.performSegue(withIdentifier: "showForgotPasswordConfirmationSegue", sender: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showForgotPasswordConfirmationSegue"
        {
            let forgotPasswordConfiramtionController = segue.destination as? ForgotPasswordConfirmationController
            forgotPasswordConfiramtionController?.forgotPasswordController = self
        }
    }
    

}
