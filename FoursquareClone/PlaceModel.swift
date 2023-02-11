//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Burak Afyonlu on 8.02.2023.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var imagePlace = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init() {}
    
}
