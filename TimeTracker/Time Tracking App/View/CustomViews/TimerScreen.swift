//
//  TimerScreen.swift
//  Time Tracking App
//
//  Created by Lasha Gejadze on 22.02.18.
//  Copyright © 2018 APP3null. All rights reserved.
//

import UIKit

protocol TimerScreenDelegate: class {
    func timerHasCreatedTaskObject (with data: TaskObject)
}

class TimerScreen: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet fileprivate weak var stageOne: UIView!
    @IBOutlet fileprivate weak var lblStopWatch: UILabel!
    @IBOutlet fileprivate weak var btnStartTimer: UIButton!
    @IBOutlet fileprivate weak var textViewDescription: UITextView!
    @IBOutlet fileprivate weak var txtField: UITextField!
    
    // MARK: - Properties
    private var currentTime: Double = 0
    private var timer: Timer!
    
    // MARK: - Delegation
    weak var delegate: TimerScreenDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtField.delegate = self
        textViewDescription.delegate = self
    }
    
    // MARK: - Timer Control
    private func setTimerWithItsCustomProperties () {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] (timer) in
            guard let strong = self else { return }
            
            strong.currentTime += 0.1
            strong.lblStopWatch.text = String(format: "00:%.1f", strong.currentTime)
        }
    }
    
    private func startDefaultStopWatchTimerWithSelected () {
        guard let button = self.btnStartTimer else { return }
        
        if button.tag == 0 { // while btn title is Start Timer
            
            button.tag = 1
            button.setTitle("Finish Task", for: .normal)
            button.backgroundColor = UIColor.green
            button.setTitleColor(.white, for: .normal)
            
            stageOne.alpha = 0.0
            setTimerWithItsCustomProperties()
        } else if button.tag == 1 {
            button.tag = 0
            button.setTitle("Start Timer", for: .normal)
            createDataObject()
            timer.invalidate()
        }
    }
    
    private func createDataObject () {
        var task: TaskObject!
        if let title = txtField.text, let desc = textViewDescription.text {
            task = TaskObject(title: title, description: desc, duration: lblStopWatch.text!)
        } else {
            task = TaskObject(duration: lblStopWatch.text!)
        }
        
        delegate?.timerHasCreatedTaskObject(with: task)
        self.removeFromSuperview()
    }
    
    // MARK: - IBActions
    @IBAction fileprivate func startTimerTapped(_ sender: UIButton) {
        startDefaultStopWatchTimerWithSelected()
    }
}

// MARK: - UITextFieldDelegate, UITextViewDelegate
extension TimerScreen: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Close Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
