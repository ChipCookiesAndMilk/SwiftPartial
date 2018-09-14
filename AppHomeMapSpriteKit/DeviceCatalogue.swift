//
//  DeviceCatalogue.swift
//  AppHomeMapSpriteKit
//
//  Created by Video on 12/09/18.
//  Copyright © 2018 EHE. All rights reserved.
//

import Foundation

public class DeviceCatalogue{
    public var devices:[DeviceRecord] = []
    
    public func addDevice(record:DeviceRecord){
        devices.append(record)
    }
    
    public func loadDevicesFromFile(){
        let filePath = Bundle.main.path(forResource: "localDevices", ofType: "json")
        let contentData = FileManager.default.contents(atPath: filePath!)
        let content = String(data: contentData!, encoding: String.Encoding.isoLatin1) as! String
        
        //print(content)
        do{
            let json = try JSONSerialization.jsonObject(with: contentData!, options: []) as? [String:Any]
            let devicesArray = json!["Devices"] as? NSArray
            
            for device in devicesArray!{
                let d = device as? [String:Any]
                
                let dn = d!["name"] as? String
                let dp = d!["place"] as? String
                let dd = d!["description"] as? String
                
                //print("device: \(device)")
                
                addDevice(record: DeviceRecord(name: dn!, place: dp!, description: dd!))
            }
        }catch let err as NSError{
            print("error on json: \(err)")
        }
    }
}
