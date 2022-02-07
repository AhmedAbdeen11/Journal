//
//  CreateJournalController.swift
//  Journal
//
//  Created by Abdeen on 1/14/22.
//

import UIKit
import RxSwift
import MaterialComponents
import SDWebImage

class CreateJournalController: UIViewController {

    // MARK: - View Model
    
    var viewModel : CreateJournalViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var viewClose: UIView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var labelInfo: UILabel!
    
    
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var viewHint: UIView!
    
    @IBOutlet weak var viewQuestion: UIView!
    
    @IBOutlet weak var labelQuestionTitle: UILabel!
    
    @IBOutlet weak var textViewUserInput: UITextView!
    
    @IBOutlet weak var labelQuestionHint: UILabel!
    
    @IBOutlet weak var finalViewContainer: UIView!
    
    @IBOutlet weak var labelFinalText: UILabel!
    
    @IBOutlet weak var btnSaveToFavorites: MDCButton!
    
    @IBOutlet weak var btnFinishJournal: UIView!
    
    @IBOutlet weak var imageViewBack: UIImageView!
    
    @IBOutlet weak var viewNext: UIView!
    
    @IBOutlet weak var imageViewNext: UIImageView!
    
    @IBOutlet weak var imageViewDone: UIView!
    
    @IBOutlet weak var viewDone: UIView!
    
    @IBOutlet weak var constraintBottomImageNext: NSLayoutConstraint!
    
    @IBOutlet weak var constraintBottomDoneBtn: NSLayoutConstraint!
    
    @IBOutlet weak var viewFavorite: UIView!
    
    @IBOutlet weak var imgFavorite: UIImageView!
    
    @IBOutlet weak var labelFavorite: UILabel!
    
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: - Variables
    
    var topic: Topic!
    
    var counter = 0
    
    var layouts = [String]()
    
    var journalPageController: JournalPageController?
    
    var topicsController: TopicsController?
    
    var topicQuoteController: TopicQuoteController?
    
    var viewEntryController: ViewEntryController?
    
    var entry: Entry!
    
    var isFavorite = false
    
