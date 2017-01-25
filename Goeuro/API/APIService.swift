//
//  APIService.swift
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

import UIKit

class APIService: NSObject {

    //MARK:- API URL
    static let trainsURL = NSURL(string: "https://api.myjson.com/bins/3zmcy")
    static let busesURL = NSURL(string: "https://api.myjson.com/bins/37yzm")
    static let flightsURL = NSURL(string: "https://api.myjson.com/bins/w60i")

    
    //MARK:- API Request
    static func fetchTripsFor(tripType: TripType, completion: ([TripModel], Bool) -> ()){
        
        let url: NSURL!
        
        switch tripType {
        case Train :
            url = trainsURL
        case Bus:
            url = busesURL
        case Flight:
            url = flightsURL
        default:
            url = trainsURL
            break
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            if error != nil {
                completion([], true)
                print(error)
                return
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                var trips: [TripModel] = []


                for dictionary in json as! [[String: AnyObject]] {
                    
                    let trip = TripModel()
                    trip.map(dictionary)
                    trips.append(trip)
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(trips, false)
                    })
                }
                    
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
            }.resume()
        
    }
    
}