//
//  RestAreaViewController.swift
//  FoodleDo
//
//  Created by apple on 08/09/2018.
//  Copyright © 2018 l1f14bscs0033. All rights reserved.
import UIKit
import GoogleMaps
import MapKit
import GooglePlaces
import CoreLocation
import Alamofire

class RestAreaViewController: UIViewController, GMSMapViewDelegate, UITableViewDataSource, UITableViewDelegate {

    var restAreaList = [RestArea]()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D!
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var centerMapCoordinate:CLLocationCoordinate2D!
    var marker:GMSMarker!
    
    @IBOutlet var restAreaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            restAreaTableView.refreshControl = refreshControl
        } else {
            restAreaTableView.backgroundView = refreshControl
        }
        self.title = "Rest Areas"
        self.callApi()
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let camera = GMSCameraPosition.camera(withLatitude: 0,
                                              longitude: 0,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.mapType = .satellite
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        self.locationManager.delegate = self
    }
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        restAreaTableView.reloadData()
        refreshControl.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func CalculateDistance(){
        
        print(restAreaList.count)
      //  print(restAreaList.)
        for i in 0...restAreaList.count-1{
    
            let mylocation = CLLocationCoordinate2D.init(latitude: Double((restAreaList[i].latitude!))!, longitude: Double((restAreaList[i].longitude!))!)
            print(restAreaList[i].latitude!)
            print(restAreaList[i].longitude!)
            print(currentLocation.latitude)
            print(currentLocation.longitude)
            print("Latitude : \(mylocation.latitude)")
            print("Longitude : \(mylocation.longitude)")
            print("Location \(String(describing: restAreaList[i].name)) Moving \(String(describing: restAreaList[i].bound)) Distance = \((GMSGeometryDistance(currentLocation, mylocation)/1000))")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(restAreaList.count)
        return restAreaList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestAreaTableViewCell", for: indexPath) as! RestAreaTableViewCell
        cell.nameLabel.text = restAreaList[indexPath.row].name
        
        cell.distanceLabel.text = restAreaList[indexPath.row].bound
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantsViewController") as! RestaurantsViewController
        vc.restAreaId = restAreaList[indexPath.row].restarea_id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func callApi(){
        let url = URL(string: "https://foodjango.000webhostapp.com/restarea.php?token=abc123xyz")
        Alamofire.request(url!).responseJSON{ response  in
            if response.result.isSuccess{
                let json = response.result.value as! [Any]
                print(json)
                for obj in json {
                    if let restarea = RestArea.init(dic: obj as! [String : Any]) {
                        self.restAreaList.append(restarea)
                        self.restAreaTableView.reloadData()
                    }
                    else{
                        print("error")
                    }
                }
                self.locationManager.startUpdatingLocation()
            }
            else{
                print(response.result.error!)
            }
        }
    }
}
extension RestAreaViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        print("Longitude: \((location?.coordinate.longitude)!)")
        print("Latitude: \((location?.coordinate.latitude)!)")
        self.currentLocation = CLLocationCoordinate2D.init(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        self.mapView?.animate(to: camera)
        //Finally stop updating location otherwise it will come again and again in this delegate
         self.locationManager.stopUpdatingLocation()
        
        
        
        
        self.CalculateDistance()
    }
    
}


