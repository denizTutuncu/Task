//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Deniz Tutuncu on 1/30/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var taskDueTextField: UITextField!
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        taskDueTextField.inputView = dueDatePicker
        
        guard let task = task else { return }
        if task.isComplete {
            
        }
        
    }
    
    var dueDateValue: Date?
    
    private func updateViews() {
        guard let task = task,
            let due = task.due else { return }
        taskTextField.text = task.name
        taskTextView.text = task.notes
        taskDueTextField.text = due.stringValue()
    }
    
    
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        taskTextField.resignFirstResponder()
        taskDueTextField.resignFirstResponder()
        taskTextView.resignFirstResponder()
    }
    
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = sender.date
        guard let due = dueDateValue else { return }
        taskDueTextField.text = due.stringValue()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let name = taskTextView.text, !name.isEmpty else { return }
        guard let due = taskDueTextField.text, !due.isEmpty else { return }
        guard let taskView = taskTextView.text, !taskView.isEmpty else { return }
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: taskView, due: Date())
        } else {
            TaskController.shared.add(taskWithName: name, notes: taskView, due: Date())
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
