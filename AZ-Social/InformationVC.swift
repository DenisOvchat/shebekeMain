//
//  InformationVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 03.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class InformationVC:UITableViewController
{
    let menu = ["Дата рождения","Родной город","Школа","Инстут","Профессия","Телефон","Почта","Тип личности"]
    
    var profile:FullProfile!

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = menu[indexPath.row]
        switch indexPath.row {
        case 0:
            if let val = profile.BirhDayString
            {
                cell?.detailTextLabel?.text = val

            }
        case 1:
            if let val = profile.city
            {
                cell?.detailTextLabel?.text = val
                
            }
        case 2:
            if let val = profile.school
            {
                cell?.detailTextLabel?.text = val
                
            }
        case 3:
            if let val = profile.university
            {
                cell?.detailTextLabel?.text = val
                
            }
        case 4:
            if let val = profile.profession
            {
                cell?.detailTextLabel?.text = val
                
            }
        case 5:
            if let val = profile.phone
            {
                cell?.detailTextLabel?.text = val
                
            }
        case 6:
            if let val = profile.mail
            {
                cell?.detailTextLabel?.text = val
                
            }
        case 7:
            if profile.isJuristic
            {
                cell?.detailTextLabel?.text = "Юридическое"
            }
            else
            {
                cell?.detailTextLabel?.text = "Физическое"

            }
        default:
            break
        }
        return cell!
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

}
