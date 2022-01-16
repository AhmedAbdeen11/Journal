//
//  ViewEntryController.swift
//  Journal
//
//  Created by Abdeen on 1/16/22.
//

import UIKit
import RxSwift
import MaterialComponents
import SDWebImage

class ViewEntryController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var fbFavorite: MDCFloatingButton!
    
    @IBOutlet weak var fbOptions: MDCFloatingButton!
    
    @IBOutlet weak var fbClose: MDCFloatingButton!
    
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var labelTime: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var viewTitleContainer: UIView!
    
    // MARK: - Variables
    
    var entriesPageController: EntriesPageController!
    
    var entry: Entry!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        setData()
    }
    
    private func initViews(){
        viewContainer.layer.cornerRadius = 50
        viewContainer.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
        viewContainer.layer.borderWidth = 1
        
        viewContainer.layer.shadowColor = UIColor(rgb: 0xD1D7DC).cgColor
        viewContainer.layer.shadowOpacity = 0.5
        viewContainer.layer.shadowOffset = .zero
        viewContainer.layer.shadowRadius = 10
        
        if entry.isFavorite! {
            fbFavorite.backgroundColor = UIColor(named: "Primary")
            fbFavorite.setImage(#imageLiteral(resourceName: "ic_start_filled"), for: .normal)
        }else{
            fbFavorite.backgroundColor = UIColor.white
            fbFavorite.setImage(#imageLiteral(resourceName: "ic_star_outline"), for: .normal)
        }
        
        
        fbOptions.backgroundColor = UIColor.white
        fbOptions.setImage(#imageLiteral(resourceName: "ic_dots"), for: .normal)
        
        fbClose.backgroundColor = UIColor.white
        fbClose.setImage(#imageLiteral(resourceName: "big_x"), for: .normal)
    }
    
    private func setData(){
        labelDate.text = entry.dayMonthYear
        labelTime.text = entry.time
        labelTitle.text = entry.topic?.title
    }
    
    // MARK: - Actions
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOptionsBtn(_ sender: Any) {
    }
    
    @IBAction func didTapFavoriteBtn(_ sender: Any) {
        
        entry.isFavorite = !entry.isFavorite!
        
        if entry.isFavorite! {
            fbFavorite.backgroundColor = UIColor(named: "Primary")
            fbFavorite.setImage(#imageLiteral(resourceName: "ic_start_filled"), for: .normal)
        }else{
            fbFavorite.backgroundColor = UIColor.white
            fbFavorite.setImage(#imageLiteral(resourceName: "ic_star_outline"), for: .normal)
        }
        
        entriesPageController.favoriteUpdatedCallback(entryId: entry.id!, isFavorite: entry.isFavorite!)
    }
    
    
    // MARK: - Server Work

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

extension ViewEntryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entry.topic!.questions!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let question = self.entry.topic!.questions![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
        
        cell.labelQuestion.text = question.question
        cell.labelAnswer.text = question.answer?.answer
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        
        return cell
    }
    
}
