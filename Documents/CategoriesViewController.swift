//
//  CategoriesViewController.swift
//  Documents
//
//  Created by Brendan Krekeler on 9/23/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    
    var categories: [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try managedContext.fetch(fetchRequest)
            
            categoriesTableView.reloadData()
        } catch {
            print("Could not fetch")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let destination = segue.destination as? DocumentsViewController,
           let selectedRow = self.categoriesTableView.indexPathForSelectedRow?.row else {
                    return
            }
        destination.category = categories [selectedRow]
        }
    func deleteCategory(at indexPath: IndexPath){
        let category = categories[indexPath.row]
        
        guard let managedContext = category.managedObjectContext else {
            return
        }
        
        managedContext.delete(category)
        
        do {
            try managedContext.save()
            
            categories.remove(at: indexPath.row)
            
            categoriesTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Could not delete")
            
            categoriesTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteCategory(at: indexPath)
        }
    }
}

