//
//  ViewControllerMessage.swift
//  bruinstudy
//
//  Created by Megan on 3/5/18.
//  Copyright © 2018 Awk. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ViewControllerMessage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    func numberOfSections (in tableView: UITableView, numberOfRowsinSection section: Int)->
        Int {
       return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell{
        
        return MessageDetailCell()
    }
}
