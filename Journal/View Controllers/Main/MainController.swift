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
import LocalAuthentication

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
    
    @IBOutlet weak var viewClose: UIView!
    
    
    // MARK: - Variables
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "faceId") {
            authenticate()
        }
        
        viewModel = MainViewModel(context: self)
        initListeners()
        initViews()
        getCurrentUser()
        
    }
    
    
    
    
    func authenticate(){
      let context = LAContext()
      let reason = "Enabling Face ID allows you quick and secure access to your account"
     
      var authError: NSError?
          if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
              context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                  if success {
                  }
              }
          } else {
             // Handle Error
          }
    }
    
    private func initViews(){
        
        btnGotIt.backgroundColor = UIColor(named: "Primary")
        btnGotIt.setTitle("Got it", for: .normal)
        btnGotIt.layer.cornerRadius = 25
        btnGotIt.isUppercaseTitle = false
        btnGotIt.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
        
        viewClose.layer.cornerRadius = 4
        
        viewComingSoon.layer.cornerRadius = 20
    }
    
    private func initListeners(){
        let hideDialogGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideComingSoonDialog(_:)))
        viewComingSoonContainer.addGestureRecognizer(hideDialogGesture)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.dontHideDialog(_:)))
        viewComingSoon.addGestureRecognizer(gesture)
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
    
    private func clearUserData(){
        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "accessToken")

        if removeSuccessful {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateInitialViewController()

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
    }
    
    // MARK: - Actions

    @objc func hideComingSoonDialog(_ sender: Any) {
        viewComingSoonContainer.isHidden = true
    }
    
    @objc func dontHideDialog(_ sender: Any) {
        //No Action
    }
    
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
        imageViewJournal.image = UIImage(named: "journal")
    }
    
    @IBAction func didTapTheoryBtn(_ sender: Any) {
        viewComingSoonContainer.isHidden = false
    }
    
    @IBAction func didTapProfileBtn(_ sender: Any) {
        profileContainer.isHidden = false
        homeContainer.isHidden = true
        
        imageViewProfile.image = UIImage(named: "profile_filled")
        imageViewJournal.image = UIImage(named: "ic_journal_outlined")
        
    }
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        self.viewComingSoonContainer.isHidden = true
    }
    
    // MARK: - Server Work
    
    private func getCurrentUser(){
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
//        Utility.showProgressDialog(view: self.view)
        
        let params: [String: Any] =
            [
             "device_id": (deviceId ?? "ios_device"),
             "notification_token": "notificationToken"]
        
        viewModel.getCurrentUser(params: params)
            .subscribe(onSuccess: { user in
                Global.sharedInstance.userData = user
            }, onError: { error in
                self.clearUserData()
            })
        .disposed(by: disposeBag)
    }
    
}

