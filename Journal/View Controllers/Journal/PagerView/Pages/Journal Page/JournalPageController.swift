//
//  JournalPageController.swift
//  Journal
//
//  Created by Abdeen on 1/13/22.
//

import UIKit
import RxSwift
import SDWebImage
import SwiftyJSON

class JournalPageController: UIViewController {

    // MARK: - View Model
    
    var viewModel : JournalPageViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var viewStartDay: UIView!
    
    @IBOutlet weak var viewSubStartDay: UIView!
    
    @IBOutlet weak var viewEndDay: UIView!
    
    @IBOutlet weak var viewSubEnday: UIView!
    
    
    @IBOutlet weak var viewEntrySaved: UIView!
    
    @IBOutlet weak var tableViewJournals: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewAddJournal: UIView!
    
    // MARK: - Variables
    
    var journals = [Journal]()
    
    var listJournals = [Journal]()
    
    var startDayJournal: Journal!
    
    var endDayJournal: Journal!
    
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = JournalPageViewModel(context: self)
        initViews()
        getJournals()
    }
    
    private func initViews(){
        viewSubStartDay.layer.cornerRadius = 10

        viewSubStartDay.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewSubStartDay.layer.borderWidth = 1
        
        viewStartDay.addShadow()
        
        //=========================//
        
        viewSubEnday.layer.cornerRadius = 10

        viewSubEnday.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewSubEnday.layer.borderWidth = 1
        
        viewEndDay.addShadow()
        
        //=======================//
        
        viewEntrySaved.layer.cornerRadius = 15
        
        viewAddJournal.layer.cornerRadius = 39
        viewAddJournal.addShadow()

    }
    
    func showViewEntrySaved(){
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.dismissViewEntrySaved), userInfo: nil, repeats: false)
        viewEntrySaved.isHidden = false
    }
    
    @objc private func dismissViewEntrySaved(){
        self.viewEntrySaved.isHidden = true
    }
    
    private func sortJournals(){
        var counter = 0
        listJournals.removeAll()
        for item in journals {
            if item.title == "start_the_day" {
                startDayJournal = item
            }else if item.title == "end_the_day" {
                endDayJournal = item
            }else{
                listJournals.append(item)
            }
            
            counter = counter + 1
        }
    }

    //MARK: - Actions
    
    @IBAction func didTapStartTheDayBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowTopicQuoteController", sender: startDayJournal)
    }
    
    
    @IBAction func didTapEndTheDayBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowTopicQuoteController", sender: endDayJournal)
    }
    
    @IBAction func didTapBtnAddJournal(_ sender: Any) {
        
    }
    
    
    //MARK: - Server Work
    
    private func getJournals(){
      
        Utility.showProgressDialog(view: self.view)
        
        viewModel.getJournals()
            .subscribe(onSuccess: { journals in

                Utility.hideProgressDialog(view: self.view)
                self.journals.removeAll()
                self.journals.append(contentsOf: journals)
                self.sortJournals()
                self.tableViewJournals.reloadData()
            })
        .disposed(by: disposeBag)
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTopicsSegue" {
            let topicsController = segue.destination as! TopicsController
            topicsController.journal = sender as? Journal
            topicsController.journalPageController = self
        }
        
        if segue.identifier == "ShowTopicQuoteController" {
            let navigationController = segue.destination as! UINavigationController
            
            let topicQuoteController = navigationController.viewControllers.first as! TopicQuoteController
            topicQuoteController.topic = (sender as? Journal)?.topics![0]
            topicQuoteController.journalPageController = self
        }
        
        if segue.identifier == "ShowAddJournalSegue" {
            let addJournalController = segue.destination as! AddJournalController
            addJournalController.journalPageController = self
        }
    }
    

}

//MARK: - Extensions

extension JournalPageController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listJournals.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTopicsSegue", sender:     listJournals[indexPath.row])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let journal = listJournals[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalCell
        
        cell.img.sd_setImage(with: URL(string: journal.image ?? ""), placeholderImage: UIImage(named: ""))
        
        cell.title.text = journal.title
        
        cell.containerView.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 10)
        cell.containerView.addShadow()
        
        let path = UIBezierPath(roundedRect:cell.viewImgContainer.bounds,
                                byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 10, height:  10))

        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        cell.viewImgContainer.layer.mask = maskLayer
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
        
    }
    
}
