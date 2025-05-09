//
//  Todos+CoreDataProperties.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//
//

import Foundation
import CoreData


@objc(Todos)
public class Todos: NSManagedObject {}

extension Todos {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todos> {
        return NSFetchRequest<Todos>(entityName: "Todos")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var completed: Bool
    @NSManaged public var userId: Int64
    @NSManaged public var createdAt: Date?
}

extension Todos : Identifiable {}
