//
//  GlobalMethods.swift
//  GoGetMobile
//
//  Created by Deepak on 1/5/19.
//  Copyright © 2019 Shreya. All rights reserved.
//

import Foundation
import UIKit

//MARK: Extract Json Files

func loadJson(filename fileName: String) -> NSDictionary? {
    
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let dictionary = object as? NSDictionary {
                
                return dictionary
            }
        } catch {
            print("Error!! Unable to parse  \(fileName).json")
        }
    }
    return nil
}

//MARK : Convert Server date to Shown Date

func convertDatetoShownDate(strDate : String, strDateformat : String) -> String {
    
    //"endTime": "2017-12-13T13:30:00+11",

    let formatter = DateFormatter()
    // initially set the format based on your datepicker date / server String
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let yourDate = formatter.date(from: strDate)
    //then again set the date format whhich type of output you need
    formatter.dateFormat = strDateformat
    // again convert your date to string
    let myStringafd = formatter.string(from: yourDate!)
    
    return myStringafd
    
   // print(myStringafd)
    
}


//MARK : Convert Server date to Shown Time

func convertDatetoShownTime(strDate : String) -> String {
    
    //"endTime": "2017-12-13T13:30:00+11",
    
    let formatter = DateFormatter()
    // initially set the format based on your datepicker date / server String
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    //let myString = formatter.string(from: strDate) // string purpose I add here
    // convert your string to date
    let yourDate = formatter.date(from: strDate)
    //then again set the date format whhich type of output you need
    formatter.dateFormat = "hh:mm a"
    // again convert your date to string
    let myStringafd = formatter.string(from: yourDate!)
    
    return myStringafd
    
    // print(myStringafd)
    
}

//MARK : Get Difference between dates

func getdurationbetweenDates(fromDate : Date, toDate : Date) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: fromDate, to: toDate);
        
       // let seconds = "\(difference.second ?? 0)s"
        let minutes = "\(difference.minute ?? 0) minutes"
        let hours = "\(difference.hour ?? 0) hours"
        let days = "\(difference.day ?? 0 )days"
        
        if let day = difference.day, day          > 0 { return days }
        if let hour = difference.hour, hour       > 0 { return hours }
        if let minute = difference.minute, minute > 0 { return minutes }
        if let second = difference.second, second > 0 { return "Just now" }
        return ""
}

let imageCache = NSCache<NSString, UIImage>()


extension UIImageView {
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: (urlString as AnyObject) as! NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if data != nil {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache!, forKey: (urlString as AnyObject) as! NSString)
                    self.image = imageToCache
                }
            }
            }.resume()
    }
}
///


