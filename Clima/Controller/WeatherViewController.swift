//
//  ViewController.swift
//  Clima
import  CoreLocation

import UIKit
//class WeatherViewController: UIViewController,UITextFieldDelegate ,WeatherMangerDelegate{
class WeatherViewController: UIViewController{
    
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManger=WeatherManger()
    var locationManger = CLLocationManager ()
    
    @IBOutlet weak var tf_search: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
       
        
        
        tf_search.delegate=self
        weatherManger.weatherMangerDelegateRef=self
    }
   
    @IBAction func locationPressed(_ sender: Any) {
        locationManger.requestLocation()
        
    }
}


//MARK: - UITextFieldDelegate
extension WeatherViewController:UITextFieldDelegate{
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        //dismiss keybaord
        tf_search.endEditing(true)
        print(tf_search.text!)
    }
    //implement this fun to handle go btn in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //dismiss keybaord
        tf_search.endEditing(true)
        print(tf_search.text!)
        return true
    }
    //call after user end writing
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = tf_search.text {
            weatherManger.fetchWeatherData(cityName: city)
        }
        
        //clear tf_search
        tf_search.text=""
    }
    //Asks the delegate whether to stop editing in the specified text field.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if tf_search.text != "" {
            return true
        }else{
            tf_search.placeholder="Type Somthing"
            return false
        }
    }
}


//MARK: - WeatherMangerDelegate
extension WeatherViewController:WeatherMangerDelegate{
    
    func didUpdateWeather(weather: WeatherModel) {
       // print(weather.temperatureString)
        DispatchQueue.main.async {
            self.temperatureLabel.text=weather.temperatureString
            self.conditionImageView.image=UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - CLLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // print("get location data")
        if let location = locations.last {
            locationManger.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            weatherManger.fetchWeatherData(latitude: lat, longitute: lon)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
