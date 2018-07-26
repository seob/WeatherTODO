//
//  MainViewController.swift
//  Weachertodo
//
//  Created by seob on 2018. 7. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
//    let currentTimeLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.text = "2018-01-01"
//        label.textAlignment = .center
//        label.font  = UIFont.systemFont(ofSize: 13)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    var arrRes = [Todo]() 
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        todoLoadData()
        weatherData()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(switchToEditing))
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    @objc func switchToEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    func weatherData(){
        let url=URL(string:"http://api.openweathermap.org/data/2.5/weather?id=1835848&appid=25a6b4ba58cc3c5ec8d76ed9bccd6fc0")
        
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
            
 
            if let arrJSON = allContacts["main"] as? [String : Any] {
                
                // [K - 273 = °C ]
                if let temperature = arrJSON["temp"] as? Double {
                    let temp = (temperature - 273)
                    currentTemp.text = "\(temp.rounded()) °C"
                }
                
                if let tempMin = arrJSON["temp_min"] as? Double {
                    let tempmin = (tempMin - 273)
                    tempMinLabel.text = "\(tempmin.rounded())"
                }
                
                if let tempMax = arrJSON["temp_max"] as? Double {
                    let tempmax = (tempMax - 273)
                    tempMinLabel.text = "\(tempmax.rounded())"
                }
                
                
             }
            
            if let arrJSON = allContacts["dt"] as? [String : Any] {
            
//                getDateFromTimeStamp(currentDate)

            }
            
        }
        catch {
            
        }
    }
    
    /*
     날짜 형 변환
     getDateFromTimeStamp(timeStamp: ) -> string {
     return date
     }
     **/
    func getDateFromTimeStamp(timeStamp : Double) -> String {
        
        let date = NSDate(timeIntervalSince1970: timeStamp)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CellId")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none

    }
    
    
    func todoLoadData(){
        let url=URL(string:"http://seob1.kakaoapps.co.kr/api/todolist.php")
 
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
           
            if let arrJSON = allContacts["list"] as? [[String : Any]] {
                 for aObject in arrJSON {
                    let todo = Todo()
                    todo.idx = aObject["idx"] as? Int
                    todo.title = aObject["title"] as? String
                    todo.content = aObject["content"] as? String
                    todo.regdt = aObject["regdt"] as? String
                    arrRes.append(todo)
                }
            }
            
        }
        catch {
            
        }
        
    }
    
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    /***************************************************
     iOS 8
     leadingSwipeActionsConfigurationForRowAt 또는
     trailingSwipeActionsConfigurationForRowAt 메서드가 정의되어 있을 경우 무시
     정의되어 있지 않을 경우 호출됨
     ***************************************************/
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        print("\n---------- [ editActionsForRowAt ] ----------\n")
        let addAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            print("Add")
        }
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print("Delete")
        }
        return [addAction, deleteAction]
    }
    
    
    /***************************************************
     iOS 11부터 가능
     ***************************************************/
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        print("\n---------- [ trailingSwipeActionsConfigurationForRowAt ] ----------\n")
//        let addAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
//
//        }
//        addAction.backgroundColor = .red
//        let configuration = UISwipeActionsConfiguration(actions: [addAction])
//        configuration.performsFirstActionWithFullSwipe = true  // default
//        return configuration
//    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("\n---------- [ leadingSwipeActionsConfigurationForRowAt ] ----------\n")
        let deleteAction = UIContextualAction(style: .destructive, title: "Del") { (action, view, success) in
            print(self.arrRes[indexPath.row].idx)
            print("delete")
            success(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! CustomTableViewCell
        
        cell.titleLabel.text = arrRes[indexPath.row].title
        cell.dateLabel.text = arrRes[indexPath.row].regdt
        return cell
        
    }
}
 

