//
//  ViewController.swift
//  firebaseAuth
//
//  Created by Thomas Jurczyk on 4/11/19.
//  Copyright © 2019 Thomas Jurczyk. All rights reserved.
//

import UIKit
import Firebase

class startViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

