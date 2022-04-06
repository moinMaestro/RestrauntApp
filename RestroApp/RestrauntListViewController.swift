//
//  RestrauntListViewController.swift
//  RestroApp
//
//  Created by khalid moin on 08/03/22.
//

import UIKit
import ProgressHUD
import CoreLocation

class RestrauntListViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var tableViewRestrauntsList: UITableView!
    //MARK: -Variable Declaration
    var loctionmManager:CLLocationManager = CLLocationManager()
    var Longitude:Double = 80.3504843
    var latitude: Double = 26.4732721
    
    var previousCordinate = CLLocation(latitude: 0.0, longitude: 0.0)
    
    let ApiKey: String = "AIzaSyDeetiFIQ2BrqikGLN4rm76T6-0IGSPTCA&libraries"
    
    var restraunListArr:[RestrauntModal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationSetUp()
        self.getRestraunListData()
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
        
        let currentCordiante = CLLocation(latitude: self.latitude, longitude: self.Longitude)
        
        print("current cordiante",currentCordiante)
        print("previous cordiante",self.previousCordinate)
        
        let distanceInMeters = self.previousCordinate.distance(from: currentCordiante)
        
        print("distance",distanceInMeters)
        
        if distanceInMeters > 1000{
            self.previousCordinate = currentCordiante
            self.getRestraunListData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
//MARK: UITableViewDelegate And DataSource
extension RestrauntListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restraunListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let restrauntCell = tableView.dequeueReusableCell(withIdentifier: "RestrauntTableViewCell") as? RestrauntTableViewCell else{
            return UITableViewCell()
        }
        restrauntCell.designCell(data: self.restraunListArr[indexPath.row])
        return restrauntCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.getRestrauntDetail(id: String.getString(self.restraunListArr[indexPath.row].place_id))
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

//MARK: API Call
extension RestrauntListViewController{
    
    func getRestraunListData(){
        
        let param:[String:Any] = [:]
        let serviceName =  "https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=restaurant&location=\(self.latitude),\(self.Longitude)&radius=5000&key=\(self.ApiKey)"
        
        KMNetworkManager.sharedInstance.requestApi(withServiceName: serviceName, requestMethod: .GET, requestParameters: param, withProgressHUD: true, baseURL: "") { [weak self] (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            
            guard self != nil else {
                return
            }
            
            self?.restraunListArr.removeAll()
            let dictResponse = kSharedInstance.getDictionary(result)
            
            switch statusCode {
            case 200:
                
                let data = kSharedInstance.getArray(withDictionary: dictResponse["results"])
                
                let dataDict:[RestrauntModal] = data.map{RestrauntModal.init(data: $0)}
                
                self?.restraunListArr = dataDict.sorted{
                    $0.user_ratings_total > $1.user_ratings_total
                }
                
                self?.tableViewRestrauntsList.isHidden = false
                self?.tableViewRestrauntsList.reloadData()
                
            case 401:
                CommonUtils.showToast(message: "Your session has expired. Please login again.")
                
            case 426:
                CommonUtils.showToast(message: "Your session has expired. Please login again.")
                
            case 503:
                print("")
                
            default:
                CommonUtils.showToast(message: "Somrthing Wrong")
                break
            }
        }
    }
    
    
    func getRestrauntDetail(id: String){
        
        let param:[String:Any] = [:]
        let serviceName =  "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(id)&key=\(self.ApiKey)"
        
        KMNetworkManager.sharedInstance.requestApi(withServiceName: serviceName, requestMethod: .GET, requestParameters: param, withProgressHUD: true, baseURL: "") { [weak self] (result: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            
            guard self != nil else {
                return
            }
            
            //self?.restraunListArr.removeAll()
            let dictResponse = kSharedInstance.getDictionary(result)
            
            switch statusCode {
            case 200:
                
                let data = kSharedInstance.getArray(withDictionary: dictResponse["results"])
//
//                let dataDict:[RestrauntModal] = data.map{RestrauntModal.init(data: $0)}
//
//                self?.restraunListArr = dataDict.sorted{
//                    $0.user_ratings_total > $1.user_ratings_total
//                }
//
//                self?.tableViewRestrauntsList.isHidden = false
//                self?.tableViewRestrauntsList.reloadData()
                
            case 401:
                CommonUtils.showToast(message: "Your session has expired. Please login again.")
                
            case 426:
                CommonUtils.showToast(message: "Your session has expired. Please login again.")
                
            case 503:
                print("")
                
            default:
                CommonUtils.showToast(message: "Somrthing Wrong")
                break
            }
        }
    }
}

