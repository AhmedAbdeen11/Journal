//
//  OnBoardingPage3Controller.swift
//  Journal
//
//  Created by Abdeen on 1/22/22.
//

import UIKit
import MaterialComponents

class OnBoardingPage3Controller: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var viewImageContainer: UIView!
    
    @IBOutlet weak var btnGetStarted: UIButton!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    private func initViews(){
        
        viewImageContainer.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        viewImageContainer.layer.borderWidth = 1
        viewImageContainer.layer.borderColor = UIColor.white.cgColor
        viewImageContainer.layer.cornerRadius = 81
        
        //Button Get Started
        btnGetStarted.style(color: UIColor.white.withAlphaComponent(0.2), title: "Get Started")
        btnGetStarted.addBorder(color: UIColor(rgb: 0xFFFFFF), width: 1)
        btnGetStarted.addShadow()
    }

    // MARK: - Actions
    
    @IBAction func didTapBtnGetStarted(_ sender: Any) {
        
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
