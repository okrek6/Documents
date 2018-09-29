//
//  Document+CoreDataClass.swift
//  Documents
//
//  Created by Brendan Krekeler on 9/29/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(title: String?, text: String, date: Date? ) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Document.entity(), insertInto: context)
        
        self.title = title
        self.text = text
        self.date = date
    }
}
