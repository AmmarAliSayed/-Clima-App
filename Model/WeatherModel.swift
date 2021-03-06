//
//  WeatherModel.swift
//  Clima
//
//  Created by Macbook on 13/03/2021.
//

import Foundation
struct WeatherModel {
    
    let condtionId:Int
    let cityName:String
    let temperature:Double
    //computed property
    var temperatureString:String{
        return String(format: "%.1f", temperature)
    }
    
    //computed property
    var conditionName:String{
        
        switch condtionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }
    
    
}
