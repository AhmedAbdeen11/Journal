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

    // MARK: - View Model
    
    var viewModel = ViewEntryViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var viewFavorite: UIView!
    
    @IBOutlet weak var viewOptions: UIView!
    
    @IBOutlet weak var viewClose: UIView!
    
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var labelTime: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var viewTitleContainer: UIView!
    
    @IBOutlet weak var imageViewFavorite: UIImageView!
    
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
        
        viewContainer.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 50)
        viewContainer.addShadow()
        
        if entry.isFavorite! {
            viewFavorite.backgroundColor = UIColor(named: "Primary")
            imageViewFavorite.image = UIImage(named: "ic_star_filled")
            
        }else{
            viewFavorite.backgroundColor = UIColor.white
            imageViewFavorite.image = UIImage(named: "ic_star")
        }
        
        viewFavorite.layer.cornerRadius = 25
        viewFavorite.addShadow()
        
        viewClose.layer.cornerRadius = 25
        viewClose.addShadow()
        
        viewOptions.layer.cornerRadius = 25
        viewOptions.addShadow()
        
    }
    
    private func setData(){
        labelDate.text = entry.dayMonthYear
        labelTime.text = entry.time
        labelTitle.text = entry.topic?.title
    }
    
    private func showDeleteDialog(){
        let alert = UIAlertController(title: "", message: "Are you sure you want to delete?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            
            self.deleteEntry()
            
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        //==================Ipad case================//
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        //===========================================//
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOptionsBtn(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "\(entry.dayMonthYear!) at \(entry.time!)", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (action) in
            
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            
            self.showDeleteDialog()
            
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        //==================Ipad case================//
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        //===========================================//
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didTapFavoriteBtn(_ sender: Any) {
        
        entry.isFavorite = !entry.isFavorite!
        
        if entry.isFavorite! {
            viewFavorite.backgroundColor = UIColor(named: "Primary")
            imageViewFavorite.image = UIImage(named: "ic_star_filled")
        }else{
            viewFavorite.backgroundColor = UIColor.white
            imageViewFavorite.image = UIImage(named: "ic_star")
        }
        
        entriesPageController.favoriteUpdatedCallback(entryId: entry.id!, isFavorite: entry.isFavorite!)
    }
    
    
    // MARK: - Server Work

    private func deleteEntry(){
  
        Utility.showProgressDialog(view: self.view)
        
        let params: [String: Any] =
            [
                "entry_id": entry.id!
            ]
        
        viewModel.deleteEntry(params: params)
            .subscribe(onCompleted: {
                Utility.hideProgressDialog(view: self.view)
                self.entriesPageController.getMyEntries()
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
