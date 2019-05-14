//
//  ListActualNotesController.swift
//  MakeSchoolNotes
//
//  Created by Spencer Laird on 5/3/19.
//  Copyright © 2019 MakeSchool. All rights reserved.
//

import UIKit
import CoreData

//LISTS THE NOTES IN THE TABLEVIEW FROM MAIN MENU PAGE

class ListActualNotesController: UITableViewController {
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var actualNotes: [Notes] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
        
    }
    
    func getData() {
        do {
            actualNotes = try context.fetch(Notes.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return actualNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCell(withIdentifier: "listActualNotesTableViewCell", for: indexPath) as! ListActualNotesTableViewCell
        
        let note = actualNotes[indexPath.row]
       
        if let title = note.title {
            cell.NoteTitleLabel?.text = title
        }
        if let date = note.date {
            cell.noteModificationTimeLabel?.text = date.convertToString()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = actualNotes[indexPath.row]
            context.delete(noteToDelete)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                actualNotes = try context.fetch(Notes.fetchRequest()) as! [Notes]
            } catch {
                print("Fetching Failed")
            }
            
        }
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayActualNote":
            // 1
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            // 2
            let note = actualNotes[indexPath.row]
            // 3
            let destination = segue.destination as! DisplayActualNoteController
            // 4
            destination.note = note
            
        case "addActualNote":
            print("create note bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    
    @IBAction func unwindWithTheActualNoteSegue(_ segue: UIStoryboardSegue) {
        
    }
}
