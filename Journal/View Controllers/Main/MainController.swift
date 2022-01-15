//
//  ViewController.swift
//  Journal
//
//  Created by Abdeen on 1/8/22.
//

import UIKit
import RxSwift
import MaterialComponents

class MainController: UIViewController {

    // MARK: - View Model
//    var viewModel : LoginViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - Properties

    @IBOutlet weak var homeContainer: UIView!
    
    @IBOutlet weak var profileContainer: UIView!
    
    @IBOutlet weak var viewComingSoonContainer: UIView!
    
    @IBOutlet weak var viewComingSoon: UIView!
    
    @IBOutlet weak var btnGotIt: MDCButton!
    
    // MARK: - Variables
    
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initViews()
    }
    
    private func initViews(){
        viewComingSoon.layer.cornerRadius = 20
        
        btnGotIt.backgroundColor = UIColor(named: "Primary")
        btnGotIt.setTitle("Got it", for: .normal)
        btnGotIt.layer.cornerRadius = 25
        btnGotIt.isUppercaseTitle = false
        btnGotIt.setTitleFont(UIFont(name: "Helvetica Neue", size: 18)!, for: .normal)
    }
    
    // MARK: - Actions

    @IBAction func didTapGotItBtn(_ sender: Any) {
        viewComingSoonContainer.isHidden = true
    }
    
    @IBAction func didTapHomeBtn(_ sender: Any) {
        viewComingSoonContainer.isHidden = false
    }
    
    @IBAction func didTapMeditateBtn(_ sender: Any) {
        viewComingSoonContainer.isHidden = false
    }
    
    @IBAction func didTapJournalBtn(_ sender: Any) {
        profileContainer.isHidden = true
        homeContainer.isHidden = false
    }
    
    @IBAction func didTapTheoryBtn(_ sender: Any) {
        viewComingSoonContainer.isHidden = false
    }
    
    @IBAction func didTapProfileBtn(_ sender: Any) {
//        profileContainer.isHidden = false
//        homeContainer.isHidden = true
        
        viewComingSoonContainer.isHidden = false
    }
    
    
}

