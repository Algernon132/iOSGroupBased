//
//  ViewController.swift
//  serverTest
//
//  Created by Kyle on 5/16/19.
//  Copyright © 2019 Kyle Stevenson. All rights reserved.
//

import UIKit

class ServerTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func testConnection(_ sender: UIButton) {
    }
    @IBAction func testLogin(_ sender: UIButton) {
        //loginUser(userName: "user", userPass: "pass")
        //print ("BUTTON CLICKED")
        
        struct LoginData: Codable {
            let user: String
            let pass: String
        }
        
        
        let loginData = LoginData(user: "user1",
                                  pass: "pass123")
        guard let uploadData = try? JSONEncoder().encode(loginData) else {
            return
        }
        
        let url = URL(string: "http://ec2-18-216-204-131.us-east-2.compute.amazonaws.com")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
            }else {
                print("something went wrong")
            }
        }
        task.resume()
        
    }
    func connectServer(){
        
        let session = URLSession.shared
        let url = URL(string:"http://18.216.204.131/")!
        
        let task = session.dataTask(with: url){ data,response, error in
            print("Data: ")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("String data: ")
            print(strData)
            print("Response: ")
            print(response)
            print("Error: ")
            print(error)
        }
        task.resume()
    }
    

}
