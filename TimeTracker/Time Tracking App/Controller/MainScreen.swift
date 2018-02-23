//
//  ViewController.swift
//  Time Tracking App
//
//  Created by Lasha Gejadze on 21.02.18.
//  Copyright © 2018 APP3null. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var textLbl: UILabel!
    @IBOutlet fileprivate weak var descriptionLbl: UILabel!
    @IBOutlet fileprivate weak var timeLbl: UILabel!
}

class MainScreen: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Properties
    fileprivate var dataSource = [TaskObject]()
    weak var timerView: TimerScreen!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - IBActions
    @IBAction fileprivate  func addButton(_ sender: UIButton) {
        guard let view = Bundle.main.loadNibNamed("TimerScreen", owner: self, options: nil)?.first as? TimerScreen else { return }
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.0
        view.frame = CGRect(x: (self.view.frame.size.width - view.frame.size.width)/2,
                            y: 20,
                            width: view.frame.size.width, height: view.frame.size.height)
        
        self.timerView = view
        self.timerView.delegate = self
        self.view.addSubview(self.timerView)
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension MainScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "xxTableCellxx", for: indexPath) as! TimerTableViewCell
        let object = dataSource[indexPath.row]
        
        cell.textLbl.text = object.taskTitle
        cell.descriptionLbl.text = object.taskDescription
        cell.timeLbl.text = object.duration
        
        return cell
    }
}

// MARK: - TimerScreenDelegate
extension MainScreen: TimerScreenDelegate {
    
    func timerHasCreatedTaskObject(with data: TaskObject) {
        self.dataSource.append(data)
        self.dataSource = self.dataSource.reversed()
        self.tableView.reloadData()
    }
    
}


