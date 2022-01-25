//
//  AddJournalController.swift
//  Journal
//
//  Created by Abdeen on 1/25/22.
//

import UIKit
import RxSwift

class AddJournalController: UIViewController {

    // MARK: - View Model
    
    var viewModel = AddJournalViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var viewAddFavorite: UIView!

    @IBOutlet weak var viewClose: UIView!
    
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var textFieldTitle: UITextField!
    
    @IBOutlet weak var viewSubmit: UIView!
    
    @IBOutlet weak var constraintViewSubmitBottom: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageViewStar: UIImageView!
    
    // MARK: - Variables
    
    private var isFavorite = false
    
    var journalPageController: JournalPageController!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)


        initViews()
        setData()
    }
    
    private func initViews(){
        viewClose.layer.cornerRadius = 21
        viewClose.addShadow()
        
        viewAddFavorite.layer.cornerRadius = 21
        viewAddFavorite.addShadow()
        
        viewSubmit.layer.cornerRadius = 26.5
        viewSubmit.addShadow()
        
        textFieldTitle.layer.borderWidth = 0
        
        textFieldTitle.attributedPlaceholder =
        NSAttributedString(string: "Untitled", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x94A0BA)])
        textFieldTitle.textColor = UIColor.black
        
        textView.textColor = UIColor(rgb: 0x94A0BA)
    }
    
    private func setData(){
        labelDate.text = Date().string(format: "MMM d, yyyy")
        
        textView.delegate = self
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        
        print(self.constraintViewSubmitBottom.constant)
        print(keyboardSize.height)
        
        self.constraintViewSubmitBottom.constant = 16 + keyboardSize.height
        
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        
        print(self.constraintViewSubmitBottom.constant)
        print(keyboardSize.height)
        
        self.constraintViewSubmitBottom.constant = 16
    }
    
    // MARK: - Actions
    
    @IBAction func didTapBtnAddFavorite(_ sender: Any) {
        
        if isFavorite {
            viewAddFavorite.backgroundColor = UIColor.white
            imageViewStar.image = UIImage(named: "ic_star")
            isFavorite = false
        }else{
            viewAddFavorite.backgroundColor = UIColor(named: "Primary")
            imageViewStar.image = UIImage(named: "ic_star_filled")
            isFavorite = true
        }
        
    }
    
    @IBAction func didTapBtnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapBtnSubmit(_ sender: Any) {
        
        if textFieldTitle.text!.isEmpty || textView.text.isEmpty {
            
        }else{
            addJournal()
        }
        
    }
    
    // MARK: - Server Work
    
    private func addJournal(){
  
        Utility.showProgressDialog(view: self.view)
        
        let params: [String: Any] =
            [
                "title": textFieldTitle.text!,
                "text": textView.text!,
                "is_favorite": isFavorite,
            ]
        
        viewModel.addUserJournal(params: params)
            .subscribe(onCompleted: {
                self.journalPageController.showViewEntrySaved()
                Utility.hideProgressDialog(view: self.view)
                self.dismiss(animated: true, completion: nil)
            }, onError: { error in
                Utility.hideProgressDialog(view: self.view)
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

extension AddJournalController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(rgb: 0x94A0BA) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What is in your mind?"
            textView.textColor = UIColor(rgb: 0x94A0BA)
        }
    }
    
}
