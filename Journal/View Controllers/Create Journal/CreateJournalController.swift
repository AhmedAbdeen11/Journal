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
    
    @IBOutlet weak var fbClose: MDCFloatingButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var labelInfo: UILabel!
    
    @IBOutlet weak var fbNext: MDCFloatingButton!
    
    @IBOutlet weak var fbBack: MDCFloatingButton!
    
    @IBOutlet weak var viewHint: UIView!
    
    @IBOutlet weak var viewQuestion: UIView!
    
    @IBOutlet weak var labelQuestionTitle: UILabel!
    
    @IBOutlet weak var textViewUserInput: UITextView!
    
    @IBOutlet weak var labelQuestionHint: UILabel!
    
    @IBOutlet weak var finalViewContainer: UIView!
    
    @IBOutlet weak var labelFinalText: UILabel!
    
    @IBOutlet weak var btnSaveToFavorites: MDCButton!
    
    @IBOutlet weak var btnFinishJournal: MDCButton!
    
    // MARK: - Variables
    
    var topic: Topic!
    
    var counter = 0
    
    var layouts = [String]()
    
    var journalPageController: JournalPageController!
    
    var topicsController: TopicsController!
    
    var topicQuoteController: TopicQuoteController!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CreateJournalViewModel(context: self)
        initViews()
        setData()
        initListeners()
    }
    
    private func initListeners(){
        self.textViewUserInput.delegate = self
    }
    
    private func initViews(){
        fbClose.backgroundColor = UIColor.white
        fbClose.setImage(#imageLiteral(resourceName: "big_x"), for: .normal)
        
        fbBack.backgroundColor = UIColor.white
        fbBack.setImage(#imageLiteral(resourceName: "ic_back"), for: .normal)
        
        fbNext.backgroundColor = UIColor(named: "Primary")
        fbNext.setImage(#imageLiteral(resourceName: "ic_forward"), for: .normal)
        
        //Final Container
        
        //Save to favorites button
        btnSaveToFavorites.backgroundColor = UIColor.white
        btnSaveToFavorites.setTitle("Save as Favourite", for: .normal)
        btnSaveToFavorites.layer.cornerRadius = 25
        btnSaveToFavorites.isUppercaseTitle = false
        btnSaveToFavorites.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
        btnSaveToFavorites.setBorderWidth(2, for: .normal)
        btnSaveToFavorites.setBorderColor(UIColor(named: "Primary"), for: .normal)
        btnSaveToFavorites.setTitleColor(UIColor(named: "Primary"), for: .normal)
        
        
        //Finish Journal button
        btnFinishJournal.backgroundColor = UIColor(named: "Primary")
        btnFinishJournal.setTitle("Finish Journal", for: .normal)
        btnFinishJournal.layer.cornerRadius = 25
        btnFinishJournal.isUppercaseTitle = false
        btnFinishJournal.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
        
    }
    
    private func setData(){
        var hint = Hint()
        hint?.id = 0
        hint?.title = "You’ve reached the end of this journal exercise"
        hint?.type = "after";
        topic.afterHints?.insert(hint!, at: 0)
        
        for _ in topic.beforeHints! {
            layouts.append("beforeHint")
        }
        
        for _ in topic.questions! {
            layouts.append("question")
        }
        
        for _ in topic.afterHints! {
            layouts.append("afterHint")
        }
        
        layouts.append("finalView")
        
        setFlowData()
    }
    
    private func showBeforeHint(position: Int){
        viewHint.isHidden = false
        viewQuestion.isHidden = true
        fbNext.isHidden = false
        finalViewContainer.isHidden = true
        if position == 0 {
            fbBack.isHidden = true
        }else{
            fbBack.isHidden = false
        }
        
        labelInfo.text = topic.beforeHints![position].title
        progressView.setProgress(Float(counter)/Float(layouts.count), animated: true)
    }
    
    private func showQuestion(position: Int){
        viewHint.isHidden = true
        finalViewContainer.isHidden = true
        viewQuestion.isHidden = false
        fbNext.isHidden = false
        fbBack.isHidden = false
        
        textViewUserInput.text = topic.questions![position].answer.answer ?? ""
        labelQuestionTitle.text = topic.questions![position].question
        labelQuestionHint.text = topic.questions![position].hint
        progressView.setProgress(Float(counter)/Float(layouts.count), animated: true)
    }
    
    private func showAfterHint(position: Int){
        viewHint.isHidden = false
        viewQuestion.isHidden = true
        fbNext.isHidden = false
        finalViewContainer.isHidden = true
        fbBack.isHidden = false
        
        labelInfo.text = topic.afterHints![position].title
        progressView.setProgress(Float(counter)/Float(layouts.count), animated: true)
    }
    
    private func showFinalView(){
        viewHint.isHidden = true
        viewQuestion.isHidden = true
        fbNext.isHidden = true
        finalViewContainer.isHidden = false
        fbBack.isHidden = false
        
        progressView.setProgress(1, animated: true)
    }
    
    private func setFlowData(){
        if counter < layouts.count {
            
            switch layouts[counter] {
            
                case "beforeHint":
                    do {
                        self.showBeforeHint(position: counter)
                    }
                    break
              
            case "question":
                do {
                    self.showQuestion(position: counter - topic.beforeHints!.count)
                }
                    
            case "afterHint":
                do {
                    self.showAfterHint(position: counter - (topic.beforeHints!.count + topic.questions!.count))
                }
                
            case "finalView":
                do {
                    self.showFinalView()
                }
                    
                default:break
                
            }
            
        }
    }
    
    private func saveAnswer(questionPosition: Int){
        topic.questions![questionPosition].answer.answer = textViewUserInput.text
        textViewUserInput.text = ""
    }
    
    // MARK: - Actions

    @IBAction func didTapCloseBtn(_ sender: Any) {
        textViewUserInput.endEditing(true)
        
        let alert = UIAlertController(title: "How would you like to exit?", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Save Entry", style: .default, handler: { (action) in
                    self.journalPageController.showViewEntrySaved()
                    self.saveAnswersToServer()
                    self.dismiss(animated: false, completion: {
                        self.topicQuoteController.dismiss(animated: false, completion: {
                            self.topicsController.dismiss(animated: false, completion: {
                                
                            })
                        })
                    })
                    
                }))
                alert.addAction(UIAlertAction(title: "Delete Entry", style: .default, handler: { (action) in
                    
                    self.dismiss(animated: false, completion: {
                        self.topicQuoteController.dismiss(animated: false, completion: {
                            self.topicsController.dismiss(animated: false, completion: {
                                
                            })
                        })
                    })
                    
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func didTapNextBtn(_ sender: Any) {
        textViewUserInput.endEditing(true)
        counter = counter + 1
        setFlowData()
    }
    
    @IBAction func didTapBackBtn(_ sender: Any) {
        textViewUserInput.endEditing(true)
        if counter != 0 {
            counter = counter - 1
            setFlowData()
        }
    }
    
    @IBAction func didTapAddFavoriteBtn(_ sender: Any) {
    }
    
    @IBAction func didTapFinishJournalBtn(_ sender: Any) {
        saveAnswersToServer()
        journalPageController.showViewEntrySaved()
        self.dismiss(animated: false, completion: {
            self.topicQuoteController.dismiss(animated: false, completion: {
                self.topicsController.dismiss(animated: false, completion: {
                    
                })
            })
        })
    }
    
    // MARK: - Server Work
    
    private func saveAnswersToServer(){
        
        let date = Date().string(format: "yyyy-MM-dd")
        
        var params: [String: Any] = [:]
        
        for (index, question) in self.topic.questions!.enumerated(){
            params["answers[\(index)][question_id]"] = "\(question.id!)"
            params["answers[\(index)][date]"] = "\(date)"
            params["answers[\(index)][answer]"] = "\(question.answer.answer!)"
        }
        
        viewModel.saveAnswers(params: params)
            .subscribe(onCompleted: {
                //No Action
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

extension CreateJournalController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let questionPosition = counter - topic.afterHints!.count
        
        if questionPosition >= 0 && questionPosition < topic.questions!.count {
            topic.questions![questionPosition].answer.answer = textView.text
//            saveAnswerToServer(questionPosition: questionPosition)
        }
    }

}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
