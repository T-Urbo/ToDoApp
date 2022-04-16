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
        tableView.reloadData()
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
        
        self.fetchItems()
        
        
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
        
        
//        textArray.append("testtext")
        print(itemsArray?.count)
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    
    func getAllItems() {
        
    }
    
    func createItem(name: String) {
        let item = Item()
        item.name = name
        itemsArray?.append(item)
    }
    
    func deleteItem(item: Item) {
        if let index = itemsArray?.firstIndex(of: item)
        {
            itemsArray?.remove(at: index)
        }
    }
    
    func deleteAllItems() {
        itemsArray?.removeAll()
    }
    
    func updateItem(item: Item) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap has acqueried")
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
}
