//
//  AccountInfoController.swift
//  Journal
//
//  Created by Abdeen on 1/24/22.
//

import UIKit
import MaterialComponents
import RxSwift


class ChangePasswordController: UIViewController {
    
    // MARK: - View Model
    
    var viewModel = ChangePasswordViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var textFieldCurrentPassword: MDCFilledTextField!
    
    @IBOutlet weak var textFieldNewPassword: MDCFilledTextField!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var labelCurrentPasswordError: UILabel!
    
    @IBOutlet weak var labelNewPasswordError: UILabel!
    
    
    // MARK: - Variables
    

    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()

    }
    
    private func initViews(){
        viewBack.layer.cornerRadius = 24
        viewBack.addShadow()

        //Text Fields
        self.textFieldCurrentPassword.style2(title: "Current Password")
        self.textFieldCurrentPassword.isSecureTextEntry = true
        
        self.textFieldNewPassword.style2(title: "New Password")
        self.textFieldNewPassword.isSecureTextEntry = true
        
        //Button Update
        btnUpdate.layer.cornerRadius = 25
        btnUpdate.addShadow()
        
    }

    // MARK: - Validate

    private func validateForm() -> Bool {
        
        var valid = true
        
        if(textFieldCurrentPassword.text!.isEmpty){
            labelCurrentPasswordError.text = "Required"
            labelCurrentPasswordError.isHidden = false
            valid = false
        }else{
            labelCurrentPasswordError.isHidden = true
        }
        
        if(textFieldNewPassword.text!.isEmpty){
            labelNewPasswordError.text = "Required"
            labelNewPasswordError.isHidden = false
            valid = false
        }else{
            labelNewPasswordError.isHidden = true
        }
        
        return valid
    }
    
    private func displayServerErrors(serverError: ServerError){
        if serverError.currentPassword != nil {
            labelCurrentPasswordError.isHidden = false
            labelCurrentPasswordError.text = serverError.currentPassword![0]
        }
        
        if serverError.newPassword != nil {
            labelNewPasswordError.isHidden = false
            labelNewPasswordError.text = serverError.newPassword![0]
        }
    }
    
    
    
    // MARK: - Actions
    
    
    @IBAction func didTapBtnUpdate(_ sender: Any) {
        if validateForm() {
            changePassword()
        }
    }
    
    @IBAction func didTapBtnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Server work
    
    private func changePassword(){
        
        let params: [String: Any] = [
            "current_password" : textFieldCurrentPassword.text!,
            "new_password" : textFieldNewPassword.text!
        ]
        
        Utility.showProgressDialog(view: self.view)
        
        viewModel.changePassword(params: params)
            .subscribe(onCompleted: {
                
                self.dismiss(animated: true, completion: nil)
                Utility.hideProgressDialog(view: self.view)
                
                
            }, onError: { error in
                Utility.hideProgressDialog(view: self.view)
                let serverError = ResponseHandler.extractFormErrors( error: error)
                self.displayServerErrors(serverError: serverError)
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
