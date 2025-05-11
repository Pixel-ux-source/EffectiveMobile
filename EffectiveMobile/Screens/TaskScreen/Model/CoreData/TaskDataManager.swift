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
    
    // MARK: – Container
    private var container: NSPersistentContainer {
        appDelegate.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        return appDelegate.persistentContainer
    }
    
    // MARK: – Create
    func createDataJson(from dtoTodos: [Todo], completion: @escaping () -> ()) {
        container.performBackgroundTask { context in
            do {
                dtoTodos.forEach { dtoTodo in
                    let todos = Todos(context: context)
                    todos.id = dtoTodo.id
                    todos.title = dtoTodo.todo
                    todos.desc = dtoTodo.todo
                    todos.completed = dtoTodo.completed
                    todos.userId = dtoTodo.userId
                    todos.createdAt = Date.now
                }
                try context.save()
                DispatchQueue.main.async {
                    completion()
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion()
                }
                print("Error create data: \(error.localizedDescription)")
            }
        }
    }
    
    func createNewData(title: String? = nil, desc: String? = nil, _ completion: @escaping () -> ()) {
        container.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Todos> = Todos.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
            fetchRequest.fetchLimit = 1
            
            do {
                guard let object = try context.fetch(fetchRequest).first else { return }
                let maxId: Int64 = object.id + 1
                
                let todos = Todos(context: context)
                todos.id = maxId
                todos.title = title
                todos.desc = desc
                todos.completed = false
                todos.userId = Int64.random(in: 1...1000)
                todos.createdAt = Date.now
                try context.save()
                DispatchQueue.main.async {
                    completion()
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion()
                }
                print("Error create new data: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: – Read
    func fetchAll(_ completion: @escaping ([Todos]) -> ()) {
        container.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Todos> = Todos.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            do {
                print("Fetch All from \(Thread.isMainThread ? "Main Thread" : "Background Thread")")
                let todos = try context.fetch(fetchRequest)
                let object = todos.map { $0.objectID }
                DispatchQueue.main.async {
                    let viewContext = self.appDelegate.persistentContainer.viewContext
                    let model = object.compactMap { viewContext.object(with: $0) as? Todos }
                    completion(model)
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion([])
                }
                print("Error fetch data: \(error.localizedDescription)")
            }
        }
    }
    
    func searchData(with query: String, completion: @escaping ([Todos]) -> ()) {
        container.performBackgroundTask { context in
            let fetchRequest:NSFetchRequest<Todos> = Todos.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            
            do {
                let todos = try context.fetch(fetchRequest)
                let object = todos.map { $0.objectID }
                DispatchQueue.main.async {
                    let viewContext = self.appDelegate.persistentContainer.viewContext
                    let model = object.compactMap { viewContext.object(with: $0) as? Todos }
                    completion(model)
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion([])
                }
                print("Error search data: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: – Update
    func update(with id: Int64, on changes: [EnumTodosUpdate], _ completion: @escaping () ->()) {
        container.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Todos> = Todos.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %id", id)
            fetchRequest.fetchLimit = 1
            
            do {
                guard let todo = try context.fetch(fetchRequest).first else { return }
                changes.forEach { $0.apply(todo) }
                try context.save()
                DispatchQueue.main.async {
                    completion()
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion()
                }
                print("Error update data: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: – Delete
    func delete(with id: Int64, completion: @escaping () -> ()) {
        container.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Todos> = Todos.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %id", id)
            
            do {
                guard let todo = try context.fetch(fetchRequest).first else { return }
                context.delete(todo)
                completion()
                try context.save()
            } catch let error as NSError {
                print("Error delete data: \(error.localizedDescription)")
            }
        }
    }
}
