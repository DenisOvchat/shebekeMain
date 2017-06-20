//
//  BirthdayInputVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 30.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class BirthdayInputVC:UIViewController
{
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    
    var rigistrationData:[String:Any]!
    override func viewDidLoad() {
        picker.datePickerMode = .date
        picker.tintColor = UIColor.white
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        maleButton.isHighlighted = true
        
        femaleButton.isHighlighted = true
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let dateString = formatter.string(from: picker.date)
        rigistrationData["birthday"] = dateString
        
        (segue.destination as! FromInputVC).rigistrationData = rigistrationData
        
    }
    
    @IBAction func changed(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        
        dateLabel.text = formatter.string(from: picker.date)
    }
    
    
    @IBAction func maleBut(_ sender: Any) {
        maleButton.isHighlighted = false
        
        femaleButton.isHighlighted = true
        rigistrationData["sex"] = true

    }
   
    @IBAction func femaleBut(_ sender: Any) {
        maleButton.isHighlighted = true
        femaleButton.isHighlighted = false
        rigistrationData["sex"] = false
    }
    
}
