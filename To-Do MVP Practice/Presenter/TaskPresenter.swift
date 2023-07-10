//
//  TaskPresenter.swift
//  To-Do MVP Practice
//
//  Created by David Santiago Londono Giraldo on 9/07/23.
//

import Foundation

protocol UI: AnyObject {
    func update()
}

final class TaskPresenter {
    weak var delegate: UI?
    
    var tasks: [Task] = []
    
    private var taskDatabase = TaskDataBase()
    
    func create(task: String) {
        guard !task.isEmpty else {
            return
        }
        let newTask: Task = .init(text: task, isFavorite: false)
        tasks = taskDatabase.create(task: newTask)
        delegate?.update()
    }
    
    func updateFavorite(taskId: UUID) {
        tasks = taskDatabase.updateFavorite(taskId: taskId)
        delegate?.update()
    }
    
    func removeTask(taskId: UUID) {
        tasks = taskDatabase.remove(taskId: taskId)
        delegate?.update()
    }
    
    @objc
    func removeAllTasks() {
        tasks = taskDatabase.removeAll()
        delegate?.update()
    }
}
