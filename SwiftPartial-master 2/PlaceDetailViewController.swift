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
    
    
    @IBOutlet weak var AddressLabel: UITextField!
    @IBOutlet weak var NameLabel: UITextField!
    @IBOutlet weak var DescriptionLabel: UITextField!
    
    
    var newPlace:PlaceRecord = PlaceRecord(name:"", description:"",address:"", latitude:0.0, longitude:0.0);
    //var newPlace:PlaceRecord;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //titleLabel.text = "Celda numero: ";
        AddressLabel.text = newPlace.placeAddress;
        print(newPlace.placeAddress)
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        if(sender.title == "Accept"){
            let name:String = NameLabel.text!
            let address:String = AddressLabel.text!
            let description:String = DescriptionLabel.text!
            print(name);
            
            if(name == "" || description == "" || address == ""){
                print("LLENAR nombre")
            }else{
                
                print("DATOS")
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
