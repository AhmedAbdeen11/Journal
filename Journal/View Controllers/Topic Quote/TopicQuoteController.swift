//
//  TopicQuoteController.swift
//  Journal
//
//  Created by Abdeen on 1/14/22.
//

import UIKit
import RxSwift
import MaterialComponents
import SDWebImage

class TopicQuoteController: UIViewController {

    // MARK: - View Model
    
    // MARK: - Properties
    
    @IBOutlet weak var labelTitle: UILabel!

    @IBOutlet weak var viewClose: UIView!
    
    @IBOutlet weak var viewNotification: UIView!
    
    @IBOutlet weak var btnBegin: UIButton!
    
    @IBOutlet weak var viewQuoteContainer: UIView!
    
    @IBOutlet weak var labelQuotee: UILabel!
    
    @IBOutlet weak var
        labelQuote: UILabel!
    
    @IBOutlet weak var labelSubtitle: UILabel!
    
    @IBOutlet weak var viewQuoteDescription: UIView!
    
    @IBOutlet weak var labelQuoteDescription: UILabel!
    
    @IBOutlet weak var btnReadMe: UIButton!
    
    @IBOutlet weak var viewReadMeContainer: UIView!
    
    @IBOutlet weak var viewHighlight: UIView!
    
    @IBOutlet weak var viewTriangle: Triangle!
    
    @IBOutlet weak var viewRounded: UIView!
    
    // MARK: - Variables
    
    var topic: Topic!
    
    var journalPageController: JournalPageController!
    
    var topicsController: TopicsController!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        setData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            self.viewHighlight.frame.origin.y += 7
            
        }, completion: nil)
    }
    
    private func initViews(){
        //View Close
        viewClose.makeFabButton()
        
        //View Notification
        viewNotification.makeFabButton()
        
        //Begin button
        btnBegin.layer.cornerRadius = 25
        btnBegin.addShadow()
        
        //Quote Container
        viewQuoteContainer.layer.cornerRadius = 10
        viewQuoteContainer.layer.borderColor = UIColor(rgb: 0xD1D7DC).cgColor
        viewQuoteContainer.layer.borderWidth = 1

        viewQuoteContainer.addShadow()
        
        //Quote Description Container
        viewQuoteDescription.layer.cornerRadius = 10
        viewQuoteDescription.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewQuoteDescription.layer.borderWidth = 1
        
        viewQuoteDescription.addShadow()
        
        //Read Me Container
        viewReadMeContainer.layer.cornerRadius = 10
        viewReadMeContainer.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewReadMeContainer.layer.borderWidth = 1
        
        viewReadMeContainer.addShadow()
        
        //View Rounded
        viewRounded.layer.cornerRadius = 10

        
        
    }
    
    private func setData(){
        labelTitle.text = topic.title
        
        if topic.subtitle != nil || !topic.subtitle!.isEmpty {
            labelSubtitle.text = "(\(topic.subtitle!))"
        }
        
        labelQuotee.text = topic.quotee
        labelQuote.text = "\"\(topic.quote!)\""
        labelQuoteDescription.text = topic.description
    }
    
    // MARK: - Actions
    
    @IBAction func didTapBeginButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showCreateJournalSegue", sender: nil)
    }
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapReadMeBtn(_ sender: Any) {
        viewReadMeContainer.isHidden = true
        viewQuoteDescription.isHidden = false
    }
    
    @IBAction func didTapNotifications(_ sender: Any) {
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showCreateJournalSegue" {
            let createJournalController = segue.destination as! CreateJournalController
            createJournalController.topic = topic
            createJournalController.journalPageController = self.journalPageController
            createJournalController.topicsController = self.topicsController
            createJournalController.topicQuoteController = self
        }
        
    }

}
