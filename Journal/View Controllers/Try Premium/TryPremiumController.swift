//
//  TryPremiumController.swift
//  Journal
//
//  Created by Abdeen on 1/22/22.
//

import UIKit

class TryPremiumController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var viewPrice: UIView!
    
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var btnTryFreeAndSubscribe: UIButton!
    
    @IBOutlet weak var viewDot: UIView!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    private func initViews(){
        //View Dot
        viewDot.layer.cornerRadius = 2.5
        
        //Button Close
        btnClose.addBorder(color: UIColor(rgb: 0xFFFFFF), width: 1, cornerRadius: 21)
        
        //View Price
        viewPrice.addBorder(color: UIColor(rgb: 0xFFFFFF), width: 1, cornerRadius: 7)
        viewPrice.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        viewPrice.addShadow()
        
        //Button try free and subscribe
        btnTryFreeAndSubscribe.layer.cornerRadius = 32.5
        btnTryFreeAndSubscribe.addShadow()
    }
    
    // MARK: - Actions
    
    @IBAction func didTapBtnTryFreeAndSubscribe(_ sender: Any) {
        self.performSegue(withIdentifier: "showMainPageSegue", sender: nil)
    }
    
    @IBAction func didTapCloseBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "showMainPageSegue", sender: nil)
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
