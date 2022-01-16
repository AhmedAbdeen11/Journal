//
//  JournalController.swift
//  Journal
//
//  Created by Abdeen on 1/13/22.
//

import UIKit
import SWSegmentedControl

class JournalController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var segmentedControl: SWSegmentedControl!
    
    // MARK: - Variables
    
    var pageController: PageController!
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    private func initViews(){
        segmentedControl.items = ["Journal", "Entries"]
        segmentedControl.font = UIFont(name: "Baskerville", size: 19)!
    }
    
    func changeSegmentedControlSelection(index: Int){
        segmentedControl.setSelectedSegmentIndex(index, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func didUserSelectTab(_ sender: Any) {
        pageController.changePage(index: segmentedControl.selectedSegmentIndex)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPageController" {
            pageController = segue.destination as? PageController
        }
    }


}
