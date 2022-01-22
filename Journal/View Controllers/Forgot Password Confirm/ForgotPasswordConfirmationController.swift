//
//  ForgotPasswordConfirmationController.swift
//  Journal
//
//  Created by Abdeen on 1/22/22.
//

import UIKit
import MaterialComponents

class ForgotPasswordConfirmationController: UIViewController {

    // MARK: - View Model
    
    // MARK: - Properties
    
    @IBOutlet weak var viewCheckMark: UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnLogin: MDCButton!
    
    // MARK: - Variables
    
    var forgotPasswordController: ForgotPasswordController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    private func initViews(){
        
        //Btn Back
        btnBack.btnBackStyle()
        
        //Check Mark View
        viewCheckMark.layer.cornerRadius = 48
        
        //Btn Login
        btnLogin.style(color: UIColor(named: "Primary")!, title: "Login")
    }
    
    @IBAction func didTapBtnLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: {
        
            self.forgotPasswordController.dismiss(animated: true, completion: nil)
            
        })
        
    }
    
    @IBAction func didTapBtnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
