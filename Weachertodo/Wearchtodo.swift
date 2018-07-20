//
//  Wearchtodo.swift
//  Weachertodo
//
//  Created by seob on 2018. 7. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import Foundation

struct Todo {
    let act: String
    let title: String
    var content: String?
    let regdt: String
    
    init(act: String, title: String, content: String? = nil, regdt: String) {
        self.act = act
        self.title = title
        self.content = content
        self.regdt = regdt
    }
}
