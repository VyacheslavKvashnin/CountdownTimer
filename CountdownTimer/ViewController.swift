//
//  ViewController.swift
//  CountdownTimer
//
//  Created by Вячеслав Квашнин on 21.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var timeRemining: Int = 0
    var timer: Timer!
    
    var labelText = UILabel()
    var labelTimer = UILabel()
    
    var playButton = UIButton()
    var stopButton = UIButton()
    var resetButton = UIButton()
    
    var addTextFieldButton = UIButton()
    
    var myTextField = UITextField()
    var myTextFieldText = UITextField()
    
    var taskList = [Task]()
    var myTableView = UITableView()
    
    var task: Task? {
        didSet {
            labelText.text = task?.name
            labelTimer.text = "\(task?.timer ?? 0)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Controller"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTimer))
        createLabel()
        createLabelText()
        playTapped()
        createPlayButton()
        
        createTextField()
        createTextFieldText()
        addTFButton()
    }
    
    @objc func addTimer() {
        
    }
    
    // MARK: - createAddTextFieldButton
    func addTFButton() {
        addTextFieldButton.frame = CGRect(x: 20, y: 300, width: 150, height: 50)
        addTextFieldButton.backgroundColor = .purple
        addTextFieldButton.setTitle("Add", for: .normal)
        addTextFieldButton.layer.cornerRadius = 10
        addTextFieldButton.addTarget(self, action: #selector(addTF), for: .touchUpInside)
        view.addSubview(addTextFieldButton)
    }
    
    // MARK: - AddTextField
    @objc func addTF() {
        guard timeRemining == 0 else {return}
        timeRemining = Int(myTextField.text!)!
        labelText.text = myTextFieldText.text!
        createPlayButton()
        playTapped()
    }
    
    // MARK: - createPlayButton
    func createPlayButton() {
        playButton.frame = CGRect(x: 200, y: 300, width: 150, height: 50)
        playButton.backgroundColor = .purple
        playButton.setTitle("Play", for: .normal)
        playButton.layer.cornerRadius = 10
        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        view.addSubview(playButton)
    }
    
    @objc func playTapped() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(step),
                                     userInfo: nil, repeats: true)
    }
    
    @objc func step() {
        if timeRemining > 0 {
            timeRemining -= 1
        } else {
            timer.invalidate()
        }
        labelTimer.text = "\(timeRemining)"
    }
    
    // MARK: - createLabelTimer
    func createLabel() {
        labelTimer = UILabel(frame: CGRect(x: 140, y: 500, width: 300, height: 31))
        labelTimer.layer.borderWidth = 1
        view.addSubview(labelTimer)
    }
    
    // MARK: - createLabelText
    func createLabelText() {
        labelText.frame = CGRect(x: 20, y: 500, width: 100, height: 31)
        labelText.layer.borderWidth = 1
        labelText.text = myTextFieldText.text
        view.addSubview(labelText)
    }
    
    // MARK: - createTextField
    func createTextField() {
        myTextField.frame = CGRect(x: 20, y: 150, width: 300, height: 31)
        myTextField.borderStyle = UITextField.BorderStyle.roundedRect
        myTextField.placeholder = "Enter timer..."
        view.addSubview(myTextField)
    }
    // MARK: - createTextFieldText
    func createTextFieldText() {
        myTextFieldText.frame = CGRect(x: 20, y: 200, width: 300, height: 31)
        myTextFieldText.borderStyle = UITextField.BorderStyle.roundedRect
        myTextFieldText.placeholder = "Enter text..."
        view.addSubview(myTextFieldText)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        if let cell = cell as? ViewController {
            cell.task = taskList[indexPath.row]
        }
        return cell
    }
}
