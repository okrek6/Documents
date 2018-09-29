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
    
    let dateformatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateformatter.timeStyle = .long
        dateformatter.dateStyle = .long
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addNewDocument(_ sender: Any) {
        performSegue(withIdentifier: "showDocument", sender: self)
    }
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        
        return cell
    }
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDocument", sender: self)
    }
}
