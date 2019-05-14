//
//  ListDicatationsController.swift
//  MakeSchoolNotes
//
//  Created by Spencer Laird on 5/3/19.
//  Copyright © 2019 MakeSchool. All rights reserved.
//

import UIKit

//LIST DICTATIONS TABLE VIEW FROM MENU PAGE

class ListDictationsController: UITableViewController {
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var dictations: [Dictations] = []
    
   
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
            dictations = try context.fetch(Dictations.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return dictations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCell(withIdentifier: "listDictationsCell", for: indexPath) as! ListDictationsTableViewCell
        
        let dictation = dictations[indexPath.row]
       
        if let myDictations = dictation.title {
            cell.dictationTitle?.text = myDictations
        }
        if let myDictationDate = dictation.date {
            cell.dictationTimeStamp?.text = myDictationDate.convertToString()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dictation = dictations[indexPath.row]
            context.delete(dictation)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                dictations = try context.fetch(Dictations.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayDictations":
            // 1
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            // 2
            let dictation = dictations[indexPath.row]
            // 3
            let destination = segue.destination as! DisplayDictationViewController
            // 4
            destination.dictation = dictation
            
            
        case "addDictation":
            print("create note bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    
    
    
    
}
