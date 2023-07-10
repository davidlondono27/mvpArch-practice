//
//  ViewController.swift
//  To-Do MVP Practice
//
//  Created by David Santiago Londono Giraldo on 8/07/23.
//

import UIKit

class ListOfTaskView: UIViewController {
    var presenter = TaskPresenter()
    
    private let taskTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textView.backgroundColor = .systemGray6
        textView.textColor = .label
        textView.layer.cornerRadius = 12
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 1
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var createTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Crear", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapOnCreateTask), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var taskCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 340, height: 80)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: "TaskCollectionViewCell")
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Borrar Todo",
                                                                 style: .done,
                                                                 target: presenter,
                                                                 action: #selector(presenter.removeAllTasks))
        
        [taskTextView, createTaskButton, taskCollectionView]
            .forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            taskTextView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            taskTextView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            taskTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            taskTextView.heightAnchor.constraint(equalToConstant: 60),
            
            createTaskButton.topAnchor.constraint(equalTo: taskTextView.bottomAnchor, constant: 6),
            createTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createTaskButton.heightAnchor.constraint(equalToConstant: 40),
            createTaskButton.widthAnchor.constraint(equalToConstant: 80),
            
            taskCollectionView.topAnchor.constraint(equalTo: createTaskButton.bottomAnchor, constant: 12),
            taskCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        taskCollectionView.dataSource = self
        presenter.delegate = self
    }
    
    @objc
    func didTapOnCreateTask() {
        print("Create task")
        presenter.create(task: taskTextView.text)
    }
}


extension ListOfTaskView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCollectionViewCell", for: indexPath) as! TaskCollectionViewCell
        let task = presenter.tasks[indexPath.row]
        cell.configure(id: task.id, text: task.text, isFavorite: task.isFavorite)
        cell.tapOnFavorite = { [weak self] taskId in
            self?.presenter.updateFavorite(taskId: taskId)
        }
        cell.tapOnRemove = { [weak self] taskId in
            self?.presenter.removeTask(taskId: taskId)
        }
        return cell
    }
}

extension ListOfTaskView: UI {
    func update() {
        taskTextView.text = ""
        taskCollectionView.reloadData()
    }
}
