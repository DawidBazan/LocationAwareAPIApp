//
//  ViewController.swift
//  AssignmentApp
//
//  Created by Dawid  on 22/01/2018.
//  Copyright © 2018 Dawid Bazan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchBarDelegate {

    var searchBar = UISearchBar(frame: CGRect.zero)
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    
    var url = URL(string:"")
    var passPostcode = ""
    var passName = ""
    var manager = CLLocationManager()
    var LocationsList = [LocationsStats]()
    var filteredList = [LocationsStats]()
    
//Start of viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Ask for Authorisation from the User.
        self.manager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        }
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"));

        getJson {
            print("Data Loaded Successfully")
            self.tableView.reloadData()
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        searchBar.delegate = self
        searchBar.isHidden = true
        searchBar.placeholder = "Search"
        
    }
    
//Custom Cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        cell.labelCell.text = filteredList[indexPath.row].BusinessName.capitalized
        cell.labelCell2.text = filteredList[indexPath.row].PostCode
        cell.imageCell.image = UIImage(named:("\(filteredList[indexPath.row].RatingValue).jpg"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMore", sender: self)
    }
    
//populate lables in InfoView with data from selected cell
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InfoViewController {
            destination.info = filteredList[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

//Search button
    
    var doubleTap : Bool! = false
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        navigationItem.titleView = searchBar
        
        if (doubleTap) {
            doubleTap = false
            searchBar.isHidden = true
            searchBar.endEditing(true)
            searchBar.text = nil
            navigationItem.titleView = UIImageView(image: UIImage(named: "logo"));
        } else {
            doubleTap = true
            searchBar.isHidden = false
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredList = LocationsList
            tableView.reloadData()
            return
        }
        filteredList = LocationsList.filter({LocationsStats -> Bool in
            return LocationsStats.BusinessName.contains(searchText)
        })
        tableView.reloadData()
    }
    

//Connect to server to retrive data in Json
    
    func getJson(completed: @escaping () -> ()){
        
        print(passPostcode)
        print(passName)
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")

        if  (passPostcode == "") && (passName == "") {
        url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=\(locValue.latitude)&long=\(locValue.longitude)")
        }
        else if (passPostcode != "") && (passName == ""){
            url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_postcode&postcode=\(passPostcode)")
             }
        else {
            let newPassName = passName.replacingOccurrences(of: " ", with: "%20")
            url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_name&name=\(newPassName)")
        }
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do{
                self.LocationsList = try JSONDecoder().decode([LocationsStats].self, from: data!)
                    self.filteredList = self.LocationsList
                    DispatchQueue.main.async {
                        completed()
                    }
                  }catch {
                print("Json Error \(error)")
                  }
            }
        }.resume()
    }
}

