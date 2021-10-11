//
//  ViewController.swift
//  HitListWithCoreData
//
//  Created by Андрей Маслов on 11.10.2021.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDataSource {
    
    var people = [NSManagedObject]()
    
    func saveName (name: String) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        person.setValue(name, forKey: "name")
        
        people.append(person)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addAuction(_ sender: Any) {
        
        
        
        let alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as! UITextField
            self.saveName(name: textField.text ?? "")
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (action) -> Void in
        }
        alert.addTextField {(textField: UITextField!) -> Void in
            textField.placeholder = "Type..."
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List of names"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        let person = people[indexPath.row]
        cell.textLabel!.text = person.value(forKey: "name") as? String
        return cell
    }
}

