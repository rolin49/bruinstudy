//
//  ViewControllerSignup.swift
//  bruinstudy
//
//  Created by Royson Lin on 2/21/18.
//  Copyright © 2018 Awk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

struct Person {
    var firstName: String;
    var lastName: String;
    var major: String;
    var gradYr: Int;
    var email: String;
    var pswd: String;
    var imagePicker: UIImagePickerController!
}

class ViewControllerSignup: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageSelected = false
    var user: Person?
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var gradYr: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userImagePicker: UIImageView!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBAction func submitButton(_ sender: Any) {
        user = Person(
            firstName: firstNameField.text!,
            lastName: lastNameField.text!,
            major: major.text!,
            gradYr: Int(gradYr.text!)!,
            email: emailField.text!,
            pswd: pswdField.text!,
            imagePicker.delegate = self
            imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
        )
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    overrride func viewDidDisappear (_ animated: Bool){
        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
            performSegue(withIdentifier: "toProfile", sender: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            userImagePicker.image = image
            imageSelected = true
        }
        else {
            print("Image wasn't selected")
        }
    }
    
    func setUser(img: String){
        let userData = [
            "email": email!,
            "userImg": img
        ]
        
        KeychainWrapper.standard.set(userUid, forKey: "uid")
        
        let location = Database.database().reference().child("users").child(userUid)
        
        location.setValue(userData)
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImg(){
        if firstNameField == nil || lastNameField == nil{
            signUpBtn.isEnabled = false
        }
        else{
            firstName = firstNameField.text
            lastName = lastName.text
            signUpBtn.isEnabled = true
        }
        
        guard let imag = userImagePicker.image, imageSelected == true else{
            print("Image needs to be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            Storage.storage().reference().child(imgUid).put(imgData, metadata:
            metadata){ (metadata,error)}
            
            if error != nil {
                print("Did not upload image")
            }
            else {
                print("Uploaded")
                let downloadURL = metadata?.downloadURL().absoluteString
                
                if let url = downloadURL{
                    self.setUser(img: url)
                }            }
        }
    }
    
    @IBAction func createAccount (_ sender: AnyObject){
        Auth.auth().createUser(withEmail: emailField, password: passwordField,
                               completion: {(user, error) in
                                if error != nil{
                                    print ("Can't create user")
                                }
                                else{
                                    if let user = user {
                                        self.userUid = user.uid
                                    }
                                }
                                
                                self.uploadImg()
        })
    }
    @IBAction func selectedImgPicker (_ sender: AnyObject){
        present(imagePicker, animated: true, completion: nil)
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
