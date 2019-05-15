//
//  ViewController.swift
//  PostTestIOS
//
//  Created by Chaz on 5/13/19.
//  Copyright © 2019 Chaz. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        AF.request("http://18.216.204.131/").responseJSON { response in
//            print(response)
//
//        }
        
        let parameters = [
            "action":"createProject",
            "username":"testUser4",
            "hashedPassword":"abcd",
            "fullName":""
        ]
        
        AF.request("http://18.216.204.131/", method: .post, parameters: parameters).responseJSON{ response in
            print(response)
        }
        
        
    }
        // Do any additional setup after loading the view.

}

