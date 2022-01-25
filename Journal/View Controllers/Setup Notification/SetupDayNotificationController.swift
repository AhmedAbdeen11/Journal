//
//  SetupNotificationController.swift
//  Journal
//
//  Created by Abdeen on 1/23/22.
//

import UIKit

class SetupDayNotificationController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var viewClose: UIView!
    
    @IBOutlet weak var viewClock: UIView!
    
    
    @IBOutlet weak var btnSetTime: UIButton!
    
    @IBOutlet weak var viewTimePickContainer: UIView!
    
    @IBOutlet weak var viewSetTime: UIView!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var labelTime: UILabel!
    
    // MARK: - Properties
    
    let standard = UserDefaults.standard
    
    @IBOutlet weak var dailyReminderSwich: UISwitch!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        setData()
    }
    
    private func initViews(){
        viewClose.layer.cornerRadius = 24
        
        viewClock.layer.borderWidth = 1
        viewClock.layer.borderColor = UIColor.white.cgColor
        viewClock.layer.cornerRadius = 25
        
        dailyReminderSwich.layer.borderWidth = 1
        dailyReminderSwich.layer.borderColor = UIColor.white.cgColor
        dailyReminderSwich.layer.cornerRadius = 15.5
        
        viewTimePickContainer.layer.cornerRadius = 20
        
        btnSetTime.layer.cornerRadius = 25
    }
    
    private func setData(){
        let time = standard.string(forKey: "start_your_day_time")
        
        if time != nil && !time!.isEmpty {
        
            labelTime.text = time
            
        }else{
            labelTime.text = "09:00am"
        }
        
        dailyReminderSwich.setOn(standard.bool(forKey: "start_your_day_switch"), animated: true)
        
        standard.setValue(true, forKey: "isNotificationOpened")
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
        
        standard.setValue(strTime, forKey: "start_your_day_time")
        
        
    }
    
    @IBAction func didSwitchChanged(_ sender: Any) {
        standard.setValue(dailyReminderSwich.isOn, forKey: "start_your_day_switch")
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
