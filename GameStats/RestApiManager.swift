//
//  RestApiManager.swift
//  GameStats
//
//  Created by Charlie Buckets on 9/19/15.
//  Copyright © 2015 Charlie Buckets. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject{
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://nnba.ddns.net:11358/"
    
    func getTodaysGames(onCompletion: (JSON) -> Void){
        makeHttpGetRequest(baseURL + "todaysGames", onCompletion: {json, err -> Void in
            onCompletion(json)
    })

    func makeHttpGetRequest(path: String, onCompletion: ServiceResponse){
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler:  { data, response, error in
            let json: JSON = JSON(data)
            onCompletion(json, error)
            
        })
    }
}