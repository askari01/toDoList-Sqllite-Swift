//
//  File.swift
//  toDoList
//
//  Created by Syed Askari on 9/10/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import Foundation

class toDoModel : NSObject {
    
    private var _name: String!
    private var _desc: String!
    private var _dateCreated: String!
    private var _dateUpdated: String!
    
    var name: String {
        return _name
    }
    
    var desc: String {
        return _desc
    }
    
    var dateCreated: String {
        return _dateCreated
    }
    
    var dateUpdated: String {
        return _dateUpdated
    }
    
    init(name: String, desc: String, dateCreated: String, dateUpdated: String) {
        _name = name
        _desc = desc
        _dateCreated = dateCreated
        _dateUpdated = dateUpdated
    }
}
