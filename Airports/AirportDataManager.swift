//
//  AirportDataManager.swift
//  Airports
//
//  Created by Zhilnikov, Alexey on 30/3/17.
//  Copyright © 2017 Zhilnikov, Alexey. All rights reserved.
//

import Gloss

class AirportDataManager {
    
    fileprivate(set) var airports: [Airport]
    
    fileprivate let archiveURL: URL? = {
        let cachesDirectories = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        if let cacheDirectory = cachesDirectories.first {
            return cacheDirectory.appendingPathComponent("airports.archive")
        }
        return nil
    }()
    
    init() {
        airports = [Airport]()
        loadData()
    }
    
    func fetch(completion: @escaping (AirportsAPIResult) -> Void) {
        
        if !Reachability.isInternetAvailable() {
            completion(.failure(AirportsAPIError.noInternetConnection))
            return
        }
        
        guard let url = URL(string: "https://www.qantas.com.au/api/airports") else {
            return completion(.failure(AirportsAPIError.invalidURL))
        }
        
        let request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 30)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let taskError = error {
                completion(.failure(taskError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(AirportsAPIError.invalidResponse))
                return
            }
            
            if 200 != httpResponse.statusCode {
                completion(.failure(AirportsAPIError.invalidStatusCode))
                return
            }
            
            guard let airportsData = data else {
                completion(.failure(AirportsAPIError.invalidData))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: airportsData,
                                                            options: .allowFragments) as AnyObject
                if let jsonData = json as? JSON {
                    if let airports = Airports(json: jsonData)?.airports {
                        self.airports.removeAll()
                        self.airports.append(contentsOf: airports)
                        //self.sortData()
                        self.saveData()
                        completion(.success)
                        return
                    }
                }
                completion(.failure(AirportsAPIError.invalidJSONFormat))
            }
            catch let jsonError {
                completion(.failure(jsonError))
            }
        })
        task.resume()
    }
    
    // MARK: - Private methods
    
    fileprivate func sortData() {
        airports.sort {
            if let firstCode = $0.0.code, let secondCode = $0.1.code {
                return firstCode < secondCode
            }
            return false
        }
    }
    
    fileprivate func loadData() {
        if let filePath = archiveURL?.path,
            let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Airport] {
            airports.append(contentsOf: data)
        }
    }
    
    fileprivate func saveData() {
        if let filePath = archiveURL?.path {
            NSKeyedArchiver.archiveRootObject(airports, toFile: filePath)
        }
    }
    
    fileprivate func deleteData() {
        if let filePath = archiveURL?.path {
            do {
                airports.removeAll()
                try FileManager.default.removeItem(atPath: filePath)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Test methods
    
    func testAppend(_ data: [Airport]) {
        airports.append(contentsOf: data)
    }
    
    func testLoad() {
        self.loadData()
    }
    
    func testSave() {
        self.saveData()
    }
    
    func testDelete() {
        self.deleteData()
    }
    
    func testRemoveAll() {
        self.airports.removeAll()
    }
}
