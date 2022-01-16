//
//  EntriesPageControllerViewController.swift
//  Journal
//
//  Created by Abdeen on 1/13/22.
//

import UIKit
import RxSwift
import SDWebImage
import MaterialComponents
import SwiftyJSON

class EntriesPageController: UIViewController {

    // MARK: - View Model
    
    var viewModel : EntriesViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    @IBOutlet weak var viewSearch: UIView!
    
    @IBOutlet weak var textFieldSearch: UITextField!
    
    @IBOutlet weak var fbFavorite: MDCFloatingButton!
    
    @IBOutlet weak var tableViewEntries: UITableView!
    
    @IBOutlet weak var imageViewSearch: UIImageView!
    
    // MARK: - Variables
    
    var entries = [Entry]()
    
    var formattedEntries = [Entry]()
    
    var isFavoriteShown = false
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = EntriesViewModel(context: self)
        
        initViews()
        getMyEntries()
    }
    
    private func initViews(){
        fbFavorite.backgroundColor = UIColor.white
        fbFavorite.setImage(#imageLiteral(resourceName: "ic_star_outline"), for: .normal)
        
        viewSearch.layer.cornerRadius = 25
        textFieldSearch.borderStyle = .none
    }

    private func formatEntries(){
        formattedEntries.removeAll()
        
        if !entries.isEmpty{
            
            var counter = 0
            var entry: Entry! = Entry()
            entry.month = entries[counter].month
            formattedEntries.append(entry)
            
            var month = entry.month
            
            for item in entries {
                if month != item.month {
                    var entry: Entry! = Entry()
                    entry.month = item.month
                    formattedEntries.append(entry)
                    
                    month = item.month
                }
                
                formattedEntries.append(item)
                counter = counter + 1
            }
        }
        
        self.tableViewEntries.reloadData()
    }
    
    private func showFavorites(){
        formattedEntries.removeAll()
        
        if !entries.isEmpty{
            
            var counter = 0
            var entry: Entry! = Entry()
            entry.month = "Your Favorites"
            formattedEntries.append(entry)
            
            for item in entries {
                if item.isFavorite! {
                    formattedEntries.append(item)
                    counter = counter + 1
                }
            }
        }
        
        self.tableViewEntries.reloadData()
    }
    
    func updateFavoriteWithId(id: Int, isFavorite: Bool){
        var counter = 0
        for item in entries {
            if item.id == id {
                entries[counter].isFavorite = isFavorite
                return
            }
            counter = counter + 1
        }
    }
    
    private func search(query: String){
        formattedEntries.removeAll()
        
        var counter = 0
        
        for item in entries {
            if(item.topic!.title!.lowercased().contains(query.lowercased())){
                if(isFavoriteShown){
                    if item.isFavorite! {
                        formattedEntries.append(item)
                    }
                }else{
                    formattedEntries.append(item)
                }
            }
            
            counter = counter + 1
        }
        
        tableViewEntries.reloadData()
    }
    
    func favoriteUpdatedCallback(entryId: Int, isFavorite: Bool){
        updateFavoriteWithId(id: entryId, isFavorite: isFavorite)
        if(isFavoriteShown){
            showFavorites()
        }else{
            formatEntries()
        }
        updateFavoriteOnServer(entryId: entryId)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowViewEntrySegue" {
            let viewEntryController = segue.destination as! ViewEntryController
            viewEntryController.entry = sender as? Entry
            viewEntryController.entriesPageController = self
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTextChangedSearchField(_ sender: Any) {
        if textFieldSearch.text!.isEmpty {
            if(isFavoriteShown){
                showFavorites()
            }else{
                formatEntries()
            }
        }else{
            search(query: textFieldSearch.text!)
        }
        
    }
    
    @IBAction func didTapFavoriteBtn(_ sender: Any) {
        if isFavoriteShown {
            isFavoriteShown = false
            formatEntries()
            fbFavorite.backgroundColor = UIColor.white
            fbFavorite.setImage(#imageLiteral(resourceName: "ic_star_outline"), for: .normal)
        }else{
            isFavoriteShown = true
            showFavorites()
            fbFavorite.backgroundColor = UIColor(named: "Primary")
            fbFavorite.setImage(#imageLiteral(resourceName: "ic_start_filled"), for: .normal)
        }
    }
    
    
    // MARK: - Server Work
    
    private func getMyEntries(){
      
//        Utility.showProgressDialog(view: self.view)
        
        viewModel.myEntries()
            .subscribe(onSuccess: { journals in

//                Utility.hideProgressDialog(view: self.view)
                
                self.entries.removeAll()
                self.entries.append(contentsOf: journals)
                self.formatEntries()
            })
        .disposed(by: disposeBag)
        
    }
    
    private func updateFavoriteOnServer(entryId: Int){
                
        let params: [String: Any] = ["entry_id": entryId]
        
        
        viewModel.favorite(params: params)
            .subscribe(onCompleted: {
                //No Action
            })
        .disposed(by: disposeBag)
    }
    
    

}

//MARK: - Extensions

extension EntriesPageController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formattedEntries.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if formattedEntries[indexPath.row].id != nil {
        
            performSegue(withIdentifier: "ShowViewEntrySegue", sender: formattedEntries[indexPath.row])
            
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let entryItem = formattedEntries[indexPath.row]
        
        if entryItem.id == nil {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateCell
            
            cell.labelDate.text = entryItem.month
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            
            
            return cell
            
        }else{
         
            let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryCell
            
            cell.labelTitle.text = entryItem.topic?.title
            cell.labelQuote.text = entryItem.topic?.quote
            cell.labelDate.text = entryItem.dayMonth
            
            if entryItem.isFavorite ?? false {
                cell.imageViewStar.isHidden = false
            }else{
                cell.imageViewStar.isHidden = true
            }
            
            cell.viewContainer.layer.cornerRadius = 10
            cell.viewContainer.layer.borderColor = UIColor(rgb: 0xBFCDDB).cgColor
            cell.viewContainer.layer.borderWidth = 1
            
            cell.viewContainer.layer.shadowColor = UIColor(rgb: 0xD1D7DC).cgColor
            cell.viewContainer.layer.shadowOpacity = 0.5
            cell.viewContainer.layer.shadowOffset = .zero
            cell.viewContainer.layer.shadowRadius = 10
         
            cell.selectionStyle = .none
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isFavoriteShown
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.updateFavoriteOnServer(entryId: formattedEntries[indexPath.row].id!)
            self.updateFavoriteWithId(id: formattedEntries[indexPath.row].id!, isFavorite: false)
            formattedEntries.remove(at: indexPath.row)
            tableViewEntries.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
}
