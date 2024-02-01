//
//  Note+CoreDataProperties.swift
//  notes
//
//  Created by Владислав on 02.02.2024.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID
    @NSManaged public var text: String
    @NSManaged public var createdDate: Date
    @NSManaged public var lastEditedDate: Date

}

extension Note : Identifiable {

}
