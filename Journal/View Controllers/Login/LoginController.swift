//
//  LoginController.swift
//  Journal
//
//  Created by Abdeen on 1/11/22.
//

import UIKit
import MaterialComponents
import RxSwift

class LoginController: UIViewController {
    // MARK: - View Model
    var viewModel : LoginViewModel!
    let disposeBag = DisposeBag()
    
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

        viewModel = LoginViewModel(context: self)
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
    
    // MARK: - Validate

    private func validateForm() -> Bool {
        
        var valid = true
        
        if(textFieldEmail.text!.isEmpty || textFieldPassword.text!.isEmpty){
            Utility.showAlertNew(message: "Please enter your email and password", context: self)
            valid = false
        }
        
        return valid
    }
    
    // MARK: - Methods
    
    private func openMainPageController(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        
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
        }
    }
    
    // MARK: - Actions

    @IBAction func didTapBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        if validateForm() {
            login()
        }
    }
    
    @IBAction func didTapSignUp(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        introController.didTapSignUpBtn(sender)
    }
    
    // MARK: - Server Work
    
    private func login(){
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        Utility.showProgressDialog(view: self.view)
        
        let params: [String: Any] =
            ["email": (textFieldEmail.text ?? ""),
             "password": (textFieldPassword.text ?? ""),
             "device_id": (deviceId ?? "ios_device"),
             "notification_token": "notificationToken"
        ]
        
        viewModel.login(params: params)
            .subscribe(onSuccess: { message in
                
                Utility.hideProgressDialog(view: self.view)

                self.openMainPageController()
                
            }
            )
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
