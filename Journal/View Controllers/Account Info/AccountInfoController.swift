//
//  AccountInfoController.swift
//  Journal
//
//  Created by Abdeen on 1/24/22.
//

import UIKit
import MaterialComponents

class AccountInfoController: UIViewController {
    
    // MARK: - View Model
    
    // MARK: - Properties
    
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var viewUserImage: UIView!
    
    @IBOutlet weak var viewEditImage: UIView!
    
    @IBOutlet weak var textFieldName: MDCFilledTextField!
    
    @IBOutlet weak var textFieldEmail: MDCFilledTextField!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    // MARK: - Variables
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    private func initViews(){
        viewBack.layer.cornerRadius = 24
        viewBack.addShadow()
        
        viewUserImage.addBorder(color: UIColor(rgb: 0xC8D2DC), width: 1, cornerRadius: 61)
        
        viewEditImage.addBorder(color: UIColor(named: "Primary")!, width: 1, cornerRadius: 16)
        
        //Text Field Email
        self.textFieldName.style2(title: "Name")
        self.textFieldEmail.style2(title: "Email")
        
        //Button Update
        btnUpdate.layer.cornerRadius = 25
        btnUpdate.addShadow()
        
    }

    // MARK: - Actions
    
    @IBAction func didTapBtnUpdate(_ sender: Any) {
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
