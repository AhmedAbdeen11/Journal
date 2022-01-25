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
    
    @IBOutlet weak var viewTabsContainer: UIView!
    
    
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
        
        viewTabsContainer.layer.shadowColor = UIColor.black.cgColor
        viewTabsContainer.layer.shadowOpacity = 0.1
        viewTabsContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        viewTabsContainer.layer.shadowRadius = 3
        viewTabsContainer.layer.shouldRasterize = true
        viewTabsContainer.layer.rasterizationScale = UIScreen.main.scale

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
