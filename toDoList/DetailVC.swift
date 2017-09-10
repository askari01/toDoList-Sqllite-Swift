//
//  DetailVC.swift
//  toDoList
//
//  Created by Syed Askari on 9/10/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var dateCLbl: UILabel!
    @IBOutlet weak var dateULbl: UILabel!
    
    var toDo: toDoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTxt.delegate = self
        descTxt.delegate = self
        
        if toDo == nil {
            
        }
        else {
            nameTxt.text = toDo?.name
            descTxt.text = toDo?.desc
            dateCLbl.text = "Created at: \(toDo?.dateCreated)"
            dateULbl.text = "Updated at: \(toDo?.dateUpdated)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        print ("hit save button")
        if toDo == nil {
            if nameTxt.text != "" && descTxt.text != "" {
                let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium , timeStyle: .short)
                
                DBUtil.sharedInstance.addToDo(name: "\(nameTxt.text!)", desc: "\(descTxt.text!)", dateC: "\(timestamp)", dateU: "NA")
                DBUtil.sharedInstance.getAll()
            }
        } else {
            if nameTxt.text != "" && descTxt.text != "" {
                let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium , timeStyle: .short)
                var dateCreation = toDo!.dateCreated
                
                DBUtil.sharedInstance.update(id1: toDo!.id, name: nameTxt.text!, desc: descTxt.text!, dateC: "\(dateCreation)", dateU: "\(timestamp)")
            }
        }
    }
    
    // Dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTxt.resignFirstResponder()
        descTxt.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
