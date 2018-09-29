//
//  Document+CoreDataProperties.swift
//  Documents
//
//  Created by Brendan Krekeler on 9/29/18.
//  Copyright © 2018 Brendan Krekeler. All rights reserved.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var rawDate: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var category: Category?

}
