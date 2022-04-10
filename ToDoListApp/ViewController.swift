//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Timothey Urbanovich on 08/04/2022.
//

import UIKit

class ViewController: UIViewController {

    var textArray: [String] = []
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var addNoteButton: UIButton!
    
    
    @IBAction func onAddButtonClick(_ sender: UIButton) {
        textArray.append("testtext")
        print(textArray.count)
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func addTextToCell(text: String, cell: UITableViewCell) {
//        cell.textLabel?.text = text
////        tableView.reloadData()
    }
    
    
    
    

}



extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap has acqueried")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
//        addTextToCell(text: "test", cell: cell)
        cell.textLabel?.text = textArray[indexPath.row]
        return cell
    }
}
