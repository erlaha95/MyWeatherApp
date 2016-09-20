//
//  Weather.swift
//  MyWeatherApp
//
//  Created by Yerlan Ismailov on 17.07.16.
//  Copyright © 2016 ismailov.com. All rights reserved.
//

import Foundation

class Weather {
    private var _city: String!
    private var _country: String!
    private var _mainTemp: Int!
    private var _maxTemp: Double!
    private var _minTemp: Double!
    private var _pressure: Int!
    private var _humidity: Int!
    private var _weatherDescr: String!
    private var _iconUrl: String!
    private var _wind: Int!
    private var _dt: String!
    
//    init(city: String, country: String, mainTemp: Double, pressure: Double, humidity: Double, weatherDescr: String, iconUrl: String, wind: Double, dt: Double){
//        self._city = city
//        self._country = country
//        self._mainTemp = mainTemp
//        self._pressure = pressure
//        self._humidity = humidity
//        self._weatherDescr = weatherDescr
//        self._iconUrl = iconUrl
//        self._wind = wind
//        self._dt = dt
//    }
    
    init () {
        
    }
    
    var city: String {
        set(newCity) {
            self._city = newCity
        }
        get {
            if _city == nil {
                _city = ""
            }
            return _city
        }
    }
    var country: String {
        get {
            return _country
        }
        set(newCountry) {
            self._country = newCountry
        }
    }
    var mainTemp: Int{
        get {
            return _mainTemp
        }
        set(newMainTemp) {
            self._mainTemp = newMainTemp
        }
    }
    var maxTemp: Double{
        get{
            return self._maxTemp
        }
        set(newMaxTemp){
            self._maxTemp = newMaxTemp
        }
    }
    var minTemp: Double {
        get{
            return self._minTemp
        }
        set(newMinTemp){
            self._minTemp = newMinTemp
        }
    }
    var pressure: Int {
        get{
            return self._pressure
        }
        set(newPressure) {
            self._pressure = newPressure
        }
    }
    var humidity: Int {
        get {
            return self._humidity
        }
        set(newHum){
            self._humidity = newHum
        }
    }
    var weatherDescr: String {
        get {
            return self._weatherDescr
        }
        set(newWeatherDescr) {
            self._weatherDescr = newWeatherDescr
        }
    }
    var iconUrl: String {
        get{
            return self._iconUrl
        }
        set(newIconUrl){
            self._iconUrl = newIconUrl
        }
    }
    var wind: Int {
        get {
            return self._wind
        }
        set(newWind) {
            self._wind = newWind
        }
    }
    var dt: String {
        get{
            return self._dt
        }
        set(newDt){
            self._dt = newDt
        }
    }
    
    func getDayFromDt(dt: Double) -> String{
        let date = NSDate(timeIntervalSince1970: dt)
        let form = NSDateFormatter()
        form.dateFormat = "EEE, dd MMM"
        let dateStr = form.stringFromDate(date)
        return dateStr
    }
    
    func getMediumDateFromDt(dt: Double) -> String {
        let date = NSDate(timeIntervalSince1970: dt)
        let f = NSDateFormatter.localizedStringFromDate(date, dateStyle: .MediumStyle, timeStyle: .NoStyle)
        return f
    }
    
    func getTimeFromDt(dt: Double) -> String {
        let date = NSDate(timeIntervalSince1970: dt)
        let f = NSDateFormatter.localizedStringFromDate(date, dateStyle: .NoStyle, timeStyle: .ShortStyle)
        return f
    }
    
    func getDateFromDt(dt: Double) -> String {
        let date = NSDate(timeIntervalSince1970: dt)
        let form = NSDateFormatter()
        form.dateFormat = "dd MMM, HH:mm"
        let dateStr = form.stringFromDate(date)
        return dateStr

    }
    
    func getFullDateAndTime(dt: Double) -> String {
        let date = NSDate(timeIntervalSince1970: dt)
        let f = NSDateFormatter.localizedStringFromDate(date, dateStyle: .FullStyle, timeStyle: .ShortStyle)
        return f
    }
    
}
