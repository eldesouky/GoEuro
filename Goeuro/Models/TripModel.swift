//
//  TripModel.swift
//  Goeuro
//
//  Created by Mahmoud Eldesouky on 1/15/17.
//  Copyright © 2017 Mahmoud Eldesouky. All rights reserved.
//

import UIKit

class TripModel: NSObject {

    final let secondsInAnHour: Double = 3600
    final let imageSize: Int = 63
    
    // MARK:- Model Attributes
    dynamic var id: Int = 0
    var idString: String!
    var numberOfStops: Int!
    var departureTime: NSDate!
    var arrivalTime: NSDate!
    var price: Double!{
        didSet{
            let roundedPrice = price.format(".02")
            let splitedPrice = roundedPrice.characters.split{$0 == "."}.map(String.init)
            self.priceWholeNumberToString = "€\(splitedPrice[0])."
            self.priceFractionalNumberToString = "\(splitedPrice[1])"
        }
    }
    var providerImageURLString: String!{
        didSet{
            providerImageURLString = providerImageURLString.stringByReplacingOccurrencesOfString("{size}", withString: "63")
        }
    }
   
    //MARK:- UI Required Attributes
    var priceWholeNumberToString: String!
    var priceFractionalNumberToString: String!
    var departureTimeToString: String!{
        return toStringFormat(departureTime!)
    }
    var arrivalTimeToString: String!{
        return toStringFormat(arrivalTime!)
    }
    var arrival_departureToString: String!{
        return "\(departureTimeToString) - \(arrivalTimeToString)"
    }
    var durationInSeconds: NSTimeInterval! {
        return (arrivalTime!.timeIntervalSinceDate(departureTime!))
    }
    var durationInSecondsToNSNumber: NSNumber!{
        return NSNumber(double: durationInSeconds)
    }
    var durationToString: String! {
        return "\(Int(durationInSeconds! / secondsInAnHour)):\(Int((durationInSeconds! % secondsInAnHour) / 60).format(".2"))h"
    }
    var numberOfStopsToString: String!{
        get{
            if numberOfStops == 0{
                return "Direct"
            }
            else  if numberOfStops == 1 {
                return "\(numberOfStops) connection"
            }
            else {
                return "\(numberOfStops) connections"
            }
        }
    }

    // static instance of formatter to avoid its expensive initialition
    class var formatter : NSDateFormatter {
        struct Static {
            static let instance: NSDateFormatter = {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                return dateFormatter
            }()
        }
        return Static.instance
    }
    
    //MARK:- Mapping
    func map(dictionary: [String: AnyObject] ){
        
        self.id = (dictionary["id"] as? Int)!
        self.providerImageURLString = dictionary["provider_logo"] as? String
        self.numberOfStops = dictionary["number_of_stops"] as? Int
        self.departureTime = toDateFormat((dictionary["departure_time"] as? String)!)
        self.arrivalTime = toDateFormat((dictionary["arrival_time"] as? String)!)
        
        if let price = dictionary["price_in_euros"]! as? Double {
            self.price = price
        }
        else if let price = dictionary["price_in_euros"]! as? String {
            self.price = Double(price)!
        }
    }

    //MARK:- Mapping Helper Methods
    func toDateFormat(string: String) -> NSDate {
        return TripModel.formatter.dateFromString(string)!
    }
    
    func toStringFormat(date: NSDate) -> String {
        return TripModel.formatter.stringFromDate(date)
    }
    
    // round the value to n-decimal places
    func roundToPlaces(value:Double, places:Int) -> String {
        let divisor = pow(10.0, Double(places))
        return "\(round(value * divisor) / divisor)"
    }
        
}