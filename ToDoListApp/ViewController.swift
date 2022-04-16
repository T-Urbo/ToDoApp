//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Timothey Urbanovich on 08/04/2022.
//

import UIKit

class ViewController: UIViewController {

    var textArray: [String] = []
    var itemsArray: [Item]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var addNoteButton: UIButton!
    
    
    @IBAction func onAddButtonClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add new item", message: "Enter the text", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let textfield = alert.textFields![0]
            let newItem = Item(context: self.context)
            newItem.name = textfield.text
            newItem.createdAt = Date()
            newItem.isFinished = false
//            self.itemsArray?.append(newItem)
        }
        
        do {
            try self.context.save()
        }
        catch {
            
        }
        
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
        
        self.fetchItems()
//        textArray.append("testtext")
        print(itemsArray?.count)
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchItems()
    }

    func fetchItems() {
        do {
            self.itemsArray = try context.fetch(Item.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.itemsArray![indexPath.row]
        
        let alert = UIAlertController(title: "Edit item", message: "Edit your note below", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = item.name
        
        let saveButton = UIAlertAction(title: "OK", style: .default) { (action) in
            item.name = textfield.text
            
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            self.fetchItems()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("cancel")
        }
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = self.itemsArray![indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let itemToRemove = self.itemsArray![indexPath.row]
            self.context.delete(itemToRemove)
            
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            self.fetchItems()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
