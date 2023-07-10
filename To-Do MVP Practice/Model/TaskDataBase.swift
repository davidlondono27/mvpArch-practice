//
//  TaskDataBase.swift
//  To-Do MVP Practice
//
//  Created by David Santiago Londono Giraldo on 9/07/23.
//

import Foundation

class TaskDataBase {
    var tasks: [Task]
    
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    func create(task: Task) -> [Task] {
        tasks.append(task)
        return tasks
    }
    
    func updateFavorite(taskId: UUID) -> [Task] {
        if let index = tasks.firstIndex(where: { $0.id == taskId}) {
            tasks[index].isFavorite = !tasks[index].isFavorite
        }
        return tasks
    }
    
    func remove(taskId: UUID) -> [Task] {
        if let index = tasks.firstIndex(where: { $0.id == taskId}) {
            tasks.remove(at: index)
        }
        return tasks
    }
    
    func removeAll() -> [Task] {
        tasks.removeAll()
        return tasks
    }
}
