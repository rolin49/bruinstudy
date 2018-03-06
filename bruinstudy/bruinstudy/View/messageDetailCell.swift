//
//  messageDetailCell.swift
//  bruinstudy
//
//  Created by Eileen Lu on 3/5/18.
//  Copyright © 2018 Awk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class messageDetailCell: UITableViewCell {
    
    @IBOutlet weak var recipientImg: UIImageView!
    @IBOutlet weak var recipientName: UILabel!
    @IBOutlet weak var chatPreview: UILabel!
    var messageDetail: MessageDetail!

    var userPostKey: DatabaseReference!
    
    let currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(messageDetail: MessageDetail){
        self.messageDetail = messageDetail
        let recipientData = Database.database().reference().child("user").child (messageDetail.recipient)
        recipientData.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let data = snapshot.value as! Dictionary<String, AnyObject>.Element
            
            let username = data ["username"]
            
            let userImg = data ["userImg"]
            
            self.recipientName.text = username as? String
            
            let ref = Storage.storage().reference(forURL: user as! String)
            
            ref.data(withMaxSize: 10000, completion: {(data, error)
                
                if error != nil{
                    print("could not load image")
                } else{
                    if let imgData = data{
                        if let img = UIImage(data: imgData){
                            self.recipientImg.image = img
                        }
                    }
                }
            })
            
            
        })
    }
    

}
