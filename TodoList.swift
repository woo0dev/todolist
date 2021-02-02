//
//  TodoList.swift
//  hello
//
//  Created by Woo0 on 2021/02/02.
//

import Foundation

struct TodoList {
    var title: String = ""
    var content: String?
    var isComplete: Bool = false
 
    init(title: String, content: String?, isComplete: Bool = false) {
        self.title = title
        self.content = content
        self.isComplete = isComplete
    }
}

