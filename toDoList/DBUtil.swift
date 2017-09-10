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
    
    var toDoM = [toDoModel]()
    static var sharedInstance = DBUtil()
    var db: Connection?
    
    let toDoTable = Table("ToDo")
    
    let id = Expression<Int64>("Id")
    let name = Expression<String>("Name")
    let desc = Expression<String>("Desc")
    let dateC = Expression<String>("DateC")
    let dateU = Expression<String>("DateU")
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
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
            toDoM = [toDoModel]()
            for data in all {                
                let todo1 = toDoModel(id: Int(data.get(id)) ,name: data.get(name), desc: data.get(desc), dateCreated: data.get(dateC), dateUpdated: data.get(dateU))
                toDoM.append(todo1)
            }
        } catch _ {
            print ("Error get all")
        }
    }
    
    // count
    func getCount() -> Int {
        var count: Int = 0
        do {
            let all = Array(try db!.prepare(toDoTable))
            count = all.count
        } catch _ {
            print ("Error get all Count")
        }
        return count
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
    
    // delete data
    func delete(delId: Int64, index: Int) {
        do {
            let ar = toDoTable.filter(id == delId)
            if try db!.run(ar.delete()) > 0 {
                toDoM.remove(at: index)
                print ("delete successful")
            } else {
                print ("not deleted")
            }
        } catch _ {
            print ("can not delete")
        }
    }
    
    // update data
    func update(id1: Int, name: String, desc: String, dateC: String, dateU: String) {
        do {
            var id64 = Int64(id1)
            let ar = toDoTable.filter(id == id64)
            if try db!.run(ar.update(
                self.name<-name,
                self.desc<-desc,
                self.dateC<-dateC,
                self.dateU<-dateU
            )) > 0 {
                print ("update successful")
            } else {
                print ("not updated")
            }
        } catch _ {
            print ("can not update")
        }
    }
}
