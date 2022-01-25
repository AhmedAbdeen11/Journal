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
    
    @IBOutlet weak var viewFavorite: UIView!
    
    @IBOutlet weak var imageViewFavorite: UIImageView!
    
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
//        getMyEntries()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMyEntries()
    }
    
    private func initViews(){
        viewFavorite.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 25)
        viewFavorite.addShadow()
        
        viewSearch.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 25)
        viewSearch.addShadow()
        
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
            if item.entrableType == "UserJournal" {
                if(item.journal!.title!.lowercased().contains(query.lowercased())){
                    if(isFavoriteShown){
                        if item.isFavorite! {
                            formattedEntries.append(item)
                        }
                    }else{
                        formattedEntries.append(item)
                    }
                }
            }else{
                if(item.topic!.title!.lowercased().contains(query.lowercased())){
                    if(isFavoriteShown){
                        if item.isFavorite! {
                            formattedEntries.append(item)
                        }
                    }else{
                        formattedEntries.append(item)
                    }
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
            viewFavorite.backgroundColor = UIColor.white
            imageViewFavorite.image = UIImage(named: "ic_star")
        }else{
            isFavoriteShown = true
            showFavorites()
            viewFavorite.backgroundColor = UIColor(named: "Primary")
            imageViewFavorite.image = UIImage(named: "ic_star_filled")
        }
    }
    
    
    // MARK: - Server Work
    
    func getMyEntries(){
      
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
            
            
            if entryItem.entrableType == "UserJournal" {
                cell.labelTitle.text = entryItem.journal?.title
                cell.labelQuote.text = entryItem.journal?.text
                
            }else{
                cell.labelTitle.text = entryItem.topic?.title
                cell.labelQuote.text = entryItem.topic?.quote
                
            }
            
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
         
            cell.viewContainer.addShadow()
            
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isFavoriteShown
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                self.updateFavoriteOnServer(entryId: self.formattedEntries[indexPath.row].id!)
                self.updateFavoriteWithId(id: self.formattedEntries[indexPath.row].id!, isFavorite: false)
                self.formattedEntries.remove(at: indexPath.row)
                self.tableViewEntries.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                    completionHandler(true)
                }
        deleteAction.image = UIGraphicsImageRenderer(size: CGSize(width: 50, height: 50)).image { _ in
            UIImage(named: "delete_trash")?.draw(in: CGRect(x: 0, y: 0, width: 50, height: 50))
        }
        deleteAction.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}
