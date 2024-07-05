//
//  AddCategoryViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 05.07.2024.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    private var selectedColor: String?
    private var selectedIcon: String?
    private var tapGesture: UITapGestureRecognizer?
    var isIncome: Bool = true
    var closure: ((Bool) -> ())?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton(frame: CGRect(x: view.bounds.width - 100, y: 0, width: 100, height: 45))
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(AppColors.mainGreen, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Название категории"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.inputAccessoryView = createToolbar()
        tf.borderStyle = .roundedRect
        tf.backgroundColor = AppColors.lightGrayMain
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        leftView.backgroundColor = .clear
        tf.leftViewMode = .always
        tf.leftView = leftView
        return tf
    }()
    private lazy var iconButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.layer.cornerRadius = 30
        button.setImage(UIImage(systemName: "photo.fill"), for: .normal)
        button.addTarget(self, action: #selector(iconButtonTap), for: .touchUpInside)
        button.backgroundColor = .green
        return button
    }()
    private lazy var iconTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Выбрать иконку"
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = .black
        return lbl
    }()
    private lazy var stackIcon: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var colorButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.layer.cornerRadius = 30
        button.setImage(UIImage(systemName: "square.2.layers.3d.top.filled"), for: .normal)
        button.addTarget(self, action: #selector(colorButtonTap), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    private lazy var colorTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Выбрать цвет"
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = .black
        return lbl
    }()
    private lazy var stackColor: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
      
    }
}

// MARK: -- Setup layer
private extension AddCategoryViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        setupTF()
        setupStack()
    }
    
    func setupTF() {
        view.addSubview(nameTF)
        
        NSLayoutConstraint.activate([
            nameTF.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 40),
            nameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nameTF.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupStack() {
        view.addSubview(stackIcon)
        stackIcon.addArrangedSubview(iconButton)
        stackIcon.addArrangedSubview(iconTitle)
        view.addSubview(stackColor)
        stackColor.addArrangedSubview(colorButton)
        stackColor.addArrangedSubview(colorTitle)
        
        NSLayoutConstraint.activate([
            stackIcon.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 40),
            stackIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70),
            stackIcon.heightAnchor.constraint(equalToConstant: 100),
            stackIcon.widthAnchor.constraint(equalToConstant: 100),
            iconButton.heightAnchor.constraint(equalToConstant: 60),
            iconButton.widthAnchor.constraint(equalToConstant: 60),
            
            stackColor.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 40),
            stackColor.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70),
            stackColor.heightAnchor.constraint(equalToConstant: 100),
            stackColor.widthAnchor.constraint(equalToConstant: 100),
            colorButton.heightAnchor.constraint(equalToConstant: 60),
            colorButton.widthAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    // gesture
    func setupTapGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture!)
        tapGesture?.isEnabled = false
    }
}

// MARK: -- ColorSelectionDelegate
extension AddCategoryViewController: ColorSelectionDelegate, IconSelectionDelegate {
    
    func didIcon(_ icon: String) {
        self.selectedIcon = icon
        iconButton.setImage(nil, for: .normal)
        iconButton.setBackgroundImage(UIImage(named: icon), for: .normal)
        iconButton.backgroundColor = .none
    }
    
    func didSelectColor(_ color: String) {
        self.selectedColor = color
        colorButton.backgroundColor = UIColor(hexString: color)
    }
}

// MARK: -- Objc
private extension AddCategoryViewController {
    @objc func cancelButtonTap() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonTap() {
        if selectedIcon == nil {
            Alerts.shared.alertSetColorError(title: "Ошибка", decription: "Выберите иконку", presenter: self)
        } else if selectedColor == nil {
            Alerts.shared.alertSetColorError(title: "Ошибка", decription: "Выберите цвет", presenter: self)
        } else if nameTF.text?.trimmingCharacters(in: .whitespaces) == "" || ((nameTF.text?.isEmpty) == nil){
            Alerts.shared.alertSetColorError(title: "Ошибка", decription: "Напишите название", presenter: self)
        } else {
            if isIncome {
                StorageManager.shared.createCategoryIncome(name: nameTF.text!, image: selectedIcon!, color: selectedColor!)
                closure?(true)
                dismiss(animated: true)
            } else {
                StorageManager.shared.createCategoryExpense(name: nameTF.text!, image: selectedIcon!, color: selectedColor!)
                closure?(true)
                dismiss(animated: true)
            }
        }
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func colorButtonTap() {
        let vc =  ColorSelectionViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func iconButtonTap() {
        let vc = IconSelectionViewController()
        vc.delegate = self
        vc.isIncome = isIncome
        present(vc, animated: true)
    }
}

// MARK: -- UITextFieldDelegate
extension AddCategoryViewController: UITextFieldDelegate {
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
    }
}
