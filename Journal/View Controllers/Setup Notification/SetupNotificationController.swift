//
//  SetupNotificationController.swift
//  Journal
//
//  Created by Abdeen on 1/23/22.
//

import UIKit

class SetupNotificationController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var viewClose: UIView!
    
    @IBOutlet weak var viewClock: UIView!
    
    @IBOutlet weak var viewSwitch: UISwitch!
    
    @IBOutlet weak var btnSetTime: UIButton!
    
    @IBOutlet weak var viewTimePickContainer: UIView!
    
    @IBOutlet weak var viewSetTime: UIView!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var labelTime: UILabel!
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    private func initViews(){
        viewClose.layer.cornerRadius = 24
        
        viewClock.layer.borderWidth = 1
        viewClock.layer.borderColor = UIColor.white.cgColor
        viewClock.layer.cornerRadius = 25
        
        viewSwitch.layer.borderWidth = 1
        viewSwitch.layer.borderColor = UIColor.white.cgColor
        viewSwitch.layer.cornerRadius = 15.5
        
        viewTimePickContainer.layer.cornerRadius = 20
        
        btnSetTime.layer.cornerRadius = 25
    }
    
    private func setData(){
        
    }
    
    // MARK: - Actions

    @IBAction func didTapBtnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapBtnClock(_ sender: Any) {
        viewSetTime.isHidden = false
    }
    
    @IBAction func didTapBtnSetTime(_ sender: Any) {
        viewSetTime.isHidden = true
        
        let date = self.timePicker.date
        let strTime = date.dateStringWith(strFormat: "hh:mm a")
        labelTime.text = strTime
        
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

extension Date {
     func dateStringWith(strFormat: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = Calendar.current.timeZone
            dateFormatter.locale = Calendar.current.locale
            dateFormatter.dateFormat = strFormat
            return dateFormatter.string(from: self)
        }
}
