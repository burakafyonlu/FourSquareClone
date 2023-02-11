//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Burak Afyonlu on 5.02.2023.
//

import UIKit
import Parse

class PlacesVC: UIViewController ,UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButton))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logOutClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromParse()
    }
    
    func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                
            } else {
                
                if objects != nil {
                    
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        
                       
                        
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeId = object.objectId {
                                self.placeNameArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func makeAlert(titleInput : String , messageInput : String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "resultVC" {
            
            let destinationVC = segue.destination as! ResultVC
            destinationVC.chosenPlaceId = selectedPlaceId
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "resultVC", sender: nil)
        
    }
    
    @objc func logOutClicked() {
        
        PFUser.logOutInBackground { error in
            if error != nil {
                
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                
            } else {
                
                self.performSegue(withIdentifier: "SignUp", sender: nil)
                
                
            }
        }
    }
    
    @objc func addButton() {
        
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return placeNameArray.count
    }
    
    
    

}
