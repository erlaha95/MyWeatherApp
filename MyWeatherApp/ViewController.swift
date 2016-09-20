//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Yerlan Ismailov on 14.07.16.
//  Copyright © 2016 ismailov.com. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MapKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var mainTempLbl: UILabel!
    @IBOutlet weak var mainTempIcon: UIImageView!
    @IBOutlet weak var currentDtLbl: UILabel!
    
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    
    var weatherList = [Weather]()
    let weatherMain = Weather()
    var city = "Almaty"
//    var latitude: Double?
//    var longtitude: Double?
//    var locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadCurrentForecast({
            self.mainTempIcon.image = UIImage(named: "weather_\(self.weatherMain.iconUrl)")
            self.mainTempLbl.text = "\(self.weatherMain.mainTemp)º"
            self.currentDtLbl.text = self.weatherMain.getDateFromDt(Double(self.weatherMain.dt)!)
            self.windSpeedLbl.text = "\(self.weatherMain.wind)M/S"
            self.humidityLbl.text = "\(self.weatherMain.humidity)%"
            self.pressureLbl.text = "\(self.weatherMain.pressure)hPa"
        })
        downloadForecast ({
            self.locationLbl.text = "\(self.weatherMain.city), \(self.weatherMain.country)"
            self.collectionView.reloadData()
            
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //initLocationManager()
        //checkLocationPermission()
    }
    
    
    
//    func initLocationManager() {
//        locationManager = CLLocationManager()
//        locationManager.delegate = self;
//        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//    }
    
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        let location: CLLocation = locations.last!
//        locationManager.stopUpdatingLocation()
//        longtitude = location.coordinate.longitude
//        latitude = location.coordinate.latitude
//        var myLocationName: String?
//        let geoCoder = CLGeocoder()
//        geoCoder.reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, err: NSError?) in
//            if err == nil {
//                var placeMark: CLPlacemark!
//                placeMark = placemarks?[0]
//                
//                if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
//                    myLocationName = locationName as String
//                    print("Location: \(locationName)")
//                    
//                }
//
//            }
//        }
//        
//        print("Longtitude: \(longtitude)")
//        print("Latitude: \(latitude)")
//        downloadCurrentForecast({
//            self.mainTempIcon.image = UIImage(named: "weather_\(self.weatherMain.iconUrl)")
//            self.mainTempLbl.text = "\(self.weatherMain.mainTemp)º"
//            self.currentDtLbl.text = self.weatherMain.getFullDateAndTime(Double(self.weatherMain.dt)!)
//            self.windSpeedLbl.text = "\(self.weatherMain.wind)M/S"
//            self.humidityLbl.text = "\(self.weatherMain.humidity)%"
//            self.pressureLbl.text = "\(self.weatherMain.pressure)hPa"
//        })
//        
//        downloadForecast({
//            print("my loca: \(myLocationName)")
//            self.locationLbl.text = String(myLocationName)
//            self.collectionView.reloadData()
//            
//        })
//
//        
//    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Location Error", message: "Please, allow location", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
//    func checkLocationPermission() {
//        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//        }else if CLLocationManager.authorizationStatus() == .NotDetermined {
//            locationManager.requestWhenInUseAuthorization()
//        }else if CLLocationManager.authorizationStatus() == .Restricted {
//            showErrorAlert()
//        }else if CLLocationManager.authorizationStatus() == .Denied {
//            showErrorAlert()
//        }
//    }
    
    func downloadCurrentForecast(completed: DownloadComplete) {
        let urlCurrent = NSURL(string: "\(MAIN_URL)weather?q=\(city)&APPID=\(API_KEY)&units=metric")!
        Alamofire.request(.GET, urlCurrent).responseJSON { response in
            let result = response.result.value
            if let dict = result as? Dictionary<String, AnyObject> {
                
                if let dt = dict["dt"] as? Int {
                    self.weatherMain.dt = "\(dt)"
                    print("Current time: \(self.weatherMain.getMediumDateFromDt(Double(dt)))")
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double {
                        self.weatherMain.mainTemp = Int(temp)
                    }
                    if let pressure = main["pressure"] as? Double {
                        self.weatherMain.pressure = Int(pressure)
                    }
                    if let humidity = main["humidity"] as? Int {
                        self.weatherMain.humidity = humidity
                    }
                }
                if let wind = dict["wind"] as? Dictionary<String, Double> {
                    if let windSpeed = wind["speed"] {
                        self.weatherMain.wind = Int(windSpeed)
                    }
                }
                if let w = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let icon = w[0]["icon"] as? String {
                        let iconUrl = (icon as NSString).substringToIndex(2)
                        self.weatherMain.iconUrl = iconUrl
                    }
                }
                
            }
            completed()
        }
    }
    
    func downloadForecast(completed: DownloadComplete) {
        
        
        let url5 = NSURL(string: "\(MAIN_URL)forecast?q=\(city)&APPID=\(API_KEY)&units=metric")!
        Alamofire.request(.GET, url5).responseJSON { response in
            let result = response.result.value
            
            if let dict = result as? Dictionary<String, AnyObject> {
                
                if let city = dict["city"] as? Dictionary<String, AnyObject> {
                    if let cityName = city["name"] as? String {
                        self.weatherMain.city = cityName
                        print("City: \(cityName)")
                    }
                    if let country = city["country"] as? String {
                        print("Country: \(country)")
                        self.weatherMain.country = country
                    }
                }

                                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for i in 0..<list.count {
                        
                        let weather = Weather()
                        
                        if let dt = list[i]["dt"] as? Int {
                            weather.dt = "\(dt)"
                            print(dt)
                        }
                        if let main = list[i]["main"] as? Dictionary<String, AnyObject> {
                            if let temp = main["temp"] as? Double {
                                print("Temp \(temp)")
                                weather.mainTemp = Int(temp)
                            }
                            if let pressure = main["pressure"] as? Double {
                                print("Pressure \(pressure)")
                                weather.pressure = Int(pressure)
                            }
                            if let humidity = main["humidity"] as? Int {
                                print("Humidity \(humidity)")
                                weather.humidity = humidity
                            }
                            if let tempMin = main["temp_min"] as? Double {
                                print("Temp min \(tempMin)")
                                weather.minTemp = tempMin
                            }
                            if let tempMax = main["temp_max"] as? Double {
                                print("Temp max \(tempMax)")
                                weather.maxTemp = tempMax
                            }
                        }
                        if let w = list[i]["weather"] as? [Dictionary<String, AnyObject>] {
                            if let descr = w[0]["main"] as? String {
                                print("Descr \(descr)")
                                weather.weatherDescr = descr
                            }
                            if let icon = w[0]["icon"] as? String {
                                print(icon)
                                let iconUrl = (icon as NSString).substringToIndex(2)
                                weather.iconUrl = iconUrl
                            }
                        }
                        if let wind = list[i]["wind"] as? Dictionary<String, Double> {
                            if let windSpeed = wind["speed"] {
                                print("Wind speed \(windSpeed)")
                                weather.wind = Int(windSpeed)
                            }
                        }
                        self.weatherList.append(weather)
                    }
                }
                
            }
            completed()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(weatherList.count)
        
        return weatherList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TemperatureCell", forIndexPath: indexPath) as? TemperatureCell {
            let weather = self.weatherList[indexPath.row]
            cell.configureCell(weather)
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(125, 104)
    }
    
}

