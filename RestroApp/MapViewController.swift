//
//  MapViewController.swift
//  RestroApp
//
//  Created by khalid moin on 11/03/22.
//

import UIKit
import GooglePlaces
//  RestrauntListViewController.swift
//  RestroApp
//
//  Created by khalid moin on 08/03/22.
//

import UIKit
import ProgressHUD
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    
    private var placesClient: GMSPlacesClient!
    var loctionmManager:CLLocationManager = CLLocationManager()
    var Longitude:Double = 80.3504843
    var latitude: Double = 26.4732721
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesClient = GMSPlacesClient.shared()
        self.locationSetUp()
        self.hello()
        
        
    }
    
    func locationSetUp(){
        self.loctionmManager.delegate = self
        self.loctionmManager.desiredAccuracy = kCLLocationAccuracyBest
        self.loctionmManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            print("Location Service enable")
            self.loctionmManager.startUpdatingLocation()
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else{
            return
        }
        
        self.Longitude = location.coordinate.longitude
        self.latitude = location.coordinate.latitude
        
        hello()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func hello(){
        let placeFields: GMSPlaceField = [.name, .formattedAddress]
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                return
            }
            
            guard let place = placeLikelihoods?.first?.place else {
                strongSelf.nameLabel.text = "No current place"
                strongSelf.addressLabel.text = ""
                return
            }
            
            strongSelf.nameLabel.text = place.name
            strongSelf.addressLabel.text = place.formattedAddress
        }
    }
}
