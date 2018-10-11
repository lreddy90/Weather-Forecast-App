//
//  BaseApiHandler.swift
//  WeatherMap
//
//  Created by Lokesh on 09/10/18.
//

import UIKit
import Alamofire

typealias completionHandler = (_ response:Any?, _ error:NSError?)-> ()
class BaseApiHandler: NSObject {

    class func getWeatherData(url: String,completion: @escaping completionHandler) {
        let appId = Bundle.main.object(forInfoDictionaryKey: "AppID") as! String
        Alamofire.request(url+appId).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do{
                    let jonDecoder = JSONDecoder()
                    let weather = try jonDecoder.decode(WeatherData.self, from: data)
                        completion(weather,nil)
                    } catch let error as NSError{
                        completion(nil,error)
                    }
                }
            case .failure(let error):
                completion(nil,error as NSError)
            }
        }
    }
}

// MARK: Codables for JSON response
struct WeatherData: Codable {
    var cod: String?
    var message: Double?
    var cnt : Int?
    var city: City?
    var list = [List?]()
}

struct City: Codable {
    var id: Double?
    var name: String?
    var coord: Coord?
    var country: String?
}

struct Coord: Codable{
    var lat: Float?
    var lon: Float?
}

struct  List: Codable {
    var dt: Double?
    var dt_txt: String?
    var main: Main?
    var weather = [WeatherInfo?]()
    var clouds: Clouds?
    var wind: Wind?
    var sys: Sys?
    
}

struct Main: Codable {
    var temp: Float?
    var temp_min: Float?
    var temp_max: Float?
    var pressure: Float?
    var sea_level: Float?
    var grnd_level: Float?
    var humidity: Int?
    var temp_kf: Float?
}

struct WeatherInfo : Codable{
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Clouds: Codable {
    var all: Int?
}

struct Wind: Codable {
    var speed: Float?
    var deg: Float?
}

struct Sys: Codable {
    var pod: String?
}
