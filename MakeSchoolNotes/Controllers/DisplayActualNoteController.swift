//
//  DisplayActualNoteController.swift
//  MakeSchoolNotes
//
//  Created by Spencer Laird on 5/4/19.
//  Copyright © 2019 MakeSchool. All rights reserved.
//

import UIKit

//CREATE AND SAVE ACTUAL NOTE TO TABLEVIEW

class DisplayActualNoteController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var note: Notes?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note {
            // 2
            titleTextField.text = note.title
            contentTextView.text = note.content
        } else {
            // 3
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        guard let identifier = segue.identifier,
            let destination = segue.destination as? ListActualNotesController
            else { return }
        
        switch identifier {
        case "saveActualNote" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            
            destination.tableView.reloadData()
            
        case "saveActualNote" where note == nil:
//            let note = ActualNote()
//            note.title = titleTextField.text ?? ""
//            note.content = contentTextView.text ?? ""
//            note.modificationTime = Date()
//
//            destination.actualNotes.append(note)
            
            let work = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let note = Notes(context: work) // Link Task & Context
            note.title = titleTextField.text
            note.date = Date()
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            let _ = navigationController?.popViewController(animated: true)
            
        case "cancelActualNote":
            print("cancel bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
}
