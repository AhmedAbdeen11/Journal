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
    var viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Properties

    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var textFieldName: MDCFilledTextField!
    
    @IBOutlet weak var textFieldEmail: MDCFilledTextField!
    
    @IBOutlet weak var textFieldPassword: MDCFilledTextField!
    
    @IBOutlet weak var textFieldConfirmPassword: MDCFilledTextField!
    
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
        
        initViews()
    }
    
    private func initViews(){
        //Btn back
        btnBack.btnBackStyle()
        
        //Text Field Name
        self.textFieldName.style(title: "Name")
        
        
        //Text Field Email
        self.textFieldEmail.style(title: "Email")
        
        //Text Field Password
        self.textFieldPassword.style(title: "Password")
        self.textFieldPassword.isSecureTextEntry = true
        
        //Text Field Confirm Password
        self.textFieldConfirmPassword.style(title: "Confirm Password")
        self.textFieldConfirmPassword.isSecureTextEntry = true
        
        //Button Signup
        btnSignup.style(color: UIColor(named: "Primary")!, title: "Sign Up")
        btnSignup.addShadow()
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
        self.navigationController?.popViewController(animated: false)
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
    
    private func displayServerErrors(serverError: ServerError){
        if serverError.name != nil {
            labelNameError.isHidden = false
            labelNameError.text = serverError.name![0]
        }
        
        if serverError.email != nil {
            labelEmailError.isHidden = false
            labelEmailError.text = serverError.email![0]
        }
        
        if serverError.password != nil {
            labelPasswordError.isHidden = false
            labelPasswordError.text = serverError.password![0]
        }
    }
    
    // MARK: - Network
    
    private func signup(){
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        Utility.showProgressDialog(view: self.view)
        let params: [String: Any] =
            ["name": (textFieldName.text ?? ""),
             "email": (textFieldEmail.text ?? ""),
             "password": (textFieldPassword.text ?? ""),
             "device_id": (deviceId ?? "ios_device"),
             "notification_token": "notificationToken"
        ]
        
        viewModel.register(params: params)
            .subscribe(onSuccess: { message in
                
                Utility.hideProgressDialog(view: self.view)
                
                /*let alert = UIAlertController(title: "", message: "Register success you can login...", preferredStyle: .alert)
               
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action: UIAlertAction!) in
                    self.dismiss(animated: true) {
                        self.navigationController?.popViewController(animated: true)
                        self.introController.didTapLoginBtn(self)
                    }
                }))
                                    
                self.present(alert, animated: true, completion: nil)*/
                
            }, onError: { (error) in
                Utility.hideProgressDialog(view: self.view)
                let serverError = ResponseHandler.extractFormErrors( error: error)
                self.displayServerErrors(serverError: serverError)
            })
        .disposed(by: disposeBag)
    }

}
