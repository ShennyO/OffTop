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
    
    private var currentWord = ""
    private var streak = 0
    var node: AVAudioInputNode!
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    var request: SFSpeechAudioBufferRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRhyme(word: "go")
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.2274509804, blue: 0.2431372549, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        addOutlets()
        setConstraints()
        recordAndRecognizeSpeech()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    //MARK: UIOUTLETS
    
    private var backButton: UIButton = {
        let button  = UIButton(type: .custom)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        return button
    }()
    
    private var streakLabel: UILabel = {
        let label = UILabel()
        label.text = "streak:"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private var streakValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
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
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: Private Functions
    
    //MARK: Add Outlets
    private func addOutlets() {
        wordLabel.text = currentWord
        self.view.addSubview(backButton)
        self.view.addSubview(streakLabel)
        self.view.addSubview(streakValueLabel)
        self.view.addSubview(wordLabel)
        self.view.addSubview(circleView)
        circleView.addSubview(secondsLabel)
        self.view.addSubview(cancelButton)
    }
    
    //MARK: Set Constraints
    private func setConstraints() {
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(35)
        }
        
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
    
    //MARK: get the next rhyming word
    private func getRhyme(word: String) {
        Network.instance.fetch(word: ["rel_rhy" : word]) { (data, response) in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
            
            
            
            let randomInt = Int.random(in: 0 ..< (json?.count)!)
            let word = json![randomInt]["word"] as! String
            let wordArray = word.components(separatedBy: " ")
            print(wordArray)
            self.currentWord = wordArray.last!
            
            DispatchQueue.main.async {
                self.wordLabel.text = wordArray.last
            }
        }
    }
    
    
    
    @objc private func popVC() {
        self.navigationController?.popViewController(animated: true)
        audioEngine.stop()
        recognitionTask?.cancel()
        request.endAudio()
    }
    
    
//    MARK: Skip Button
    @objc private func skip() {
        self.getRhyme(word: self.wordLabel.text ?? "Oops")
        self.endSpeechRecognition(completionHandler: {
            self.recordAndRecognizeSpeech()
        })
    }
    
    //MARK: End Recording
    private func endSpeechRecognition(completionHandler handler: @escaping () ->()) {
        audioEngine.stop()
        self.node.removeTap(onBus: 0)
        recognitionTask?.cancel()
        request.endAudio()
        handler()
        
    }
    
    //MARK: Start and Record Function
    private func recordAndRecognizeSpeech() {
        

        self.node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        request = SFSpeechAudioBufferRecognitionRequest()
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
                //from this point, we need to filter the string to see if it contains the current word
                //if it contains the current word, we fire a networking request to the words api to get a new word, set it as the new current, then we call endSpeechRecognition to reset
                
                let resultingString = result.bestTranscription.formattedString.lowercased()
                print(resultingString)
                if resultingString.contains(self.currentWord) {
                    
                    self.streak += 1
                    self.streakValueLabel.text = String(self.streak)
                    self.getRhyme(word: self.wordLabel.text ?? "Oops")
                    self.endSpeechRecognition(completionHandler: {
                        self.recordAndRecognizeSpeech()
                    })
                } else {
                    print("Nothing")
                }
                
                

            } else {
                print(error)
            }
        })
        
    }
    
}
