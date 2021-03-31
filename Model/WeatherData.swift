//
//  Weather.swift
//
//  Created by Macbook on 12/03/2021.

import Foundation

//the struct is Decodable, which makes it possible to turn JSON into the data model.
struct WeatherData :Codable {
    var name:String
    var main:Main
    var weather :Array<Weather>
    
}
struct Main :Codable {
    var temp:Double
}
struct Weather :Codable {
    var description:String
    var id:Int
}
