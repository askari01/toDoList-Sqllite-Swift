//
//  ViewController.swift
//  toDoList
//
//  Created by Syed Askari on 9/8/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var cell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        DBUtil.sharedInstance.getAll()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DBUtil.sharedInstance.getAll()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addItem(_ sender: Any) {
        print ("add item")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DBUtil.sharedInstance.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        self.cell.textLabel?.text = "\(DBUtil.sharedInstance.toDoM[indexPath.row].name)"
        self.cell.tag = DBUtil.sharedInstance.toDoM[indexPath.row].id
        return cell
    }
    
    // for selecting
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("selected: \(indexPath.row)")
        performSegue(withIdentifier: "editToDo", sender: self)
    }
    
    // for deleting
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            DBUtil.sharedInstance.delete(delId: Int64(self.cell.tag), index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("seague hit")
        if segue.identifier == "editToDo" {
            let vc = segue.destination as! DetailVC
            // var indexPath = tableView.indexPathForCell(sender as UITableViewCell)
            let indexPath = tableView.indexPathForSelectedRow
            if let index = indexPath {
                vc.toDo = DBUtil.sharedInstance.toDoM[index.row]
            }
        }
    }
    
}

