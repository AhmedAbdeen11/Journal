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
    
    @IBOutlet weak var textFieldEmail: MDCFilledTextField!
    
    @IBOutlet weak var textFieldPassword: MDCFilledTextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    // MARK: - Variables
    var introController: IntroController!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround() 

        viewModel = LoginViewModel(context: self)
        initViews()
    }
    
    private func initViews(){
        //Btn back
        btnBack.btnBackStyle()
        
        //Text Field Email
        self.textFieldEmail.style(title: "Email")
        self.textFieldEmail.keyboardType = .emailAddress
        self.textFieldEmail.returnKeyType = .done
        self.textFieldEmail.delegate = self
        
        //Text Field Password
        self.textFieldPassword.style(title: "Password")
        self.textFieldPassword.isSecureTextEntry = true
        self.textFieldPassword.keyboardType = .default
        self.textFieldPassword.returnKeyType = .done
        self.textFieldPassword.delegate = self
        
        //Button Login
        btnLogin.layer.cornerRadius = 25
        btnLogin.addShadow()
        
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
        self.navigationController?.popViewController(animated: false)
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


//MARK: - Extensions


extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
