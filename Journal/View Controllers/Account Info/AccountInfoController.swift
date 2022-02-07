//
//  AccountInfoController.swift
//  Journal
//
//  Created by Abdeen on 1/24/22.
//

import UIKit
import MaterialComponents
import RxSwift

class AccountInfoController: UIViewController {
    
    // MARK: - View Model
    
    var viewModel = AccountInfoViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var viewUserImage: UIView!
    
    @IBOutlet weak var viewEditImage: UIView!
    
    @IBOutlet weak var textFieldName: MDCFilledTextField!
    
    @IBOutlet weak var textFieldEmail: MDCFilledTextField!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var imageViewUser: UIImageView!
    
    @IBOutlet weak var btnSetAvatar: UIButton!
    
    @IBOutlet weak var collectionViewAvatars: UICollectionView!
    
    @IBOutlet weak var viewChangeAvatar: UIView!
    
    @IBOutlet weak var viewChangeAvatarContainer: UIView!
    
    @IBOutlet weak var labelNameError: UILabel!
    
    @IBOutlet weak var labelEmailError: UILabel!
    
    
    // MARK: - Variables
    
    private var avatars = [Avatar]()
    
    private var selectedAvatar = 0
    
    var profileController: ProfileController!
    
    @IBOutlet weak var viewClose: UIView!
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        initListeners()
        setData()
        getAvatars()
    }
    
    private func initViews(){
        viewBack.layer.cornerRadius = 24
        viewBack.addShadow()
        
//        viewUserImage.addBorder(color: UIColor(rgb: 0xC8D2DC), width: 1, cornerRadius: 61)
        
        viewEditImage.addBorder(color: UIColor(named: "Primary")!, width: 1, cornerRadius: 16)
        
        //Text Field Email
        self.textFieldName.style2(title: "Name")
        self.textFieldEmail.style2(title: "Email")
        
        //Button Update
        btnUpdate.layer.cornerRadius = 25
        btnUpdate.addShadow()
        
        //Bottom View
        viewChangeAvatar.layer.cornerRadius = 20
    }
    
    private func setData(){
        let user = Global.sharedInstance.userData!
        
        imageViewUser.sd_setImage(with: URL(string: user.avatar!), completed: nil)
        
        textFieldName.text = user.name
        textFieldEmail.text = user.email
        
        btnSetAvatar.style(color: UIColor(named: "Primary")!, title: "Set")
        btnSetAvatar.addShadow()
    }

    private func initListeners(){
        let hideDialogGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideSetAvatarDialog(_:)))
        viewChangeAvatarContainer.addGestureRecognizer(hideDialogGesture)
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.dontHideDialog(_:)))
//        viewChangeAvatar.addGestureRecognizer(gesture)
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
    }
    
    @objc func hideSetAvatarDialog(_ sender: Any) {
        viewChangeAvatarContainer.isHidden = true
    }
    
    @objc func dontHideDialog(_ sender: Any) {
        //No Action
    }
    
    // MARK: - Actions
    
    @IBAction func didTapCloseDialogBtn(_ sender: Any) {
        viewChangeAvatarContainer.isHidden = true
    }
    
    @IBAction func didTapBtnUpdate(_ sender: Any) {
        if validateForm() {
            updateProfile()
        }
    }
    
    @IBAction func didTapBtnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapBtnSet(_ sender: Any) {
        viewChangeAvatarContainer.isHidden = true
        imageViewUser.sd_setImage(with: URL(string: avatars[self.selectedAvatar].fullPath!), completed: nil)
    }
    
    @IBAction func didTapChangeAvatar(_ sender: Any) {
        viewChangeAvatarContainer.isHidden = false
    }
    
    // MARK: - Server work
    
    private func updateProfile(){
        
        let params: [String: Any] = [
            "name" : textFieldName.text!,
            "email" : textFieldEmail.text!,
            "avatar": avatars[self.selectedAvatar].path!
        ]
        
        Utility.showProgressDialog(view: self.view)
        
        viewModel.updateProfile(params: params)
            .subscribe(onSuccess: { user in
                Global.sharedInstance.userData = user
                self.dismiss(animated: true, completion: nil)
                Utility.hideProgressDialog(view: self.view)
                
                self.profileController.setData(user: user)
            }, onError: { error in
                Utility.hideProgressDialog(view: self.view)
                let serverError = ResponseHandler.extractFormErrors( error: error)
                self.displayServerErrors(serverError: serverError)
            })
        .disposed(by: disposeBag)
    }
    
    private func getAvatars(){
        
        viewModel.getAvatars()
            .subscribe(onSuccess: { avatars in
                self.avatars = avatars
                self.collectionViewAvatars.reloadData()
            }, onError: { error in
                
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

//MARK: - Extensions

extension AccountInfoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.avatars.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionViewAvatars.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as! AvatarCell
        
        let avatar = avatars[indexPath.item]
        
        cell.imageView.sd_setImage(with: URL(string: avatar.fullPath ?? ""), completed: nil)
        
        cell.labelName.text = avatar.title
        cell.viewSelected.layer.cornerRadius = 16
        
        if avatar.isSelected! {
            selectedAvatar = indexPath.row
//            cell.viewContainer.addBorder(color: UIColor(named: "Primary")!, width: 1, cornerRadius: 61)
            cell.viewSelected.isHidden = false
            
        }else{
            
//            cell.viewContainer.addBorder(color: UIColor(rgb: 0xC8D2DC), width: 1, cornerRadius: 61)
            cell.viewSelected.isHidden = true
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        avatars[selectedAvatar].isSelected = false
        avatars[indexPath.row].isSelected = true
        self.collectionViewAvatars.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (collectionView.bounds.size.width / 2) - 5, height: 175)
    }
    
}
