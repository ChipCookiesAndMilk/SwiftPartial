//
//  PlaceDetailViewController.swift
//  AppHomeMapSpriteKit
//
//  Created by Video on 13/09/18.
//  Copyright © 2018 EHE. All rights reserved.
//
import UIKit
import Foundation

class PlaceDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var NameLabel: UITextField!
    @IBOutlet weak var AddressLabel: UITextField!
    @IBOutlet weak var DescriptionLabel: UITextField!
    
    var newPlace:PlaceRecord = PlaceRecord(name:"", description:"",address:"", latitude:0.0, longitude:0.0);
    //var newPlace:PlaceRecord;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //titleLabel.text = "Celda numero: ";
        AddressLabel.text = newPlace.placeAddress;
        NameLabel.text = newPlace.placeName;
        
        print(newPlace.placeName)
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        if(sender.title == "Add"){
            let name:String = NameLabel.text!
            let address:String = AddressLabel.text!
            let description:String = DescriptionLabel.text!
            print(name);
            
            if(name == "" || description == "" || address == ""){
                print("LLENAR nombre")
            }else{
                
                print("DATOS")
                
                //var newPlace = PlaceRecord(name: name!, description: description!, address: address!, latitude: Float(placemark.coordinate.latitude), longitude: Float(placemark.coordinate.longitude));
                //var newPlace = PlaceRecord(name: name, description: description, address: address, latitude: 10, longitude: 10);
                
                let newPlaceCatalogue = PlaceCatalogue()
                newPlaceCatalogue.loadPlacesFromFile()
                newPlace.setPlaceDescription(description: DescriptionLabel.text!)
                newPlaceCatalogue.addPlace(record: newPlace)
                print(newPlaceCatalogue.toJSON())
                
                
                // Set the file path
                //let path = "localHouse.json"
                //let filePath = Bundle.main.path(forResource: "localHouse", ofType: "json")
                /*let path = DocumentDirURL
                
                // Set the contents
                let contents = newPlaceCatalogue.toJSON()
                
                do {
                    // Write contents to file
                    try contents.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
                }
                catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }*/
                
                // Save data to file
                let fileName = "localHouse"
                let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                
                let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("json")
                print("FilePath: \(fileURL.path)")
                
                let writeString = newPlaceCatalogue.toJSON()
                do {
                    // Write to the file
                    try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                } catch let error as NSError {
                    print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
                }
                
                var readString = "" // Used to store the file contents
                do {
                    // Read the file contents
                    readString = try String(contentsOf: fileURL)
                } catch let error as NSError {
                    print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
                }
                print("File Text: \(readString)")
            }
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
