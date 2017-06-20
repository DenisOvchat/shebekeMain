//
//  EditProfileVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 11.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class EditProfileVC:UITableViewController
{
    let placeholders = [[["Имя","Фамилия","Отчество"]],[["Страна","Город"],["Школа","Университет"]],[["Место работы","Профессия"],["Телефон","Почта"]]]
    let sectionHeaders = ["Дата рождения", "Добавить школу/университет"]
    let fields = [[["first_name","last_name","second_name"]],[["country","city"],["school","university"]],[["work_place","profession"],["phone","email"]]]
    var profile:FullProfile!
    
    var dictinaryCopy:NSDictionary?
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "EditProfileCell", bundle: Bundle.main), forCellReuseIdentifier: "EditProfileCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        dictinaryCopy = profile.dictionary.copy() as! NSDictionary
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileCell") as! EditProfileCell
        cell.setCell(fieldsNames: fields[indexPath.section][indexPath.row],dict:dictinaryCopy!)
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return placeholders.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholders[section].count
    }
    
}
