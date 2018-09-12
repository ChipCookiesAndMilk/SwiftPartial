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
}

// extension for the locationSearchTable
extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        /* Set up API call */
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}
