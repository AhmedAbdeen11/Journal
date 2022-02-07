//
//  OnBoardingPage2Controller.swift
//  Journal
//
//  Created by Abdeen on 1/22/22.
//

import UIKit

class OnBoardingPage2Controller: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var viewDot1: UIView!
    
    @IBOutlet weak var viewDot2: UIView!
    
    @IBOutlet weak var viewDot3: UIView!
    
    @IBOutlet weak var viewImageContainer: UIView!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    private func initViews(){
        viewDot1.circularDots()
        viewDot2.circularDots()
        viewDot3.circularDots()
        
        viewImageContainer.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        viewImageContainer.layer.borderWidth = 1
        viewImageContainer.layer.borderColor = UIColor.white.cgColor
        viewImageContainer.layer.cornerRadius = 82.5
    }

    // MARK: - Actions
    
    @IBAction func didTapBtnSkip(_ sender: Any) {
        (parent as? OnBoardingPageController)?.changePage(index: 2)
    }
    
    @IBAction func didTapBtnNext(_ sender: Any) {
        (parent as? OnBoardingPageController)?.changePage(index: 2)
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
