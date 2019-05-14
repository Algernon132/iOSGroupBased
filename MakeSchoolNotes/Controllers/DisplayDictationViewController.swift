//
//  DisplayDictationViewController.swift
//  MakeSchoolNotes
//
//  Created by Spencer Laird on 5/2/19.
//  Copyright © 2019 MakeSchool. All rights reserved.
//

import UIKit
import Speech

//CREATE AND SAVE DICTATIONS TO THE TABLEVIEW PAGE

class DisplayDictationViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    @IBOutlet weak var startDictationButton: UIButton!
    @IBOutlet weak var stopDictationButton: UIButton!
    
    
    var dictation: Dictations?
    
    
    
    @IBOutlet weak var convertedTextField: UITextView!
    @IBOutlet weak var dictationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDictationButton.layer.cornerRadius = startDictationButton.frame.height / 2
        startDictationButton.layer.shadowColor = UIColor.gray.cgColor
        startDictationButton.layer.shadowRadius = 5
        startDictationButton.layer.shadowOpacity = 0.5
        startDictationButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        stopDictationButton.layer.cornerRadius = stopDictationButton.frame.height / 2
        stopDictationButton.layer.shadowColor = UIColor.gray.cgColor
        stopDictationButton.layer.shadowRadius = 5
        stopDictationButton.layer.shadowOpacity = 0.5
        stopDictationButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let dictation = dictation {
            dictationLabel.text = dictation.title
            convertedTextField.text = dictation.content
        } else {
            dictationLabel.text = "Click start to begin..."
            convertedTextField.text = ""
        }
       
    }
    
     func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {buffer, _ in self.request.append(buffer)}
        
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
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: {result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                self.dictationLabel.text = bestString
                
            } else if let error = error {
                print(error)
            }
        })
        
    }
    
    func transferText() {
        self.convertedTextField.text = dictationLabel.text
        
        if (dictationLabel.text == ""){
            convertedTextField.text = ""
        }
        
        
    }
    
    
    @IBAction func startButtonTapped(_ sender: Any) {
        self.recordAndRecognizeSpeech()
    }
    
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        self.transferText()
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
            let destination = segue.destination as? ListDictationsController
            else {return}
        
        
        switch identifier {
        case "save" where dictation != nil:
//            dictation?.title = dictationLabel.text ?? ""
//            dictation?.content = convertedTextField.text ?? ""
//
//            destination.tableView.reloadData()
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let dictation = Dictations(context: context) // Link Task & Context
            dictation.title = dictationLabel.text
            dictation.date = Date()
            dictation.content = convertedTextField.text
            // Save the data to coredata
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            let _ = navigationController?.popViewController(animated: true)
            
        case "save" where dictation == nil:
//            let dictation = Dictation()
//            dictation.title = dictationLabel.text ?? ""
//            dictation.content = convertedTextField.text ?? ""
//            dictation.modificationTime = Date()
//
//            destination.dictations.append(dictation)
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let dictation = Dictations(context: context) // Link Task & Context
            dictation.title = dictationLabel.text
            dictation.date = Date()
            dictation.content = convertedTextField.text
            // Save the data to coredata
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            let _ = navigationController?.popViewController(animated: true)
            
        case "cancel":
            print("cancel button tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
}
