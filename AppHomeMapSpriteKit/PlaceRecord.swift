//
//  PlaceRecord.swift
//  AppHomeMapSpriteKit
//
//  Created by Video on 12/09/18.
//  Copyright © 2018 EHE. All rights reserved.
//

import Foundation

public class PlaceRecord{
    private var name:String = ""
    private var description:String = ""
    private var address:String = ""
    private var latitude:Float = 0.0
    private var longitude:Float = 0.0
    
    public var devices:[DeviceRecord] = []
    
    public func addDevice(record:DeviceRecord){
        devices.append(record)
    }
    
    // Constructor
    init(name:String, description:String, address:String, latitude:Float, longitude:Float) {
        self.name = name
        self.description = description
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // Getter methods
    public var placeName:String{
        return self.name
    }
    public var placeDescription:String{
        return self.description
    }
    public var placeAddress:String{
        return self.address
    }
    public var placeLatitude:Float{
        return self.latitude
    }
    public var placeLongitude:Float{
        return self.longitude
    }
    
    // Setter methods
    public func setPlaceName(name:String)->Void{
        self.name = name
    }
    public func setPlaceDescription(description:String)->Void{
        self.description = description
    }
    public func setPlaceAddress(address:String)->Void{
        self.address = address
    }
    public func setPlaceLatitude(latitude:Float)->Void{
        self.latitude = latitude
    }
    public func setPlaceLongitude(longitude:Float)->Void{
        self.longitude = longitude
    }
}
