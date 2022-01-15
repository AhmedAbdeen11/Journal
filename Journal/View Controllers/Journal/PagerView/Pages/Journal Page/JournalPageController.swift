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
    
    @IBOutlet weak var viewStartDay: UIView!
    
    @IBOutlet weak var viewEndDay: UIView!
    
    var journals = [Journal]()
    
    @IBOutlet weak var viewEntrySaved: UIView!
    
    
    // MARK: - Properties
    
    @IBOutlet weak var tableViewJournals: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    // MARK: - Variables
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = JournalPageViewModel(context: self)
        initViews()
        getJournals()
    }
    
    private func initViews(){
        viewStartDay.layer.cornerRadius = 10
        viewStartDay.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewStartDay.layer.borderWidth = 1
        
        viewStartDay.layer.shadowColor = UIColor(rgb: 0xD1D7DC).cgColor
        viewStartDay.layer.shadowOpacity = 0.5
        viewStartDay.layer.shadowOffset = .zero
        viewStartDay.layer.shadowRadius = 10
        
        
        viewEndDay.layer.cornerRadius = 10
        viewEndDay.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewEndDay.layer.borderWidth = 1
        
        viewEndDay.layer.shadowColor = UIColor(rgb: 0xD1D7DC).cgColor
        viewEndDay.layer.shadowOpacity = 0.5
        viewEndDay.layer.shadowOffset = .zero
        viewEndDay.layer.shadowRadius = 10
        
        viewEntrySaved.layer.cornerRadius = 15
    }
    
    func showViewEntrySaved(){
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.dismissViewEntrySaved), userInfo: nil, repeats: false)
        viewEntrySaved.isHidden = false
    }
    
    @objc private func dismissViewEntrySaved(){
        self.viewEntrySaved.isHidden = true
    }

    //MARK: - Server Work
    
    private func getJournals(){
      
        Utility.showProgressDialog(view: self.view)
        
        viewModel.getJournals()
            .subscribe(onSuccess: { chats in

                Utility.hideProgressDialog(view: self.view)
                
                self.journals.append(contentsOf: chats)
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
    }
    

}

//MARK: - Extensions

extension JournalPageController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTopicsSegue", sender:     journals[indexPath.row])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let journal = journals[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalCell
        
        cell.img.sd_setImage(with: URL(string: journal.image ?? ""), placeholderImage: UIImage(named: ""))
        
        cell.title.text = journal.title
        
        cell.containerView.layer.cornerRadius = 10
        cell.containerView.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        cell.containerView.layer.borderWidth = 1
        
        cell.containerView.layer.shadowColor = UIColor(rgb: 0xD1D7DC).cgColor
        cell.containerView.layer.shadowOpacity = 0.5
        cell.containerView.layer.shadowOffset = .zero
        cell.containerView.layer.shadowRadius = 10
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    
}
