//
//  ProfileController.swift
//  Journal
//
//  Created by Abdeen on 1/24/22.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var viewBackground: UIView!
    
    @IBOutlet weak var viewUserImage: UIView!
    
    @IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var labelDayStreak: UILabel!
    
    @IBOutlet weak var labelTotalDays: UILabel!
    
    @IBOutlet weak var labelTotalEntries: UILabel!
    
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var imageBackground: UIImageView!
    
    @IBOutlet weak var viewFirstStackContainer: UIView!
    
    @IBOutlet weak var viewSecondStackContainer: UIView!
    
    @IBOutlet weak var viewThirdStackContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }

    private func initViews(){
        viewHeader.addShadow()
        
        viewBackground.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 15)
        viewBackground.addShadow()
        
        viewContainer.layer.cornerRadius = 15
        imageBackground.layer.cornerRadius = 15

        
        viewUserImage.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 61)
        
        viewFirstStackContainer.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 15)
        viewFirstStackContainer.addShadow()
        
        viewSecondStackContainer.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 15)
        viewSecondStackContainer.addShadow()
        
        viewThirdStackContainer.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 15)
        viewThirdStackContainer.addShadow()
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
