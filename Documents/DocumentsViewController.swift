//
//  DocumentsViewController.swift
//  Documents
//
//  Created by Brendan Krekeler on 9/23/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController {

    @IBOutlet weak var documentsTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.documentsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addNewDocument(_ sender: Any) {
        performSegue(withIdentifier: "showDocument", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewDocumentViewController else {
            return
        }
       
       destination.category = category
    }
    
    func deleteDocument(at indexPath: IndexPath){
        guard let document = category?.documnets?[indexPath.row], let manageContext = document.managedObjectContext else {
            return
        }
        
        manageContext.delete(document)
        
        do {
            try manageContext.save()
            
            documentsTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Could not delete expense")
            
            documentsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.documnets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        if let document = category?.documnets?[indexPath.row] {
            cell.textLabel?.text = document.title
            
            if let date = document.date {
                cell.detailTextLabel?.text = dateFormatter.string(from: date)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDocument(at: indexPath)
        }
    }
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDocument", sender: self)
    }
}
