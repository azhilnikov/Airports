//
//  AirportsTableViewController.swift
//  Airports
//
//  Created by Zhilnikov, Alexey on 29/3/17.
//  Copyright © 2017 Zhilnikov, Alexey. All rights reserved.
//

import UIKit

class AirportsTableViewController: UITableViewController {
    
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let airportDataManager = AirportDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .clear
        navigationItem.hidesBackButton = true
        
        tableView.backgroundView = activityIndicator
        
        if airportDataManager.airports.isEmpty {
            activityIndicator.startAnimating()
        }
        
        airportDataManager.fetch(completion: { [weak self] (result) in
            
            DispatchQueue.main.async(execute: {
                self?.activityIndicator.stopAnimating()
                
                switch result {
                case .success:
                    self?.tableView.reloadData()
                    
                case .failure(let error as AirportsAPIError):
                    self?.showAlert(title: "Error", message: error.errorDescription)
                    
                default:
                    self?.showAlert(title: "Error", message: "Unknown error")
                }
            })
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let advc = segue.destination as? AirportDetailedViewController,
            let airport = sender as? Airport {
            advc.airportDetails = airport
        }
    }
    
    // MARK: - Private method
    
    fileprivate func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


extension AirportsTableViewController {
    
    // MARK: - Table view data source delegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airportDataManager.airports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportCell", for: indexPath)
        
        cell.textLabel?.text = airportDataManager.airports[indexPath.row].code
        cell.detailTextLabel?.text = airportDataManager.airports[indexPath.row].country?.displayName
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let airport = airportDataManager.airports[indexPath.row]
        performSegue(withIdentifier: "ShowAirportDetails", sender: airport)
    }
}
