//
//  DisplayDictationViewController.swift
//  MakeSchoolNotes
//
//  Created by Spencer Laird on 4/19/19.
//  Copyright © 2019 MakeSchool. All rights reserved.
//

import UIKit

//DISPLAYS THE MENU PAGE WHERE YOU GIVE PROJECTS TITLES AND ACCESS OTHER PARTS OF APPLICATION

class DisplayNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var NotesLabel: UIButton!
    
    @IBOutlet weak var dictationsLabel: UIButton!
    @IBOutlet weak var PhotosLabel: UIButton!
    
    var note: Note?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotesLabel.layer.cornerRadius = NotesLabel.frame.height / 2
        NotesLabel.layer.shadowColor = UIColor.gray.cgColor
        NotesLabel.layer.shadowRadius = 5
        NotesLabel.layer.shadowOpacity = 0.5
        NotesLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        
       //photos
        PhotosLabel.layer.cornerRadius = PhotosLabel.frame.height / 2
        PhotosLabel.layer.shadowColor = UIColor.gray.cgColor
        PhotosLabel.layer.shadowRadius = 5
        PhotosLabel.layer.shadowOpacity = 0.5
        PhotosLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        //Dictations
        dictationsLabel.layer.cornerRadius = dictationsLabel.frame.height / 2
        dictationsLabel.layer.shadowColor = UIColor.gray.cgColor
        dictationsLabel.layer.shadowRadius = 5
        dictationsLabel.layer.shadowOpacity = 0.5
        dictationsLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleTextField.text = ""
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard let identifier = segue.identifier,
            let destination = segue.destination as? ListNotesTableViewController
            else { return }
        
        switch identifier {
        case "save":
//            let note = Note()
//            note.title = titleTextField.text ?? ""
//            note.modificationTime = Date()
//
//            destination.notes.append(note)
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let project = Project(context: context) // Link Task & Context
            project.name = titleTextField.text!
            project.date = Date()

            (UIApplication.shared.delegate as! AppDelegate).saveContext()

            let _ = navigationController?.popViewController(animated: true)
        
            
            // 1
           // CoreDataHelper.saveNote()
            
        case "cancel":
            print("cancel bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
        
    }
    
   
    
    
    @IBAction func unwindWithTheSegue(_ segue: UIStoryboardSegue) {
        
    }
    
}
