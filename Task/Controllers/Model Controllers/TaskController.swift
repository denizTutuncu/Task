//
//  TaskController.swift
//  Task
//
//  Created by Deniz Tutuncu on 1/30/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    //Singleton
    static let shared = TaskController()
    //Source of truth
   // var tasks: [Task] = []
    
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        let isComplete = NSSortDescriptor(key: "isComplete", ascending: false)
        let due = NSSortDescriptor(key: "due", ascending: false)
        fetchRequest.sortDescriptors = [isComplete, due]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
    }()
    
    init() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error loading FetchResultsController \(error) : \(error.localizedDescription)")
        }
    }
    //MOCK DATA
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        guard let notes = notes,
            let due = due else { return }
        Task(name: name, notes: notes, due: due)
      //  tasks = fetchTask()
        saveToPersistenceStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        guard let notes = notes,
            let due = due else { return }
        Task(name: name, notes: notes, due: due)
        saveToPersistenceStore()
    }
    
    func remove(task: Task) {
        if let moc = task.managedObjectContext {
            moc.delete(task)
            saveToPersistenceStore()
        }
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistenceStore()
    }
    //MARK: - Persistence
    
    func saveToPersistenceStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was a problem saving to Persistence Store: \(error) : \(error.localizedDescription)")
        }
    }
}
