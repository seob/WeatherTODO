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
        guard let todoURL = URL(string: todopoint) else { return print("Error: cannot create URL")}
        
//        let newdata = self.tasks.map {
//            [
//                "act" : "post",
//                "title": $0.title,
//                "content": $0.content,
//            ]
//        }
        
        let newdata: [String: Any] = [
                                        "act": "post",
                                        "title": TitleTextField.text ?? "",
                                        "conten": ContentTextView.text ?? ""
                                    ]
        

        
        guard let jsonTodo = try? JSONSerialization.data(withJSONObject: newdata) else { return }
        
        var todosUrlRequest = URLRequest(url: todoURL)
        let config = URLSessionConfiguration.default  
        let session = URLSession(configuration: config)
        
        todosUrlRequest.httpBody = jsonTodo
        let task = session.dataTask(with: todosUrlRequest) { (data, response, error) in
            guard error == nil else { return print(error!) }
            
            guard let response = response as? HTTPURLResponse, 200..<400 ~= response.statusCode else {
                print("StatusCode is not valid")
                return
            }
            
            guard let data = data else { return print("Error: did not receive data") }
            print(data)
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    else { return print("Could not get JSON from responseData as dictionary") }

                print(receivedTodo)
            }catch{
                print("error parsing response from POST on /todos")
                return
            }
            
            
        }
        task.resume()
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

