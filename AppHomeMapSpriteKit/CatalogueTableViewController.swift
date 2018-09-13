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
    
    var selectedDevice:DeviceRecord = DeviceRecord(name: "default", place: "", description: "")

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
        //return 1
        return myPlaces.places[section].devices.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        //print(indexPath)
        if(myPlaces.places[indexPath[0]].devices.count >  indexPath[1]){
            cell.textLabel?.text = myPlaces.places[indexPath[0]].devices[indexPath[1]].deviceName
            cell.detailTextLabel?.text = myPlaces.places[indexPath[0]].devices[indexPath[1]].deviceDescription  // get the subtitle and add it
        } else {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
            
            let button : UIButton = UIButton(type:UIButtonType.custom) as UIButton
            
            button.frame = CGRect(origin: CGPoint(x: 40,y :60), size: CGSize(width: 200, height: 24))
            let cellHeight: CGFloat = 44.0
            button.center = CGPoint(x: view.bounds.width / 2.0, y: cellHeight / 2.0)
            button.backgroundColor = UIColor.gray
            button.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
            button.setTitle("Add Device", for: UIControlState.normal)
            button.tag = indexPath[0]
            
            cell.addSubview(button)
        }
        
        return cell
    }
    
    @objc func buttonClicked(sender : UIButton!) {
        // Print the name of the place the button called
        print("Clicked! \(myPlaces.places[sender.tag].placeName)")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print( indexPath )
        if (myPlaces.places[indexPath[0]].devices.count >  indexPath[1]) {
            selectedDevice = myPlaces.places[indexPath[0]].devices[indexPath[1]]
            print("Selected Device -> \(selectedDevice.deviceName)")
            self.performSegue(withIdentifier: "showDeviceDetail", sender: nil)
        }
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDeviceDetail" {
            var next = segue.destination as! DeviceDetailViewController;
            next.myDevice = selectedDevice
        }
    }

}
