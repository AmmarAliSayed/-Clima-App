//
//  WeatherManger.swift
//  Clima
//
//  Created by Macbook on 11/03/2021.
//

import Foundation
import Alamofire
import  CoreLocation
protocol WeatherMangerDelegate {
    func didUpdateWeather(weather:WeatherModel)
    func didFailWithError(error:Error)
    
}

struct WeatherManger {
    
    //base url
    //https://api.openweathermap.org/data/2.5/weather?appid=8da6429616378324ba9aab679c6df3d5&q=Assiut&units=metric
    let weatherUrl="https://api.openweathermap.org/data/2.5/weather?appid=8da6429616378324ba9aab679c6df3d5&units=metric"
    
   var weatherMangerDelegateRef:WeatherMangerDelegate?
    
    
    func fetchWeatherData(cityName:String) {
        let urlString="\(weatherUrl)&q=\(cityName)"
        performRequst(url: urlString)
       // print(urlString)
    }
    func fetchWeatherData(latitude :  CLLocationDegrees ,longitute : CLLocationDegrees) {
        let urlString="\(weatherUrl)&lat=\(latitude)&lon=\(longitute)"
        performRequst(url: urlString)
    }
    func performRequst(url:String)  {
        //using Alamofire
        Alamofire.request(url).responseJSON{(response) in
            if let myData = response.data {
                //print(json)
                if let weather = parseJSON(myData){
                    weatherMangerDelegateRef?.didUpdateWeather(weather: weather)
                }
            }
               
            
            
        }
    }
        
    func parseJSON(_ jsonData:Data) -> WeatherModel? {
        let decoder=JSONDecoder()
        do{
            //decode fun throws exception so use try and catch
            //The decode method of JSONDecoder is used to decode the JSON response. It returns the value of the type we specify
            let decodedData =  try  decoder.decode(WeatherData.self, from: jsonData)
        //decodedData is Weather type now
          //  print(decodedData.name)
           // print(decodedData.main.temp)
          let id =  decodedData.weather[0].id
            let temp=decodedData.main.temp
            let name=decodedData.name
            let weatherObj=WeatherModel(condtionId: id, cityName: name, temperature: temp)
            return weatherObj
           // print(weatherObj.temperatureString)
        }catch{
            //if something happens in decoding operation
            //print(error)
            weatherMangerDelegateRef?.didFailWithError(error: error)
            return nil
        }
      
    }
   
    }
