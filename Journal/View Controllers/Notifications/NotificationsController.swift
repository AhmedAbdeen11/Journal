//
//  NotificationsController.swift
//  Journal
//
//  Created by Abdeen on 1/25/22.
//

import UIKit

class NotificationsController: UIViewController {

    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var viewStacksContainer: UIView!
    
    @IBOutlet weak var dayTime: UILabel!
    
    @IBOutlet weak var nightTime: UILabel!
    
    let standard = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        setData()
    }
    
    private func initViews(){
        viewBack.layer.cornerRadius = 24
        viewBack.addShadow()
        
        viewStacksContainer.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 15)
        viewStacksContainer.addShadow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setData()
    }
    
    private func setData(){
        
        let dt = standard.string(forKey: "start_your_day_time")
        
        if dt != nil && !dt!.isEmpty {
        
            dayTime.text = dt
            
        }else{
            dayTime.text = "09:00am"
        }
        
        
        //=======================================================/
        
        
        let et = standard.string(forKey: "end_your_day_time")
        
        if et != nil && !et!.isEmpty {
        
            nightTime.text = et
            
        }else{
            nightTime.text = "10:00pm"
        }
         
    }
    
    @IBAction func didTapBtnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapbtnStartTheDay(_ sender: Any) {
    }
    
    @IBAction func didTapbtnEndTheDay(_ sender: Any) {
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
