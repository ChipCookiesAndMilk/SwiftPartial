//
//  DeviceRecord.swift
//  AppHomeMapSpriteKit
//
//  Created by Video on 12/09/18.
//  Copyright © 2018 EHE. All rights reserved.
//

import Foundation

public class DeviceRecord{
    private var name:String = ""
    private var place:String = ""
    private var description:String = ""
    
    init(name:String, place:String, description:String) {
        self.name = name
        self.place = place
        self.description = description
    }
    
    // Getter methods
    public var deviceName:String{
        return self.name
    }
    public var deviceDescription:String{
        return self.description
    }
    public var devicePlace:String{
        return self.place
    }
    
    // Setter methods
    public func setDeviceName(name:String)->Void{
        self.name = name
    }
    public func setDeviceDescription(description:String)->Void{
        self.description = description
    }
    public func setDevicePlace(place:String)->Void{
        self.place = place
    }
}
