//
//  LocationSearchResultViewController.swift
//  RestroApp
//
//  Created by khalid moin on 11/03/22.
//

import UIKit
import GooglePlaces

class LocationSearchResultViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableViewSearchResult: UITableView!
    
     private var tableDataSource: GMSAutocompleteTableDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self
        
        self.tableViewSearchResult.delegate = tableDataSource
        self.tableViewSearchResult.dataSource = tableDataSource
        
    }
    
    
}


extension LocationSearchResultViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // Update the GMSAutocompleteTableDataSource with the search text.
    tableDataSource.sourceTextHasChanged(searchText)
  }
}

extension LocationSearchResultViewController: GMSAutocompleteTableDataSourceDelegate {
  func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
    // Turn the network activity indicator off.
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    // Reload table data.
      self.tableViewSearchResult.reloadData()
  }

  func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
    // Turn the network activity indicator on.
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    // Reload table data.
      self.tableViewSearchResult.reloadData()
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
    // Do something with the selected place.
    print("Place name: \(place.name)")
    print("Place address: \(place.formattedAddress)")
    print("Place attributions: \(place.attributions)")
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
    // Handle the error.
    print("Error: \(error.localizedDescription)")
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
    return true
  }
}
