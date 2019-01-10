//
//  SessionViewController.swift
//  OffTop
//
//  Created by Sunny Ouyang on 1/9/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class SessionViewController: UIViewController {
    
    //MARK: VARIABLES
    private var currentWord = "Banjo"
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.2274509804, blue: 0.2431372549, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        addOutlets()
        setConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    //MARK: UIOUTLETS
    private var streakLabel: UILabel = {
        let label = UILabel()
        label.text = "streak:"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private var streakValueLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private var wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 75)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.2274509804, blue: 0.2431372549, alpha: 1)
        view.layer.cornerRadius = 100
        view.layer.borderWidth = 10
        view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    private var secondsLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 85)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private var cancelButton: UIButton = {
        let button  = UIButton(type: .custom)
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: Private Functions
    
    //MARK: Add Outlets
    private func addOutlets() {
        wordLabel.text = currentWord
        self.view.addSubview(streakLabel)
        self.view.addSubview(streakValueLabel)
        self.view.addSubview(wordLabel)
        self.view.addSubview(circleView)
        circleView.addSubview(secondsLabel)
        self.view.addSubview(cancelButton)
    }
    
    //MARK: Set Constraints
    private func setConstraints() {
        
        streakValueLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(35)
        }
        
        streakLabel.snp.makeConstraints { (make) in
            make.right.equalTo(streakValueLabel.snp.left).offset(-5)
            make.top.equalToSuperview().offset(35)
        }
        
        wordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(streakLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        circleView.snp.makeConstraints { (make) in
            make.top.equalTo(wordLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
        secondsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(circleView.snp.bottom).offset(75)
            make.height.width.equalTo(85)
        }
        
    }
    
    
    
    @objc private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Recording Function
    private func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        
        if !myRecognizer.isAvailable {
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result {
                let resultingString = result.bestTranscription.formattedString
                self.wordLabel.text = resultingString
            } else {
                print(error)
            }
        })
        
    }
    
}
