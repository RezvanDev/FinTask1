//
//  NewOperationViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 27.06.2024.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var noteTFBottomConstraint: NSLayoutConstraint!
    private var bottomViewHeightConstraint: NSLayoutConstraint!
    
    private var expenseCategories: [CategoryExpense] = []
    
    private lazy var titleMain: UILabel = {
        let lbl = UILabel()
        lbl.text = "Расход"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var mainCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 10
        let itemsPerRow: CGFloat = 4
        let itemWidth = (view.bounds.width - (padding * (itemsPerRow + 1))) / itemsPerRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ExpenseCategoryCollectionViewCell.self, forCellWithReuseIdentifier: ExpenseCategoryCollectionViewCell.reuseId)
        return collection
    }()
    private lazy var noteTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "test"
        return tf
    }()
    private lazy var stackV: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var lblForStack: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Дата"
        return lbl
    }()
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.date = Date()
        dp.datePickerMode = .date
        dp.maximumDate = Date()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.preferredDatePickerStyle = .automatic
        dp.addTarget(self, action: #selector(datePickerChange(_:)), for: .valueChanged)
        return dp
    }()
    private lazy var bottomShieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.mainGreen
        view.layer.cornerRadius = 30
        return view
    }()
    private lazy var mockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    private lazy var stackVBottomShieldView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var titleBottomShieldView: UILabel = {
        let lbl = UILabel()
        lbl.text = "Сумма"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.textColor = .darkGray
        return lbl
    }()
    private lazy var tfBottomShieldView: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Впишите сумму"
        return tf
    }()
    private lazy var buttonBottomShieldView: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.backgroundColor = AppColors.lightGreen
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupKeyboardNotifications()
        setupTapGesture()
        fetchExpenseCategories()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
}

// MARK: -- SetupLayer
private extension AddExpenseViewController {
    //setup
    func setup() {
        view.backgroundColor = .white
        configureScrollView()
        configureContentView()
        prepareScrollView()
        setupTitle()
        setupCollectionView()
        setupTF()
        setupStack()
        setupBottomView()
        setupMockView()
        setupStackVBottomShieldView()
    }
    // configureScrollView
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .clear
    }
    // configureContentView
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
    }
    // prepareScrollView
    func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    // setup Title constraints
    func setupTitle() {
        contentView.addSubview(titleMain)
        
        NSLayoutConstraint.activate([
            titleMain.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleMain.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    // setup CollectionView constraints
    func setupCollectionView() {
        contentView.addSubview(mainCollection)
        let collectionHeight = ceil(Double(expenseCategories.count)/4) * 100   // Calculate collection view height based on its content
        
        NSLayoutConstraint.activate([
            mainCollection.topAnchor.constraint(equalTo: titleMain.bottomAnchor, constant: 20),
            mainCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainCollection.heightAnchor.constraint(equalToConstant: collectionHeight),
        ])
    }
    // setup TextField constraints
    func setupTF() {
        contentView.addSubview(noteTF)
        noteTFBottomConstraint = noteTF.topAnchor.constraint(equalTo: mainCollection.bottomAnchor)
        
        NSLayoutConstraint.activate([
            noteTFBottomConstraint,
            noteTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            noteTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            noteTF.heightAnchor.constraint(equalToConstant: 40), // Пример высоты текстового поля
            
        ])
    }
    // Setup stack constraints
    func setupStack() {
        contentView.addSubview(stackV)
        stackV.addArrangedSubview(lblForStack)
        stackV.addArrangedSubview(datePicker)
        
        NSLayoutConstraint.activate([
            stackV.topAnchor.constraint(equalTo: noteTF.bottomAnchor, constant: 20),
            stackV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackV.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    // Setup bottom view constraints
    func setupBottomView() {
        view.addSubview(bottomShieldView)
        
        bottomViewHeightConstraint = bottomShieldView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.18)
        bottomViewHeightConstraint.isActive = true
        NSLayoutConstraint.activate([
            bottomShieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomShieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomShieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // Setup mock view constraints
    func setupMockView() {
        contentView.addSubview(mockView)
        
        NSLayoutConstraint.activate([
            mockView.topAnchor.constraint(equalTo: stackV.bottomAnchor, constant: 20),
            mockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mockView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.180),
            contentView.bottomAnchor.constraint(equalTo: mockView.bottomAnchor)
        ])
    }
    
    // Setup stack bottom shield view
    func setupStackVBottomShieldView() {
        bottomShieldView.addSubview(stackVBottomShieldView)
        stackVBottomShieldView.addArrangedSubview(titleBottomShieldView)
        stackVBottomShieldView.addArrangedSubview(tfBottomShieldView)
        bottomShieldView.addSubview(buttonBottomShieldView)
        
        NSLayoutConstraint.activate([
            stackVBottomShieldView.topAnchor.constraint(equalTo: bottomShieldView.topAnchor, constant: 30),
            stackVBottomShieldView.leadingAnchor.constraint(equalTo: bottomShieldView.leadingAnchor, constant: 40),
            stackVBottomShieldView.widthAnchor.constraint(equalToConstant: 250),
            
            buttonBottomShieldView.centerYAnchor.constraint(equalTo: stackVBottomShieldView.centerYAnchor),
            buttonBottomShieldView.trailingAnchor.constraint(equalTo: bottomShieldView.trailingAnchor, constant: -20),
            
            tfBottomShieldView.topAnchor.constraint(equalTo: titleBottomShieldView.bottomAnchor, constant: 10),
            tfBottomShieldView.leadingAnchor.constraint(equalTo: stackVBottomShieldView.leadingAnchor),
            tfBottomShieldView.trailingAnchor.constraint(equalTo: stackVBottomShieldView.trailingAnchor),
            tfBottomShieldView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

// MARK: -- Fetch data
private extension AddExpenseViewController {
    func fetchExpenseCategories() {
        expenseCategories = StorageManager.shared.getAllExpenseCategories()
        mainCollection.reloadData()
    }
}

// MARK: -- Keyboard Handling
private extension AddExpenseViewController {
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // gesture
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: -- OBJC
extension AddExpenseViewController {
    @objc func datePickerChange(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // Calculate the bottom view's new height
        let newBottomViewHeight = keyboardSize.height + 150// Adjust as needed
        
        // Check which text field is active
        if tfBottomShieldView.isFirstResponder {
            print("tfBottomShieldView is first responder")
            bottomViewHeightConstraint.constant = newBottomViewHeight
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else if noteTF.isFirstResponder {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
            let textFieldFrame = noteTF.convert(noteTF.bounds, to: scrollView)
            
            if !scrollView.bounds.contains(textFieldFrame) {
                scrollView.scrollRectToVisible(textFieldFrame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        UIView.animate(withDuration: 0.3) {
            self.bottomViewHeightConstraint.constant = self.view.frame.height * 0.18 // Restore to original height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: -- UICollectionViewDelegate, UICollectionViewDataSource
extension AddExpenseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expenseCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCategoryCollectionViewCell.reuseId, for: indexPath) as! ExpenseCategoryCollectionViewCell
        let category = expenseCategories[indexPath.item]
        cell.configure(with: category)
        return cell
    }
}
