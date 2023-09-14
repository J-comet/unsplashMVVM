//
//  SimpleTableViewController.swift
//  unsplashMVVM
//
//  Created by 장혜성 on 2023/09/14.
//

import UIKit

class NewSimpleTableViewController: UITableViewController {
    
    var userList = [
        User(name: "상어", age: 10),
        User(name: "고래", age: 20),
        User(name: "금붕어", age: 30),
        User(name: "장어", age: 40)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = userList[indexPath.row].name
        content.secondaryText = "\(userList[indexPath.row].age)"
        cell.contentConfiguration = content
        return cell
    }
}
