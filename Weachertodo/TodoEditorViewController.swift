//
//  TodoEditorViewController.swift
//  Weachertodo
//
//  Created by seob on 2018. 7. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class TodoEditorViewController: UIViewController {
    
     
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var ContentTextView: UITextView!
    
    @IBAction func Savehandel(_ sender: Any) {
        checkFieldValue()
        makePostCall()
    }
    var tasks = [Todo]()
    
    func makePostCall() {
        let todopoint = "http://seob1.kakaoapps.co.kr/api/todo.php"
        guard let tuduURL = URL(string: todopoint) else { return print("Error: cannot create URL")}
        
        let data = self.tasks.map {
            [
                "title": $0.title,
                "content": $0.content,
            ]
        }
       // guard let jsonTodo = try? JSONSerialization.dat
//        let newTodo: [String: Any] = ["title": "My First todo", "completed": false, "userId": 1]
//        guard let jsonTodo = try? JSONSerialization.data(withJSONObject: newTodo) else { return }
//
//        var todosUrlRequest = URLRequest(url: todosURL)
//        todosUrlRequest.httpMethod = "POST"
//        todosUrlRequest.httpBody = jsonTodo
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: todosUrlRequest) { (data, response, error) in
//            guard error == nil else { return print(error!) }
//            guard let data = data else { return print("Error: did not receive data") }
//
//            do {
//                guard let receivedTodo = try JSONSerialization.jsonObject(with: data) as? [String: Any],
//                    let todoID = receivedTodo["id"] as? Int
//                    else { return print("Could not get JSON from responseData as dictionary") }
//
//                print(receivedTodo)
//                print("The ID is: \(todoID)")
//            } catch  {
//                print("error parsing response from POST on /todos")
//                return
//            }
//        }
//        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleTextField.delegate = self
        TitleTextField.text = ""
        TitleTextField.placeholder = "제목을 입력해주세요"
        self.TitleTextField.resignFirstResponder()

        print("test")
    }
    
    func checkFieldValue() -> Bool {
        var errors = false
        let title = "Error"
        var msg = ""
        if TitleTextField.text?.isEmpty == true{
            errors = true
            msg += "제목을 입력해주세요."
            self.alertWithTitle(title: title, message: msg, ViewController: self, toFocus: TitleTextField, showpage: 2)
        }
        return errors
    }
    //화면 터치시 키패드 숨기기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

// MARK: - TodoEditorViewController
extension TodoEditorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

