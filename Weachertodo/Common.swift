//
//  Common.swift
//  Weachertodo
//
//  Created by seob on 2018. 7. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import Foundation
import UIKit

extension TodoEditorViewController {
    /**************************************************************
     comment
     UiAlertController 함수 정의
     alertWithTitle(title: String!, message: String, ViewController: UIViewController, toFocus:UITextField, showpage: Int)
     showpage 가 1 일경우 경고창 , 2 일경우 다음페이지로 이동
     **************************************************************/
    func alertWithTitle(title: String!, message: String, ViewController: UIViewController, toFocus:UITextField, showpage: Int) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel,handler: {_ in
            switch showpage { 
    //        case 2:
    //            let registVC = RegistViewController()
    //            self.present(registVC, animated: true) {
    //                registVC.resultLabel.text = "\(User.userId) 님 환영합니다."
    //            }
            default:
                toFocus.becomeFirstResponder()
            }
        });
        
        alert.addAction(action)
        ViewController.present(alert, animated: true, completion:nil)
    }
    
    
}
