//
//  CatalogueTableViewController.swift
//  AppHomeMapSpriteKit
//
//  Created by Video on 12/09/18.
//  Copyright © 2018 EHE. All rights reserved.
//

import UIKit

class CatalogueTableViewController: UITableViewController {
    
    private var myDevices = DeviceCatalogue()
    private var myPlaces = PlaceCatalogue()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDevices.loadDevicesFromFile()
        myPlaces.loadPlacesFromFile()
        
        // This prints the loaded Devices and Places
        /*for device in myDevices.devices{
            print("name: \(device.deviceName)")
        }
        for place in myPlaces.places{
            print("name: \(place.placeName)")
        }*/
        
        // Adding the devices to the array of the place they belong to
        for device in myDevices.devices{
            for place in myPlaces.places{
                if(device.devicePlace == place.placeName){
                    //print("Adding device \(device.deviceName) to place \(place.placeName)")
                    myPlaces.getPlaceWithName(name: place.placeName).addDevice(record: device)
                }
            }
        }
        
        // This prints the places and the devices they contain
        /*for place in myPlaces.places{
            print("Place: \(place.placeName)")
            for device in place.devices{
                print("   Device: \(device.deviceName)")
            }
        }*/
        
        // Adding cells

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return myPlaces.places.count
        //return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return myPlaces.places[section].placeName
        //return "Peliculas"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
        //return myPlaces.places[section].devices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        //print(indexPath)
        cell.textLabel?.text = myPlaces.places[indexPath[0]].devices[indexPath[1]].deviceName
        cell.detailTextLabel?.text = myPlaces.places[indexPath[0]].devices[indexPath[1]].deviceDescription  // get the subtitle and add it

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}