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
    func createDataJson(from dtoTodos: [Todo]) {
        dtoTodos.forEach { dtoTodo in
            let todos = Todos(context: context)
            todos.id = dtoTodo.id
            todos.title = dtoTodo.todo
            todos.desc = dtoTodo.todo
            todos.completed = dtoTodo.completed
            todos.userId = dtoTodo.userId
            todos.createdAt = Date.now
        }
        appDelegate.saveContext()
    }
    
    func createNewData(title: String? = nil, desc: String? = nil) {
        let fetchRequest: NSFetchRequest<Todos> = Todos.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            guard let object = try context.fetch(fetchRequest).first else { return }
            let maxId: Int64 = object.id + 1
            
            let todos = Todos(context: context)
            todos.id = maxId
            todos.desc = title
            todos.title = desc
            todos.completed = false
            todos.userId = Int64.random(in: 1...1000)
            todos.createdAt = Date.now
            
        } catch let error as NSError {
            print("Error create new data: \(error.localizedDescription)")
        }
        appDelegate.saveContext()
    }
    
    // MARK: – Read
    func fetchAll() -> [Todos] {
        let fetchRequest: NSFetchRequest<Todos> = Todos.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error fetch data: \(error.localizedDescription)")
        }
        return []
    }
    
    func searchData(with query: String, completion: @escaping ([Todos]) -> ()) {
        let fetchRequest:NSFetchRequest<Todos> = Todos.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        do {
            let result = try context.fetch(fetchRequest)
            let object = result.map { context.object(with: $0.objectID) } as! [Todos]
            completion(object)
        } catch let error as NSError {
            completion([])
            print("Error search data: \(error.localizedDescription)")
        }
    }
    
    // MARK: – Update
    func update(with id: Int64, on changes: [EnumTodosUpdate]) {
        let fetchRequest: NSFetchRequest<Todos> = Todos.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %id", id)
        fetchRequest.fetchLimit = 1
        
        do {
            guard let todo = try context.fetch(fetchRequest).first else { return }
            changes.forEach { $0.apply(todo) }
        } catch let error as NSError {
            print("Error update data: \(error.localizedDescription)")
        }
        appDelegate.saveContext()
    }
    
    // MARK: – Delete
    func delete(with id: Int64) {
        let fetchRequest: NSFetchRequest<Todos> = Todos.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %id", id)
        
        do {
            guard let todo = try context.fetch(fetchRequest).first else { return }
            context.delete(todo)
        } catch let error as NSError {
            print("Error delete data: \(error.localizedDescription)")
        }
        appDelegate.saveContext()
    }
}
