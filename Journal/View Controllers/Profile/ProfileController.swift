//
//  ProfileController.swift
//  Journal
//
//  Created by Abdeen on 1/24/22.
//

import UIKit
import RxSwift
import MessageUI
import LocalAuthentication
import SwiftKeychainWrapper

class ProfileController: UIViewController, MFMailComposeViewControllerDelegate{

    // MARK: - View Model
    
    var viewModel = ProfileControllerViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var viewBackground: UIView!
    
    @IBOutlet weak var viewUserImage: UIView!
    
    @IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var labelDayStreak: UILabel!
    
    @IBOutlet weak var labelTotalDays: UILabel!
    
    @IBOutlet weak var labelTotalEntries: UILabel!
    
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var imageBackground: UIImageView!
    
    @IBOutlet weak var viewFirstStackContainer: UIView!
    
    @IBOutlet weak var viewSecondStackContainer: UIView!
    
    @IBOutlet weak var viewThirdStackContainer: UIView!
    
    @IBOutlet weak var imageViewUser: UIImageView!
    
    @IBOutlet weak var switchFaceId: UISwitch!
    
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        getProfile()
    }

    private func initViews(){
        viewHeader.layer.shadowColor = UIColor.black.cgColor
        viewHeader.layer.shadowOpacity = 0.1
        viewHeader.layer.shadowOffset = CGSize(width: 0, height: 4)
        viewHeader.layer.shadowRadius = 3
        viewHeader.layer.shouldRasterize = true
        viewHeader.layer.rasterizationScale = UIScreen.main.scale
        
        viewBackground.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 15)
        viewBackground.addShadow()
        
        viewContainer.layer.cornerRadius = 15
        imageBackground.layer.cornerRadius = 15

        
        viewUserImage.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 61)
        
        viewFirstStackContainer.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 15)
        viewFirstStackContainer.addShadow()
        
        viewSecondStackContainer.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 15)
        viewSecondStackContainer.addShadow()
        
        viewThirdStackContainer.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 15)
        viewThirdStackContainer.addShadow()
    }

    func setData(user: User){
        labelUsername.text = user.name
        labelDayStreak.text = "\(user.dayStreak!)"
        labelTotalDays.text = "\(user.totalDays!)"
        labelTotalEntries.text = "\(user.totalEntries!)"
        
        imageViewUser.sd_setImage(with: URL(string: user.avatar!), completed: nil)
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "faceId") {
            switchFaceId.setOn(true, animated: false)
        }
    }
    
    private func openGmail(subject: String){
        let googleUrlString = "googlegmail:///co?to=info@journal.com&subject=\(subject)"
        
        if let googleUrl = NSURL(string: googleUrlString) {
            // show alert to choose app
            if UIApplication.shared.canOpenURL(googleUrl as URL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(googleUrl as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(googleUrl as URL)
                }
            }
        }
    }
    
    private func openMail(subject: String){
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@journal.com"])
            mail.setMessageBody("", isHTML: true)
            mail.setSubject(subject)
            
            self.present(mail, animated: true)
          } else {
            // show failure alert
          }
    }
    
    func authenticate(){
      let context = LAContext()
      let reason = "Enabling Face ID allows you quick and secure access to your account"
     
      var authError: NSError?
          if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
              context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    let defaults = UserDefaults.standard
                  if success {
                    defaults.set(true, forKey: "faceId")
//                    switchFaceId.setOn(true, animated: true)
                  } else {
                    defaults.set(false, forKey: "faceId")
//                    self.switchFaceId.setOn(false, animated: true)
                  }
              }
          } else {
             // Handle Error
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
    
    @IBAction func didTapBtnRate(_ sender: Any) {
        
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") else {
                return
            }
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        
    }
    
    @IBAction func didTapBtnRequestFeature(_ sender: Any) {
        
        let subject = "Feature Request for Stoic Nature"
        
        let alert = UIAlertController(title: "Open mail app", message: "Which app would you like to open", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Mail", style: .default, handler: { (action) in
            
            self.openMail(subject: subject)
            
        }))
        
        if UIApplication.shared.canOpenURL(NSURL(string: "googlegmail:///")! as URL) {
            
            alert.addAction(UIAlertAction(title: "Gmail", style: .default, handler: { (action) in
                
                self.openGmail(subject: "Feature%20Request%20for%20Stoic%20Nature")
            }))
            
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        //==================Ipad case================//
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        //===========================================//
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didTapBtnFeedback(_ sender: Any) {
        
        
        let subject = "Feedback Request for Stoic Nature"
        
        let alert = UIAlertController(title: "Open mail app", message: "Which app would you like to open", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Mail", style: .default, handler: { (action) in
            
            self.openMail(subject: subject)
            
        }))
        
        if UIApplication.shared.canOpenURL(NSURL(string: "googlegmail:///")! as URL) {
            
            alert.addAction(UIAlertAction(title: "Gmail", style: .default, handler: { (action) in
                
                self.openGmail(subject: "Feedback%20Request%20for%20Stoic%20Nature")
            }))
            
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        //==================Ipad case================//
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        //===========================================//
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func didTapInviteFriend(_ sender: Any) {
        
        let message = "Hi there. I’ve been using “Stoic Nature” to learn Stoicism and apply the philosophy through guided journals. I thought you may benefit from it as well! You can find it here:"
         if let link = NSURL(string: "http://yoururl.com") {
         let objectsToShare = [message,link] as [Any]
         let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                        self.present(activityVC, animated: true, completion: nil)
                    }
        
    }
    
    @IBAction func didTapBtnJoinCommunity(_ sender: Any) {
    
        let facebookURL = NSURL(string: "fb://profile?id=PageName")!
        if UIApplication.shared.canOpenURL(facebookURL as URL) {
            UIApplication.shared.openURL(facebookURL as URL)
            } else {
                UIApplication.shared.openURL(NSURL(string: "https://www.facebook.com/PageName")! as URL)
            }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true)
    }
    
    @IBAction func switchFaceIdChanged(_ sender: Any) {
        if switchFaceId.isOn {
            authenticate()
        }else{
            let defaults = UserDefaults.standard
            defaults.setValue(false, forKey: "faceId")
        }
    }
    
    
    @IBAction func didTapBtnHelpAndSupport(_ sender: Any) {
        
        let subject = "Help and Support for Stoic Nature"
        
        let alert = UIAlertController(title: "Open mail app", message: "Which app would you like to open", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Mail", style: .default, handler: { (action) in
            
            self.openMail(subject: subject)
            
        }))
        
        if UIApplication.shared.canOpenURL(NSURL(string: "googlegmail:///")! as URL) {
            
            alert.addAction(UIAlertAction(title: "Gmail", style: .default, handler: { (action) in
                
                self.openGmail(subject: "Help%20and%20Support%20for%20Stoic%20Nature")
            }))
            
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        //==================Ipad case================//
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        //===========================================//
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func didTapBtnLogout(_ sender: Any) {

        let alert = UIAlertController(title: "Are you sure you want to log out of", message: "\(Global.sharedInstance.userData!.email!)", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (action) in
            
            self.logout()
            
        }))
        
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        //==================Ipad case================//
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        //===========================================//
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func didTapDeleteAccount(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure you want to delete your account?", message: "Stoic Nature will remove all of your data. This action cannont be undone.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            
            self.deleteAccount()
            
        }))
        
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        //==================Ipad case================//
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        //===========================================//
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Server Work
    
    private func getProfile(){
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
//        Utility.showProgressDialog(view: self.view)
        
        let params: [String: Any] =
            [
             "device_id": (deviceId ?? "ios_device"),
             "notification_token": "notificationToken"]
        
        viewModel.getCurrentUser(params: params)
            .subscribe(onSuccess: { user in
                Global.sharedInstance.userData = user
                self.setData(user: user)
            }, onError: { error in
                
            })
        .disposed(by: disposeBag)
    }
    
    private func logout(){
        Utility.showProgressDialog(view: self.view)
        viewModel.logout()
            .subscribe(onCompleted: {
                self.clearUserData()
                Utility.hideProgressDialog(view: self.view)
            }, onError: { error in
                
            })
        .disposed(by: disposeBag)
    }
    
    private func deleteAccount(){
        Utility.showProgressDialog(view: self.view)
        viewModel.deleteAccount()
            .subscribe(onCompleted: {
                self.clearUserData()
                Utility.hideProgressDialog(view: self.view)
            }, onError: { error in
                
            })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAccountInfoSegue" {
            let accountInfoController = segue.destination as? AccountInfoController
            accountInfoController?.profileController = self
        }
    }
    

}
