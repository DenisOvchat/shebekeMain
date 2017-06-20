//
//  SettingsVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 16.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class SettingsVC:UITableViewController
{
    let titles = ["Мой профиль","Настройки","Информация",""]
    let menu = [["Редактировать профиль"],["Режим неведимки","Геолокации","Приватность","Черный список"],["О приложении"],["Выйти"]]
    var profile:FullProfile!

    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "SettingsCellWSwitch", bundle: Bundle.main), forCellReuseIdentifier: "cellWSwitch")

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellWSwitch") as! SettingsCellWSwitch
            cell.accessoryView?.isHidden = true
            cell.isOn = false
            cell.textLabel?.text = menu[indexPath.section][indexPath.row]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.accessoryView?.isHidden = true
        cell?.textLabel?.text = menu[indexPath.section][indexPath.row]
        if indexPath.section == 3
        {
            cell?.textLabel?.textColor = UIColor.red
            cell?.textLabel?.textAlignment = .center
        }
        return cell!
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
            vc.profile = profile
            show(vc, sender: self)
        case (3,0):
            logOut()
        default:
            break
        }
    }
    func logOut()
    {
        
        ServerManager.shared(named: "main")?.GETRequestByAdding(postfix: "/persons/sign_out", complititionHandler: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginController")
        DispatchQueue.main.async {
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = initialViewController
            
        }
        
        
    }
    
}
