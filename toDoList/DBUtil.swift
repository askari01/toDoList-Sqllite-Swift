//
//  DBUtil.swift
//  toDoList
//
//  Created by Syed Askari on 9/10/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import Foundation
import SQLite

class DBUtil {
    
    var toDo: toDoModel!
    static var sharedInstance = DBUtil()
    var db: Connection?
    
    let toDoTable = Table("ToDo")
    
    let id = Expression<Int64>("Id")
    let name = Expression<String>("Name")
    let desc = Expression<String>("Desc")
    let dateC = Expression<String>("DateC")
    let dateU = Expression<String>("DateU")
    
    init() {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print (path)
        
        do {
            db = try Connection("\(path)/ToDoDB.sqlite3")
            try db?.run(toDoTable.create( temporary: false, ifNotExists: true, block: {
                t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(desc)
                t.column(dateC)
                t.column(dateU)
            }))
        } catch _ {
            print ("error connecting with database")
        
        }
    }
    
    // getting all data
    func getAll() {
        do {
            let all = Array(try db!.prepare(toDoTable))
            for data in all {
                print (data)
            }
        } catch _ {
            print ("Error get all")
        }
    }
    
    // inserting data
    func addToDo(name: String, desc: String, dateC: String, dateU: String) {
        do {
            try db!.run(
                toDoTable.insert(
                    self.name<-name,
                    self.desc<-desc,
                    self.dateC<-dateC,
                    self.dateU<-dateU
                )
            )
            print ("Insert Successful")
        } catch _ {
            print ("Insert Error")
        }
    }
    
    // update data
    
}
