//
//  AddSavingViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 03.07.2024.
//

import UIKit

class AddSavingViewController: UIViewController {
    
    private var startDate: Date?
    private var endDate: Date?
    var closure: ((Bool) -> ())?
    
    private lazy var titleMain: UILabel = {
        let lbl = UILabel()
        lbl.text = String(localized: "AddSaving_AddSaving")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var stackV: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 20
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var stackName: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var nameTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = String(localized: "AddSaving_Title")
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = String(localized: "AddSaving_Enter_Name")
        tf.inputAccessoryView = createToolbar()
        tf.layer.cornerRadius = 20
        tf.delegate = self
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    private lazy var stackSumm: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var summTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = String(localized: "The_Amount")
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var summTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = String(localized: "Alert_Input_Sum")
        tf.inputAccessoryView = createToolbar()
        tf.delegate = self
        tf.layer.cornerRadius = 20
        tf.keyboardType = .numberPad
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    private lazy var stackDateStart: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var dateStartTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = String(localized: "AddSaving_Date_Start")
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var startDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized: "AddSaving_Select_Stard_Date"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.addTarget(self, action: #selector(dateStartTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var stackDateEnd: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var dateEndTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = String(localized: "AddSaving_End_Date")
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var endDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized: "AddSaving_Select_End_Date"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.addTarget(self, action: #selector(dateEndTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized: "Add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: -- Setup layer
private extension AddSavingViewController {
    func setup() {
        view.backgroundColor = .white
        setupTitleMain()
        setupStack()
    }
    
    // Setup title main
    func setupTitleMain() {
        view.addSubview(titleMain)
        
        NSLayoutConstraint.activate([
            titleMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleMain.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // Setup stack
    func setupStack() {
        view.addSubview(stackV)
        stackV.addArrangedSubview(stackName)
        stackName.addArrangedSubview(nameTitle)
        stackName.addArrangedSubview(nameTF)
        
        stackV.addArrangedSubview(stackSumm)
        stackSumm.addArrangedSubview(summTitle)
        stackSumm.addArrangedSubview(summTF)
        
        stackV.addArrangedSubview(stackDateStart)
        stackDateStart.addArrangedSubview(dateStartTitle)
        stackDateStart.addArrangedSubview(startDateButton)
        
        stackV.addArrangedSubview(stackDateEnd)
        stackDateEnd.addArrangedSubview(dateEndTitle)
        stackDateEnd.addArrangedSubview(endDateButton)
        
        stackV.addArrangedSubview(addButton)
        
        
        NSLayoutConstraint.activate([
            stackV.topAnchor.constraint(equalTo: titleMain.bottomAnchor, constant: 20),
            stackV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameTF.heightAnchor.constraint(equalToConstant: 40),
            nameTF.leadingAnchor.constraint(equalTo: stackV.leadingAnchor),
            nameTF.trailingAnchor.constraint(equalTo: stackV.trailingAnchor),
            
            nameTitle.leadingAnchor.constraint(equalTo: stackV.leadingAnchor, constant: 10),
            
            summTF.heightAnchor.constraint(equalToConstant: 40),
            summTF.leadingAnchor.constraint(equalTo: stackV.leadingAnchor),
            summTF.trailingAnchor.constraint(equalTo: stackV.trailingAnchor),
            
            summTitle.leadingAnchor.constraint(equalTo: stackV.leadingAnchor, constant: 10),
            
            startDateButton.heightAnchor.constraint(equalToConstant: 40),
            startDateButton.leadingAnchor.constraint(equalTo: stackV.leadingAnchor),
            startDateButton.trailingAnchor.constraint(equalTo: stackV.trailingAnchor),
            
            dateStartTitle.leadingAnchor.constraint(equalTo: stackV.leadingAnchor, constant: 10),
            
            endDateButton.heightAnchor.constraint(equalToConstant: 40),
            endDateButton.leadingAnchor.constraint(equalTo: stackV.leadingAnchor),
            endDateButton.trailingAnchor.constraint(equalTo: stackV.trailingAnchor),
            
            dateEndTitle.leadingAnchor.constraint(equalTo: stackV.leadingAnchor, constant: 10),
            
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.leadingAnchor.constraint(equalTo: stackV.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: stackV.trailingAnchor),
            
        ])
    }
    
    func setSavings() {
        if nameTF.text == nil || nameTF.text == "" {
            Alerts.shared.alertSetSavingError(title: String(localized: "Error"), decription: String(localized: "AddSaving_Fill_Name_Field"), presenter: self)
        } else if summTF.text == nil || summTF.text == "" {
            Alerts.shared.alertSetSavingError(title: String(localized: "Error"), decription: String(localized: "AddSaving_Fill_Amount_Field"), presenter: self)
        } else if startDate == nil {
            Alerts.shared.alertSetSavingError(title: String(localized: "Error"), decription: String(localized: "AddSaving_Fill_Start_Date"), presenter: self)
        } else if endDate == nil {
            Alerts.shared.alertSetSavingError(title: String(localized: "Error"), decription: String(localized: "AddSaving_Fill_End_Date"), presenter: self)
        } else {
            StorageManager.shared.createSaving(name: nameTF.text!, haveAmount: 0, needAmount: Double(summTF.text!) ?? 0, dateStart: startDate!, dateEnd: endDate!)
            closure?(true)
            dismiss(animated: true)
        }
    }
}

// MARK: -- Objc
private extension AddSavingViewController {
    @objc func dateStartTap() {
        showDatePicker(title: String(localized: "AddSaving_Select_Stard_Date"), isStart: true)
    }
    
    @objc func dateEndTap() {
        showDatePicker(title: String(localized: "AddSaving_Select_End_Date"), isStart: false)
    }
    
    @objc func addButtonTap() {
        setSavings()
    }
    
    func showDatePicker(title: String, isStart: Bool) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        if isStart {
            datePicker.maximumDate = Date()
        }
        datePicker.frame = CGRect(x: 0, y: 0, width: alert.view.bounds.width - 20, height: 200)
        
        alert.view.addSubview(datePicker)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        let selectAction = UIAlertAction(title: String(localized: "Choose"), style: .default) { [weak self] _ in
            if isStart {
                self?.startDate = datePicker.date
                self?.startDateButton.setTitle(Helpers.shared.formatDate(datePicker.date), for: .normal)
            } else {
                self?.endDateButton.setTitle(Helpers.shared.formatDate(datePicker.date), for: .normal)
                self?.endDate = datePicker.date
            }
        }
        
        let cancelAction = UIAlertAction(title: String(localized: "Error"), style: .cancel, handler: nil)
        
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func formatDate(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .none
           return formatter.string(from: date)
    }
}

// MARK: -- UITextFieldDelegate
extension AddSavingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [flexSpace, doneButton]
        toolbar.sizeToFit()
        return toolbar
    }
    
    @objc private func doneButtonTapped() {
        nameTF.resignFirstResponder()
        summTF.resignFirstResponder()
    }
}

