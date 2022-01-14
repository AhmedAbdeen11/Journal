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
    
    @IBOutlet weak var fbClose: MDCFloatingButton!
    
    @IBOutlet weak var btnBegin: MDCButton!
    
    @IBOutlet weak var viewQuoteContainer: UIView!
    
    @IBOutlet weak var labelQuotee: UILabel!
    
    @IBOutlet weak var
        labelQuote: UILabel!
    
    @IBOutlet weak var viewQuoteDescription: UIView!
    
    @IBOutlet weak var labelQuoteDescription: UILabel!
    
    @IBOutlet weak var btnReadMe: UIButton!
    
    @IBOutlet weak var viewReadMeContainer: UIView!
    
    // MARK: - Variables
    
    var topic: Topic!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        setData()
    }
    
    private func initViews(){
        fbClose.backgroundColor = UIColor.white
        fbClose.setImage(#imageLiteral(resourceName: "big_x"), for: .normal)
        
        //Begin button
        btnBegin.backgroundColor = UIColor(named: "Primary")
        btnBegin.setTitle("Begin", for: .normal)
        btnBegin.layer.cornerRadius = 25
        btnBegin.isUppercaseTitle = false
        btnBegin.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
        
        //Quote Container
        viewQuoteContainer.layer.cornerRadius = 10
        viewQuoteContainer.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewQuoteContainer.layer.borderWidth = 1
        
        viewQuoteContainer.layer.shadowColor = UIColor(rgb: 0xD1D7DC).cgColor
        viewQuoteContainer.layer.shadowOpacity = 0.5
        viewQuoteContainer.layer.shadowOffset = .zero
        viewQuoteContainer.layer.shadowRadius = 10
        
        //Quote Description Container
        viewQuoteDescription.layer.cornerRadius = 10
        viewQuoteDescription.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewQuoteDescription.layer.borderWidth = 1
        
        viewQuoteDescription.layer.shadowColor = UIColor(rgb: 0xD1D7DC).cgColor
        viewQuoteDescription.layer.shadowOpacity = 0.5
        viewQuoteDescription.layer.shadowOffset = .zero
        viewQuoteDescription.layer.shadowRadius = 10
        
        
        viewReadMeContainer.layer.cornerRadius = 10
        viewReadMeContainer.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewReadMeContainer.layer.borderWidth = 1
        
        viewReadMeContainer.layer.shadowColor = UIColor(rgb: 0xD1D7DC).cgColor
        viewReadMeContainer.layer.shadowOpacity = 0.5
        viewReadMeContainer.layer.shadowOffset = .zero
        viewReadMeContainer.layer.shadowRadius = 10
        
    }
    
    private func setData(){
        labelTitle.text = topic.title
        
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
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showCreateJournalSegue" {
            let createJournalController = segue.destination as! CreateJournalController
            createJournalController.topic = topic
        }
        
    }

}
