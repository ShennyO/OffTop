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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.007843137255, green: 0.03137254902, blue: 0.2862745098, alpha: 1)
        self.title = "Bars"
        addOutlets()
        setConstraints()
        // Do any additional setup after loading the view.
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
    }
    
    //MARK: UI Variables
    
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "musicIcon")
        return imageView
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
        label.text = "A word will be provided at the top."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return label
    }()
    
    private var instructionStepTwo: UILabel = {
        let label = UILabel()
        label.text = "Say a line using the word as the final punchline."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return label
    }()
    
    private var instructionStepThree: UILabel = {
        let label = UILabel()
        label.text = "A new rhyming word will be provided afterwards."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private var instructionStepFour: UILabel = {
        let label = UILabel()
        label.text = "How many lines can you come up with?"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.9473350254, green: 0.9473350254, blue: 0.9473350254, alpha: 1)
        return label
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
//        self.view.addSubview(logoImage)
        self.view.addSubview(containerView)
        
        [instructionLabel, instructionStepOne, instructionStepTwo, instructionStepThree, instructionStepFour].forEach { (view) in
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
            make.top.equalToSuperview().offset(180)
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
        
        startButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(110)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(55)
        }
        
    }
    
    @objc private func startButtonSegue() {
        
        let nextVC = SessionViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
    

}
