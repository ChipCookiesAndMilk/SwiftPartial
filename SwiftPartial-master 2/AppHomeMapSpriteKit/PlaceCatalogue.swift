//
//  PlaceCatalogue.swift
//  AppHomeMapSpriteKit
//
//  Created by Video on 12/09/18.
//  Copyright © 2018 EHE. All rights reserved.
//

import Foundation
import UIKit

public class PlaceCatalogue{
    public var places:[PlaceRecord] = []
    
    public func addPlace(record:PlaceRecord){
        places.append(record)
    }
    
    public func getPlaceWithName(name:String)->PlaceRecord{
        var i = 0
        
        while i<places.count {
            if name == places[i].placeName {
                //print("Found name")
                return places[i]
            }
            i = i+1
        }
        
        return places[i]
        //return PlaceRecord(name: "testName", description: "TestDesc", address: "TestAddr", latitude: 0.0, longitude: 0.0)
    }
    
    public func loadPlacesFromFile(){
        let filePath = Bundle.main.path(forResource: "localHouse", ofType: "json")
        let contentData = FileManager.default.contents(atPath: filePath!)
        let content = String(data: contentData!, encoding: String.Encoding.isoLatin1) as! String
        
        //print(content)
        do{
            let json = try JSONSerialization.jsonObject(with: contentData!, options: []) as? [String:Any]
            let placesArray = json!["Places"] as? NSArray
            
            for place in placesArray!{
                let p = place as? [String:Any]
                
                let pn = p!["name"] as? String
                let pd = p!["description"] as? String
                let pa = p!["address"] as? String
                let pLatStr = p!["latitude"] as? String
                let pLonStr = p!["longitude"] as? String
                
                let pLat = (pLatStr! as NSString).floatValue
                let pLon = (pLonStr! as NSString).floatValue

                //print("place: \(place) - \(pn) - \(pd) - \(pa) - \(pLat) - \(pLon)")
                //print("place: \(place)")
                
                addPlace(record: PlaceRecord(name: pn!, description: pd!, address: pa!, latitude: pLat, longitude: pLon))
            }
        }catch let err as NSError{
            print("error on json: \(err)")
        }
    }
}
