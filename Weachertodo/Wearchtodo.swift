//
//  Wearchtodo.swift
//  Weachertodo
//
//  Created by seob on 2018. 7. 20..
//  Copyright © 2018년 seob. All rights reserved.
//

import Foundation

struct Todo {
    var title: String
    var content: String?
    var regdt: String
    
    init(title: String, content: String? = nil, regdt: String) {
        self.title = title
        self.content = content
        self.regdt = regdt
    }
}
