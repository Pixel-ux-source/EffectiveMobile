//
//  TaskDataManager.swift
//  EffectiveMobile
//
//  Created by Алексей on 29.04.2025.
//

import UIKit
import CoreData

final class TaskDataManager {
    // MARK: – Singleton
    static let shared = TaskDataManager()
    
    // MARK: – AppDelegate
    private unowned let appDelegate: AppDelegate = {
        UIApplication.shared.delegate as! AppDelegate
    }()
    
    // MARK: – Context
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: – Create
    func createData(from dtoTodos: [Todo]) {
        dtoTodos.forEach { dtoTodo in
            let todos = Todos(context: context)
            todos.id = dtoTodo.id
            todos.todo = dtoTodo.todo
            todos.completed = dtoTodo.completed
            todos.userId = dtoTodo.userId
            todos.createdAt = Date.now
        }
        appDelegate.saveContext()
    }
    
    // MARK: – Read
    func fetchAll() -> [Todos] {
        let fetchRequest: NSFetchRequest<Todos> = Todos.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error fetch data: \(error.localizedDescription)")
        }
        return []
    }
}
