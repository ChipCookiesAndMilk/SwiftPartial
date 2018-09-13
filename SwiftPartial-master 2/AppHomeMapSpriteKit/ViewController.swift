//
//  ViewController.swift
//  AppHomeMapSpriteKit
//
//  Created by Video on 10/09/18.
//  Copyright © 2018 EHE. All rights reserved.
//

import UIKit
import MapKit

/* Custom protocol */
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}


class ViewController : UIViewController {
    
    public var nombre:String = "";
    public var descr:String = "";
    public var address:String = "";
    public var latitude:Float = 0.0;
    public var longitude:Float = 0.0;
    
    // CLLocationManager gives access to the location manager throughout the  scope of the controller
    let locationManager = CLLocationManager()
    // mapKitVariable
    @IBOutlet weak var mapView: MKMapView!
    // searchBar
    var resultSearchController : UISearchController? = nil;
    // pin
    var selectedPin:MKPlacemark? = nil;
    
    @IBOutlet weak var AcceptButton: UIBarButtonItem!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(selectedPin != nil){
            print("DATOS")
            let next = segue.destination as! PlaceDetailViewController;
            next.newPlace = PlaceRecord(name:nombre, description:descr, address:address, latitude:latitude, longitude:longitude)
            //var placeRecord = PlaceRecord(name:nombre, description:descr, address:address, latitude:latitude, longitude:longitude)
            //print(placeRecord)
        }else{
            print("NO HAY DATOS")
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        if(sender.title == "Accept"){
            if(selectedPin != nil){
                print("DATOS")
                //var placeRecord = PlaceRecord(name:nombre, description:descr, address:address, latitude:latitude, longitude:longitude)
                performSegue(withIdentifier: "showPlaceData", sender: nil)
            }else{
                print("NO HAY DATOS")
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print()
        /* Get current location of user */
        // delegate, handles responses asynchronously
        locationManager.delegate = self;
        // (optional) override the default accuracy level
        
        // or to save some battery
        //locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        // triggers the location permission dialog
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // triggers a one-time location request
        locationManager.requestWhenInUseAuthorization();
        
        /* Search Bar */
        // uses storyboardID; Table View Controller, works as a delegate
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        // Configure searchBar & embeds it with the navigation bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Ingresa direccion"
        navigationItem.titleView = resultSearchController?.searchBar
        // determines whether the Navigation Bar dissapears when search results are shown
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        // gives semi-transparent look to the background searchBar is selected
        resultSearchController?.dimsBackgroundDuringPresentation = true
        // limits the overlap area to just the View Controller's frame
        definesPresentationContext = true
        
        /* Link map elements */
        locationSearchTable.mapView = mapView
        
        /* pin */
        locationSearchTable.handleMapSearchDelegate = self;
    }
}
// in extension intead another class
extension ViewController : CLLocationManagerDelegate {
    // This method gets called when the user responds to the permission dialog. If allowed status = CLAuthorizationStatus.AuthorizedWhenInUse.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // bc the first one will be a failure
            locationManager.requestLocation();
        }
    }
    
    // returns an array of locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location: \(location)");
            if let location = locations.first{
                let span = MKCoordinateSpanMake(0.05, 0.05);
                let region = MKCoordinateRegion(center: location.coordinate, span: span);
                mapView.setRegion(region, animated: true);
            }
        }
    }
    
    // notifies errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)");
    }
}

/* extension for the pin */
extension ViewController: HandleMapSearch {
    // dropPinZoomIn for the Handle protocol created
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        
        // create a new annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality, let state = placemark.administrativeArea, let name = placemark.name, let country = placemark.country, let code = placemark.postalCode{
            
            
            annotation.subtitle = "Cuidad: \(city) Estado: \(state)";
            address = "\(name),\(city), \(country), \(code)";
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}
