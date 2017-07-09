//
//  pictureViewController.swift
//  ChatSnap
//
//  Created by Joshua Martin on 7/9/17.
//  Copyright © 2017 Joshua Martin. All rights reserved.
//

import UIKit
import Firebase


class pictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photosButton: UIBarButtonItem!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var pictureTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        pictureView.image = image
        pictureView.alpha = 1
        pictureView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = Storage.storage().reference().child("snaps")
        let imageData = UIImageJPEGRepresentation(pictureView.image!, 0.1)!
        
        imagesFolder.child("\(NSUUID().uuidString).jpeg").putData(imageData, metadata: nil, completion: {(metadata, error) in
            print("Attempting to upload image...")
            if error != nil {
                print("Oh shit bois somethin wrong:\(String(describing: error))")
            }else{
                print("succsessful! (probably)")
                self.performSegue(withIdentifier: "selectUserSegue", sender: nil)
            }
        }
    )}
}
