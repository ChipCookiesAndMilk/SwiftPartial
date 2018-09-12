//
//  LocationSearchTable.swift
//  AppHomeMapSpriteKit
//
//  Created by Fabiola Hernández on 9/11/18.
//  Copyright © 2018 EHE. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable : UITableViewController {
    var matchingItems : [MKMapItem] = [];
    // handler to the map from prev screen
    var mapView : MKMapView? = nil;
    // locationHandler
    var handleMapSearchDelegate:HandleMapSearch? = nil;
}

// extension for the locationSearchTable
extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        /* Set up API call */
        //  unwraps the optional values for mapView and the search bar text
        guard let mapView = mapView, let searchBarText = searchController.searchBar.text else { return }
        // The search string comes from the search bar text, and the map region comes from the mapView.
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        
        // performs the actual search on the request object
        let search = MKLocalSearch(request: request)
        // start, executes the search query and returns a MKLocalSearchResponse object
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

/* Set up the Table View Data Source */
extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark;
        cell.textLabel?.text = selectedItem.name;
        cell.detailTextLabel?.text = ""; // Change the detail of place or change cell to Title only
        return cell;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}