    var isUpdateCase = false
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        viewModel = CreateJournalViewModel(context: self)
        initViews()
        setData()
        initListeners()
    }
    
    private func initListeners(){
        self.textViewUserInput.delegate = self
    }
    
    private func initViews(){
        viewClose.layer.cornerRadius = 25
        viewClose.addShadow()
        
        viewBack.layer.cornerRadius = 25
        viewBack.addShadow()
        
        viewNext.layer.cornerRadius = 37.5
        viewNext.addShadow()
        
        viewDone.layer.cornerRadius = 25
        viewDone.addShadow()
        
        //Final Container
        
        //Save to favorites button
        viewFavorite.addBorder(color: UIColor(named: "Primary")!, width: 1, cornerRadius: 25)
        viewFavorite.addShadow()
        
        //Finish Journal button
        btnFinishJournal.layer.cornerRadius = 25
        btnFinishJournal.addShadow()
        
    }
    
    private func checkFavorite(){
        if entry.isFavorite! {
            btnSaveToFavorites.setTitle("   Saved    ", for: .normal)
            btnSaveToFavorites.setImage(UIImage(named: "star_filled2"), for: .normal)
        }else{
            btnSaveToFavorites.setTitle("   Save as Favourite", for: .normal)
            btnSaveToFavorites.setImage(UIImage(named: "ic_star_outline2"), for: .normal)
        }
    }
    
    private func setData(){
        if(counter == topic.items!.count){
            progressView.setProgress(1, animated: true)
            showFinalView()
        }else{
        
            progressView.setProgress(Float(counter)/Float(topic.items!.count), animated: true)
            
            let item = topic.items![counter]
         
            if(item.question == nil){ //show hint
                showHint(position: counter)
            }else{ //show question
                showQuestion(position: counter)
            }
        }
        
    }
    
    private func showQuestion(position: Int){
        textViewUserInput.becomeFirstResponder()
//        self.keyboardManagerVisible(false)
        
        
        viewHint.isHidden = true
        finalViewContainer.isHidden = true
        viewQuestion.isHidden = false
        viewNext.isHidden = false
        viewBack.isHidden = false
        viewClose.isHidden = false
        viewNext.isHidden = true
        viewDone.isHidden = false
        
        textViewUserInput.text = topic.items![position].answer?.answer ?? ""
        labelQuestionTitle.text = topic.items![position].question
        labelQuestionHint.text = topic.items![position].hint
    }
    
    private func showHint(position: Int){
        textViewUserInput.endEditing(true)
        viewHint.isHidden = false
        viewQuestion.isHidden = true
        viewNext.isHidden = false
        finalViewContainer.isHidden = true
        viewClose.isHidden = false
        viewNext.isHidden = false
        viewDone.isHidden = true
        
        if position == 0 {
            viewBack.isHidden = true
        }else{
            viewBack.isHidden = false
        }
        
        labelInfo.text = topic.items![position].hint
    }
    
    private func showFinalView(){
        viewClose.isHidden = false
        viewHint.isHidden = true
        viewQuestion.isHidden = true
        viewNext.isHidden = true
        finalViewContainer.isHidden = false
        viewBack.isHidden = false
        
        progressView.setProgress(1, animated: true)
    }
    
    private func saveAnswer(){
        topic.items![counter].answer?.answer = textViewUserInput.text
        textViewUserInput.text = ""
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        
        print(self.constraintBottomDoneBtn.constant)
        print(keyboardSize.height)
        
        self.constraintBottomDoneBtn.constant = keyboardSize.height - 15
        
        self.textViewBottomConstraint.constant = keyboardSize.height
        
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        
        self.constraintBottomDoneBtn.constant = 30
        self.textViewBottomConstraint.constant = 40
    }
    
    private func showSaveFavoriteView(){
        labelFavorite.text = "Save as Favorite"
        imgFavorite.image = UIImage(#imageLiteral(resourceName: "ic_star_outlined3"))
    }
    
    private func showSavedView(){
        labelFavorite.text = "Saved"
        imgFavorite.image = UIImage(#imageLiteral(resourceName: "ic_star_filled-1"))
    }
    
    private func gotToRoot(){
        self.dismiss(animated: false, completion: {
            self.topicQuoteController?.dismiss(animated: false, completion: {
                self.topicsController?.dismiss(animated: false, completion: {
                    
                })
            })
        })
    }
    
    private func showOptionsCreateCase(){
        textViewUserInput.endEditing(true)
        
        let alert = UIAlertController(title: "How would you like to exit?", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Save Entry", style: .default, handler: { (action) in
                    self.journalPageController?.showViewEntrySaved()
                    self.saveAnswersToServer()
                    self.gotToRoot()
                    
                }))
                alert.addAction(UIAlertAction(title: "Delete Entry", style: .default, handler: { (action) in
                    self.gotToRoot()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
        
    }
    
    private func showOptionsUpdateCase(){
        textViewUserInput.endEditing(true)
        
        let alert = UIAlertController(title: "How would you like to exit?", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Save Changes", style: .default, handler: { (action) in
                    self.saveAnswersToServer()
                    self.viewEntryController?.showViewEntrySaved(topic: self.topic)
                    self.gotToRoot()
                    
                }))
                alert.addAction(UIAlertAction(title: "Exit Without Saving", style: .default, handler: { (action) in
                    self.gotToRoot()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions

    @IBAction func didTapCloseBtn(_ sender: Any) {
        if isUpdateCase {
            showOptionsUpdateCase()
        }else {
            showOptionsCreateCase()
        }
    }
    
    @IBAction func didTapNextBtn(_ sender: Any) {
        counter = counter + 1
        setData()
    }
    
    @IBAction func didTapDoneBtn(_ sender: Any) {
        counter = counter + 1
        setData()
    }
    
    
    @IBAction func didTapBackBtn(_ sender: Any) {
        textViewUserInput.endEditing(true)
        if counter != 0 {
            counter = counter - 1
            setData()
        }
    }
    
    @IBAction func didTapAddFavoriteBtn(_ sender: Any) {
        if(isFavorite){
            isFavorite = false
            showSaveFavoriteView()
        }else{
            isFavorite = true
            showSavedView()
        }
    }
    
    @IBAction func didTapFinishJournalBtn(_ sender: Any) {
        journalPageController?.showViewEntrySaved()
        self.saveAnswersToServer()
        self.gotToRoot()
    }
    
    // MARK: - Server Work
    
    private func saveAnswersToServer(){
                
        var params: [String: Any] = [
            "topic_id": topic.id!,
            "is_favorite": isFavorite
        ]
        
        for (index, item) in self.topic.items!.enumerated(){
            
            if(item.question != nil){
             
                params["answers[\(index)][item_id]"] = "\(item.id!)"
                params["answers[\(index)][answer]"] = "\(item.answer?.answer ?? "")"
                
            }
        }
        
        viewModel.saveAnswers(params: params)
            .subscribe(onSuccess: { entry in
                self.entry = entry
            })
        .disposed(by: disposeBag)
    }
    
    /*private func updateFavoriteOnServer(entryId: Int){
                
        let params: [String: Any] = ["entry_id": entryId]
        
        
        viewModel.favorite(params: params)
            .subscribe(onCompleted: {
                //No Action
            })
        .disposed(by: disposeBag)
    }*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateJournalController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        
        topic.items![counter].answer?.answer = textView.text
    }

}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// MARK: - Helper
//extension CreateJournalController {
//
//  private func keyboardManagerVisible(_ state: Bool) {
//    IQKeyboardManager.shared().isEnableAutoToolbar = state
//  }
//}
