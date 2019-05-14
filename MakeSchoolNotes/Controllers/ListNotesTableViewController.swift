//
//  DisplayDictationViewController.swift
//  MakeSchoolNotes
//
//  Created by Spencer Laird on 4/19/19.
//  Copyright © 2019 MakeSchool. All rights reserved.
//

import UIKit
import CoreData

//DISPLAYS THE TABLE VIEW CONTENT FOR PROJECTS ON THE INITIAL PAGE OF THE APP CURRENTLY

class ListNotesTableViewController: UITableViewController {
    
    
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    var notes: [Project] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        getData()
        tableView.reloadData()
        
        
    }
    
    func getData() {
        do {
            notes = try context.fetch(Project.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // notes = CoreDataHelper.retrieveNotes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        
        // 2
        let note = notes[indexPath.row]
        
        if let myProject = note.name {
            cell.noteTitleLabel?.text = myProject
        }
        if let myProjectDate = note.date {
            cell.noteModificationLabel?.text = myProjectDate.convertToString()
        }

       
        return cell

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes[indexPath.row]
            context.delete(noteToDelete)
            
             (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                notes = try context.fetch(Project.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
            
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayNote":
            print("note cell tapped")
            
        case "addNote":
            print("create note bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        //notes = CoreDataHelper.retrieveNotes()
    }
    
}
