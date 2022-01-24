//
//  ViewController.swift
//  Journal
//
//  Created by Abdeen on 1/8/22.
//

import UIKit
import RxSwift
import MaterialComponents
import RxSwift
import SwiftKeychainWrapper

class MainController: UIViewController {

    // MARK: - View Model
    var viewModel : MainViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - Properties

    @IBOutlet weak var homeContainer: UIView!
    
    @IBOutlet weak var profileContainer: UIView!
    
    @IBOutlet weak var viewComingSoonContainer: UIView!
    
    @IBOutlet weak var viewComingSoon: UIView!
    
    @IBOutlet weak var btnGotIt: MDCButton!
    
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    @IBOutlet weak var imageViewJournal: UIImageView!
    
    // MARK: - Variables
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = MainViewModel(context: self)
        initViews()
    }
    
    private func initViews(){
        viewComingSoon.layer.cornerRadius = 20
        
        btnGotIt.backgroundColor = UIColor(named: "Primary")
        btnGotIt.setTitle("Got it", for: .normal)
        btnGotIt.layer.cornerRadius = 25
        btnGotIt.isUppercaseTitle = false
        btnGotIt.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
    }
    
    internal override func viewDidAppear(_ animated: Bool) {
        askForNotificationPermission()
    }
    
    private func askForNotificationPermission(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                // Handle the error here.
                print(error.localizedDescription)
            }
            
            // Enable or disable features based on the authorization.
        }
    }
    
    // MARK: - Actions

    @IBAction func didTapGotItBtn(_ sender: Any) {
        viewComingSoonContainer.isHidden = true
    }
    
    @IBAction func didTapHomeBtn(_ sender: Any) {
        viewComingSoonContainer.isHidden = false
    }
    
    @IBAction func didTapMeditateBtn(_ sender: Any) {
        viewComingSoonContainer.isHidden = false
    }
    
    @IBAction func didTapJournalBtn(_ sender: Any) {
        profileContainer.isHidden = true
        homeContainer.isHidden = false
        
        imageViewProfile.image = UIImage(named: "profile_outline")
    }
    
    @IBAction func didTapTheoryBtn(_ sender: Any) {
        viewComingSoonContainer.isHidden = false
    }
    
    @IBAction func didTapProfileBtn(_ sender: Any) {
        profileContainer.isHidden = false
        homeContainer.isHidden = true
        
        imageViewProfile.image = UIImage(named: "profile_filled")
        
    }
    
    private func logout() {
        
        let confirmAlert = UIAlertController(title: "", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)

        confirmAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
//            self.logoutUser()
            self.clearUserData()
        }))

        confirmAlert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

        present(confirmAlert, animated: true, completion: nil)
        
    }
    
    private func logoutUser(){
        Utility.showProgressDialog(view: self.view)
        viewModel.logout()
            .subscribe(onCompleted: {
                Utility.hideProgressDialog(view: self.view)
                self.clearUserData()
            }) { (error) in
        }
        .disposed(by: disposeBag)
    }
    
    private func clearUserData(){
        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "accessToken")

        if removeSuccessful {
            Utility.openLogin()
        }
    }
    
    
}

