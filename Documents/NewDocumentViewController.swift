//
//  NewDocumentViewController.swift
//  Documents
//
//  Created by Brendan Krekeler on 9/23/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.
//

import UIKit

class NewDocumentViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        let title = titleTextField.text
        let descriptionText = descriptionTextField.text ?? ""
        let date = datePicker.date
        
        if let document = Document(title: title, text: descriptionText, date: date) {
            category?.addToRawDocuments(document)
            
            do {
                try document.managedObjectContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Document could not be created")
            }
        }
    }

}

extension NewDocumentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
