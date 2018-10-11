//
//  WeatherHandler.swift
//  WeatherMap
//
//  Created by Lokesh on 09/10/18.
//

import UIKit

class WeatherHandler: NSObject {
   class func getWeatherData(competion:@escaping completionHandler) {
        BaseApiHandler.getWeatherData(url: Constants.baseurl, completion: competion)
    }
}
