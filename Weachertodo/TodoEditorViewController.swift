//
//  TodoEditorViewController.swift
//  Weachertodo
//
//  Created by seob on 2018. 7. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit
import Alamofire

class TodoEditorViewController: UIViewController {
    
    @IBOutlet weak var TitleTextField: UITextField!
    
    @IBOutlet weak var ContentTextView: UITextView!
    @IBAction func Savehandel(_ sender: Any) {
        checkFieldValue()
        makePostCall()
    }
    
    func makePostCall() {
        let todopoint = "http://seob1.kakaoapps.co.kr/api/todo.php"
        let title = (self.TitleTextField.text)!
        let memo = self.ContentTextView.text ?? ""
        
        let parameters: [String: Any] = [
                "act"   : "regist",
                "title": title,
                "content": memo,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            ]
        //$_SERVER["REQUEST_METHOD"]
        Alamofire
            .request(todopoint, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseJSON { [weak self] response in
                switch(response.result)
                {
                case .success(_):
                    if response.result.value != nil
                    {
                        let dict :NSDictionary = response.result.value! as! NSDictionary
                        
                        let status = dict.value(forKey: "status")as! Int
                        let responseMsg = dict.value(forKey: "msg")as! String
                        if(status == 1)
                        {
                           self?.alertWithTitle(title: responseMsg, message: "", ViewController: self!, toFocus: self!.TitleTextField, showpage: 2)
                        }
                        else
                        {
                            print("Something Missed")
                        }
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error!)
                    break
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleTextField.delegate = self
        self.TitleTextField.resignFirstResponder()
    }
   
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        ContentTextView.delegate = self
        ContentTextView.text = "내용을 입력해주세요"
        ContentTextView.textColor = UIColor.lightGray
 
    }
    
    //화면 터치시 키패드 숨기기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
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

extension TodoEditorViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if !ContentTextView.text!.isEmpty && ContentTextView.text! == "내용을 입력해주세요"
        {
            ContentTextView.text = ""
            ContentTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if ContentTextView.text.isEmpty
        {
            ContentTextView.text = "내용을 입력해주세요"
            ContentTextView.textColor = UIColor.lightGray
        }
    }
}

