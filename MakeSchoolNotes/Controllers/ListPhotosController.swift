//
//  ListPhotosController.swift
//  MakeSchoolNotes
//
//  Created by Spencer Laird on 5/3/19.
//  Copyright © 2019 MakeSchool. All rights reserved.
//

import UIKit



class ListPhotosController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1
        guard let identifier = segue.identifier else { return }
        
        // 2
        if identifier == "photos" {
            print("Transitioning to the Display Note View Controller")
        }
    }
    
    
}
