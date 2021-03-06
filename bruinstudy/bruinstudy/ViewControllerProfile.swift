//
//  ViewControllerProfile.swift
//  bruinstudy
//
//  Created by Royson Lin on 2/21/18.
//  Copyright © 2018 Awk. All rights reserved.
//

import UIKit

class ViewControllerProfile: UIViewController {
    
    var user: Person?
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var major: UILabel!
    @IBOutlet weak var gradYr: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fullName.text = user!.firstName + " " + user!.lastName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
