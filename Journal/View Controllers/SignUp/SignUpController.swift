//
//  SignUpController.swift
//  Journal
//
//  Created by Abdeen on 1/11/22.
//

import UIKit
import MaterialComponents
import RxSwift

class SignUpController: UIViewController {

    // MARK: - View Model
    var viewModel : SignUpViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - Properties

    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var textFieldName: MDCOutlinedTextField!
    
    @IBOutlet weak var textFieldEmail: MDCOutlinedTextField!
    
    @IBOutlet weak var textFieldPassword: MDCOutlinedTextField!
    
    @IBOutlet weak var textFieldConfirmPassword: MDCOutlinedTextField!
    
    @IBOutlet weak var btnSignup: MDCButton!
    
    @IBOutlet weak var labelNameError: UILabel!
    
    @IBOutlet weak var labelEmailError: UILabel!
    
    @IBOutlet weak var labelPasswordError: UILabel!
    
    @IBOutlet weak var labelConfirmPasswordError: UILabel!
    
    // MARK: - Variables
    
    var introController: IntroController!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = SignUpViewModel(context: self)
        initViews()
    }
    
    private func initViews(){
        //Btn back
        
        btnBack.layer.borderWidth = 1
        btnBack.layer.borderColor = UIColor.white.cgColor
        btnBack.layer.cornerRadius = 20
        
        //Text Field Name
        textFieldName.label.text = "Name"
        textFieldName.setOutlineColor(UIColor.white, for: .editing)
        textFieldName.setOutlineColor(UIColor.white, for: .normal)
        textFieldName.setTextColor(UIColor.white, for: .editing)
        textFieldName.setFloatingLabelColor(UIColor.white, for: .editing)
        
        textFieldName.setTextColor(UIColor.white, for: .normal)
        textFieldName.setFloatingLabelColor(UIColor.white, for: .normal)
        textFieldName.setNormalLabelColor(UIColor.white, for: .editing)
        textFieldName.setNormalLabelColor(UIColor.white, for: .normal)
        textFieldName.font = UIFont(name: "Helvetica Neue", size: 15)
        
        
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
        
        //Text Field Confirm Password
        textFieldConfirmPassword.label.text = "Confirm Password"
        textFieldConfirmPassword.setOutlineColor(UIColor.white, for: .editing)
        textFieldConfirmPassword.setOutlineColor(UIColor.white, for: .normal)
        textFieldConfirmPassword.setTextColor(UIColor.white, for: .editing)
        textFieldConfirmPassword.setFloatingLabelColor(UIColor.white, for: .editing)
        textFieldConfirmPassword.setTextColor(UIColor.white, for: .normal)
        textFieldConfirmPassword.setFloatingLabelColor(UIColor.white, for: .normal)
        textFieldConfirmPassword.setNormalLabelColor(UIColor.white, for: .editing)
        textFieldConfirmPassword.setNormalLabelColor(UIColor.white, for: .normal)
        textFieldConfirmPassword.isSecureTextEntry = true
        textFieldConfirmPassword.font = UIFont(name: "Helvetica Neue", size: 15)
        
        //Button Signup
        btnSignup.backgroundColor = UIColor(named: "Primary")
        btnSignup.setTitle("Sign Up", for: .normal)
        btnSignup.layer.cornerRadius = 25
        btnSignup.isUppercaseTitle = false
        
        btnSignup.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
    }
    
    // MARK: - Actions

    @IBAction func didTapBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSignup(_ sender: Any) {
        if validateForm() {
            signup()
        }
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        introController.didTapLoginBtn(sender)
    }
    
    // MARK: - Validate

    private func validateForm() -> Bool {
        
        var valid = true
        
        if(textFieldName.text!.isEmpty){
            labelNameError.text = "Required"
            labelNameError.isHidden = false
            valid = false
        }else{
            labelNameError.isHidden = true
        }
        
        if(textFieldEmail.text!.isEmpty){
            labelEmailError.text = "Required"
            labelEmailError.isHidden = false
            valid = false
        }else{
            labelEmailError.isHidden = true
        }
        
        if(textFieldPassword.text!.isEmpty){
            labelPasswordError.text = "Required"
            labelPasswordError.isHidden = false
            valid = false
        }else{
            labelPasswordError.isHidden = true
        }
        
        if(textFieldPassword.text! != textFieldConfirmPassword.text!){
            labelConfirmPasswordError.text = "Password doesn't match"
            labelConfirmPasswordError.isHidden = false
            valid = false
        }else{
            labelConfirmPasswordError.isHidden = true
        }
        
        return valid
    }
    
    // MARK: - Network
    
    private func signup(){
        Utility.showProgressDialog(view: self.view)
        let params: [String: Any] =
            ["name": (textFieldName.text ?? ""),
             "email": (textFieldEmail.text ?? ""),
             "password": (textFieldPassword.text ?? "")
        ]
        
        viewModel.register(params: params)
            .subscribe(onCompleted: {
                
                Utility.hideProgressDialog(view: self.view)
                
                let alert = UIAlertController(title: "", message: "Register success you can login...", preferredStyle: .alert)
               
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action: UIAlertAction!) in
                    self.dismiss(animated: true) {
                        self.navigationController?.popViewController(animated: true)
                        self.introController.didTapLoginBtn(self)
                    }
                }))
                                    
                self.present(alert, animated: true, completion: nil)
                
            }, onError: { (serverResponse) in
                Utility.showAlertNew(message: "Please fix the errors and resubmit", context: self)
            })
        .disposed(by: disposeBag)
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
