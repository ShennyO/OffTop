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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "OffTop"
        addOutlets()
        setConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: UI Variables
    
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "musicIcon")
        return imageView
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowColor = #colorLiteral(red: 0.231372549, green: 0.2509803922, blue: 0.2784313725, alpha: 1)
        containerView.layer.shadowRadius = 2.0
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.masksToBounds = false
        return containerView
    }()
    
    
    private var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Instructions:"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        label.textColor = #colorLiteral(red: 0.231372549, green: 0.2509803922, blue: 0.2784313725, alpha: 1)
        return label
    }()
    
    private var instructionStepOne: UILabel = {
        let label = UILabel()
        label.text = "A word will be provided at the top."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = #colorLiteral(red: 0.231372549, green: 0.2509803922, blue: 0.2784313725, alpha: 1)
        return label
    }()
    
    private var instructionStepTwo: UILabel = {
        let label = UILabel()
        label.text = "Say a line using the word as a punchline before time runs out."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.231372549, green: 0.2509803922, blue: 0.2784313725, alpha: 1)
        return label
    }()
    
    private var instructionStepThree: UILabel = {
        let label = UILabel()
        label.text = "A new rhyming word will be provided afterwards."
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = #colorLiteral(red: 0.231372549, green: 0.2509803922, blue: 0.2784313725, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    private var instructionStepFour: UILabel = {
        let label = UILabel()
        label.text = "How many lines can you come up with?"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.textColor = #colorLiteral(red: 0.231372549, green: 0.2509803922, blue: 0.2784313725, alpha: 1)
        return label
    }()
    
    private var startButton: UIButton = {
        var button = UIButton(type: .system)
        button.layer.cornerRadius = 25
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.2274509804, blue: 0.2431372549, alpha: 1)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        button.addTarget(self, action:#selector(startButtonSegue), for: .touchUpInside)
        return button
    }()
    
    //MARK: Private functions
    
    //MARK: Adding outlets
    private func addOutlets() {
        self.view.addSubview(logoImage)
        self.view.addSubview(containerView)
        
        [instructionLabel, instructionStepOne, instructionStepTwo, instructionStepThree, instructionStepFour].forEach { (view) in
            self.containerView.addSubview(view)
        }
        
        self.view.addSubview(startButton)
        
    }

    
    
    //MARK: Constraints
    private func setConstraints() {
        
        logoImage.snp.makeConstraints { (make) in
            make.height.equalTo(75)
            make.width.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(300)
            make.top.equalTo(logoImage.snp.bottom).offset(30)
        }
        
        instructionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
        }
        
        instructionStepOne.snp.makeConstraints { (make) in
            make.top.equalTo(instructionLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        instructionStepTwo.snp.makeConstraints { (make) in
            make.top.equalTo(instructionStepOne.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        instructionStepThree.snp.makeConstraints { (make) in
            make.top.equalTo(instructionStepTwo.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        instructionStepFour.snp.makeConstraints { (make) in
            make.top.equalTo(instructionStepThree.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        startButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(65)
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
