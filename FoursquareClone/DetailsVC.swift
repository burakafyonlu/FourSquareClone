//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Burak Afyonlu on 5.02.2023.
//

import UIKit

class DetailsVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var atmosphereText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextClickButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextClickButton.isEnabled = false
        
        imageView.isUserInteractionEnabled = true
        
        let imageRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageRecognizer)
        
        let keyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(keyboard)
    }
    
    @objc func hideKeyboard() {
        
        view.endEditing(true)
        
    }
    
    @objc func selectImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        nextClickButton.isEnabled = true
        
    }

    @IBAction func nextClickButton(_ sender: Any) {
        
        if nameText.text != "" && typeText.text != "" && atmosphereText.text != "" {
            if let chosenImage = imageView.image {
                
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = nameText.text!
                placeModel.placeType = typeText.text!
                placeModel.placeAtmosphere = atmosphereText.text!
                placeModel.imagePlace = chosenImage
            }
            
            performSegue(withIdentifier: "toMapVC", sender: nil)
        } else {
            
            let alert = UIAlertController(title: "Error", message: "Place Name/Type/Atmosphere??", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            alert.addAction(okButton)
            self.present(alert, animated: true)
            
        }
       
        
    }
    
    
}
