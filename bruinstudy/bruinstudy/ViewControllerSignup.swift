//
//  ViewControllerSignup.swift
//  bruinstudy
//
//  Created by Royson Lin on 2/21/18.
//  Copyright © 2018 Awk. All rights reserved.
//

import UIKit

struct Person {
    var firstName: String;
    var lastName: String;
    var major: String;
    var gradYr: Int;
    var email: String;
    var pswd: String;
}

class ViewControllerSignup: UIViewController {
    
    var user: Person?
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var gradYr: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pswd: UITextField!
    
    @IBAction func submitButton(_ sender: Any) {
        user = Person(
            firstName: firstName.text!,
            lastName: lastName.text!,
            major: major.text!,
            gradYr: Int(gradYr.text!)!,
            email: email.text!,
            pswd: pswd.text!
        )
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    ///*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let secondViewController = segue.destination as! ViewControllerProfile
        secondViewController.user = user
        
    }
    //*/

}
