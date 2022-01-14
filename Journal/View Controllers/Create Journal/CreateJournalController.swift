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
    
    // MARK: - Properties
    
    @IBOutlet weak var fbClose: MDCFloatingButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var labelInfo: UILabel!
    
    @IBOutlet weak var fbNext: MDCFloatingButton!
    
    @IBOutlet weak var fbBack: MDCFloatingButton!
    
    // MARK: - Variables
    
    var topic: Topic!
    
    var beforePosition = 0
    
    var afterPosition = -1
    
    var questionsPosition = -1
    
    var progressCounter = 0
    
    var totalSize = 0
    
    @IBOutlet weak var viewHint: UIView!
    
    @IBOutlet weak var viewQuestion: UIView!
    
    @IBOutlet weak var labelQuestionTitle: UILabel!
    
    @IBOutlet weak var textViewUserInput: UITextView!
    
    @IBOutlet weak var labelQuestionHint: UILabel!
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        setData()
    }
    
    private func initViews(){
        fbClose.backgroundColor = UIColor.white
        fbClose.setImage(#imageLiteral(resourceName: "big_x"), for: .normal)
        
        fbBack.backgroundColor = UIColor.white
        fbBack.setImage(#imageLiteral(resourceName: "ic_back"), for: .normal)
        fbBack.isHidden = true
        
        fbNext.backgroundColor = UIColor(named: "Primary")
        fbNext.setImage(#imageLiteral(resourceName: "ic_forward"), for: .normal)
    }
    
    private func setData(){
        totalSize = topic.beforeHints!.count + topic.afterHints!.count
            + topic.questions!.count
        labelInfo.text = topic.beforeHints![beforePosition].title
    }
    
    // MARK: - Actions

    @IBAction func didTapCloseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapNextBtn(_ sender: Any) {
        
        if beforePosition+1 < topic.beforeHints!.count {
        
            beforePosition += 1
            labelInfo.text = topic.beforeHints![beforePosition].title
            
        }else if questionsPosition+1 < topic.questions!.count {
            viewHint.isHidden = true
            viewQuestion.isHidden = false
            
            questionsPosition += 1
            labelQuestionTitle.text = topic.questions![questionsPosition].question
            labelQuestionHint.text = topic.questions![questionsPosition].hint
            
        }else if afterPosition+1 < topic.afterHints!.count {
            viewHint.isHidden = false
            viewQuestion.isHidden = true
            
            afterPosition += 1
            labelInfo.text = topic.afterHints![afterPosition].title
            
            if afterPosition+1 == topic.afterHints!.count { //Last one
                progressCounter = totalSize
            }
        }
        
        progressCounter += 1
        progressView.setProgress(Float(progressCounter)/Float(totalSize), animated: true)
    }
    
    @IBAction func didTapBackBtn(_ sender: Any) {
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
