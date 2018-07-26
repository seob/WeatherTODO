//
//  ViewController.swift
//  Weachertodo
//
//  Created by seob on 2018. 7. 20..
//  Copyright © 2018년 seob. All rights reserved.
//
//

import UIKit
import Alamofire
 


class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var arrRes = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = self
        todoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
//        var dict = arrRes[indexPath.row]
//        cell.textLabel?.text = dict["title"] as? String
//        cell.detailTextLabel?.text = dict["regdt"] as? String
        return cell

    }
}
