//
//  ViewController.swift
//  Journal
//
//  Created by Abdeen on 1/8/22.
//

import UIKit
import RxSwift

class MainController: UIViewController {

    // MARK: - View Model
//    var viewModel : LoginViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - Properties

    @IBOutlet weak var homeContainer: UIView!
    
    @IBOutlet weak var profileContainer: UIView!
    
    // MARK: - Variables
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions

    @IBAction func didTapHomeBtn(_ sender: Any) {
        Utility.showAlertNew(message: "Coming Soon..", context: self)
    }
    
    @IBAction func didTapMeditateBtn(_ sender: Any) {
        Utility.showAlertNew(message: "Coming Soon..", context: self)
    }
    
    @IBAction func didTapJournalBtn(_ sender: Any) {
        profileContainer.isHidden = true
        homeContainer.isHidden = false
    }
    
    @IBAction func didTapTheoryBtn(_ sender: Any) {
        Utility.showAlertNew(message: "Coming Soon..", context: self)
    }
    
    @IBAction func didTapProfileBtn(_ sender: Any) {
        profileContainer.isHidden = false
        homeContainer.isHidden = true
    }
    
    
}

