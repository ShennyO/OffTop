//
//  initialViewController.swift
//  OffTop
//
//  Created by Sunny Ouyang on 1/9/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit
import SnapKit

class initialViewController: UIViewController {
    
    //MARK: VARIABLES
    
    private var visibleStartButtonAlpha: CGFloat = 0.3
    private var infoActive: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordTextField.delegate = self
        startButton.isEnabled = false
        startButton.alpha = visibleStartButtonAlpha
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        hideKeyboardWhenTappedAround()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = #colorLiteral(red: 0.007843137255, green: 0.03137254902, blue: 0.2862745098, alpha: 1)
        self.title = "Bars"
        addOutlets()
        setConstraints()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.01568627451, green: 0.03921568627, blue: 0.2745098039, alpha: 1)

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]


        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        containerView.isHidden = true
        
    }
    
    
    
    
    
    //MARK: UI Variables
    
    let infoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "info"), for: .normal)
        button.addTarget(self, action:#selector(infoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.03921568627, blue: 0.2745098039, alpha: 1)
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 5
        containerView.layer.borderColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return containerView
    }()
    
    
    private var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Instructions:"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return label
    }()
    
    private var instructionStepOne: UILabel = {
        let label = UILabel()
        label.text = "Pick your own word."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return label
    }()
    
    private var instructionStepTwo: UILabel = {
        let label = UILabel()
        label.text = "Say a line using the word."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return label
    }()
    
    private var instructionStepThree: UILabel = {
        let label = UILabel()
        label.text = "Voice recognition checks for word usage."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private var instructionStepFour: UILabel = {
        let label = UILabel()
        label.text = "If used, a new rhyming word will be provided."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private var instructionStepFive: UILabel = {
        let label = UILabel()
        label.text = "How many lines can you come up with?"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return label
    }()
    
    private var reminderLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap below to enter a word"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return label
    }()
    
    private var wordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.white
        textField.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        textField.textAlignment = .center
        textField.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.03921568627, blue: 0.2745098039, alpha: 1)
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    
    private var textFieldUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private var startButton: UIButton = {
        var button = UIButton(type: .system)
        button.layer.cornerRadius = 25
        button.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2862745098, blue: 0.6, alpha: 1)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        button.addTarget(self, action:#selector(startButtonSegue), for: .touchUpInside)
        return button
    }()
    
    //MARK: Private functions
    
    //MARK: Adding outlets
    private func addOutlets() {

        
        self.view.addSubview(infoButton)
        self.view.addSubview(reminderLabel)
        self.view.addSubview(wordTextField)
        self.view.addSubview(textFieldUnderline)
        self.view.addSubview(containerView)
        
        [instructionLabel, instructionStepOne, instructionStepTwo, instructionStepThree, instructionStepFour, instructionStepFive].forEach { (view) in
            self.containerView.addSubview(view)
        }
        self.view.addSubview(startButton)
        
    }

    
    
    //MARK: Constraints
    private func setConstraints() {
        
        
        containerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(300)
            make.top.equalToSuperview().offset(230)
        }

        instructionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(22)
        }

        instructionStepOne.snp.makeConstraints { (make) in
            make.top.equalTo(instructionLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
        }

        instructionStepTwo.snp.makeConstraints { (make) in
            make.top.equalTo(instructionStepOne.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
        }
        
        instructionStepThree.snp.makeConstraints { (make) in
            make.top.equalTo(instructionStepTwo.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
        }

        instructionStepFour.snp.makeConstraints { (make) in
            make.top.equalTo(instructionStepThree.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
        }

        instructionStepFive.snp.makeConstraints { (make) in
            make.top.equalTo(instructionStepFour.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
        }
        
        infoButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(120)
            make.right.equalToSuperview().offset(-22)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        reminderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(250)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
        
        wordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(reminderLabel.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
        
        textFieldUnderline.snp.makeConstraints { (make) in
            make.top.equalTo(wordTextField.snp.bottom).offset(-8)
            make.right.equalToSuperview().offset(-65)
            make.left.equalToSuperview().offset(65)
            make.height.equalTo(4)
        }
        
        startButton.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldUnderline.snp.bottom).offset(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(55)
        }
        
    }
    
    
    //MARK: OBJC FUNCTIONS
    
    @objc private func infoButtonTapped() {
        //if it's true, (if the container view is already showing)
        
        if infoActive {
            infoActive = false
            
            self.startButton.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.containerView.alpha = 0
                self.startButton.alpha = self.visibleStartButtonAlpha
            }, completion:  {
                (value: Bool) in
                self.containerView.isHidden = true
            })
            
        } else { // if it's false, i.e. if it wasn't showing
            infoActive = true
            self.containerView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.containerView.alpha = 1
                self.startButton.alpha = 0
            }, completion:  { (value: Bool) in
                self.startButton.isHidden = true
            })
            
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.startButton.isHidden = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.startButton.isHidden = false
    }
    
    @objc private func startButtonSegue() {
        
        let nextVC = SessionViewController()
        guard let word = wordTextField.text else {return}
        nextVC.currentWord = word.lowercased()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        // Check for valid entries in both textfields in order to enable 'continue' button
        let isWordValid = wordTextField.text != nil && !wordTextField.text!.isEmptyOrWhitespace
        
        guard isWordValid else {
            startButton.isEnabled = false
            visibleStartButtonAlpha = 0.3
            startButton.alpha = visibleStartButtonAlpha
            return
        }
        
        startButton.isEnabled = true
        visibleStartButtonAlpha = 1.0
        startButton.alpha = visibleStartButtonAlpha
        
    }
    
}

extension initialViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
