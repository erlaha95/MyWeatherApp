//
//  TemperatureCell.swift
//  MyWeatherApp
//
//  Created by Yerlan Ismailov on 17.07.16.
//  Copyright © 2016 ismailov.com. All rights reserved.
//

import UIKit

class TemperatureCell: UICollectionViewCell {
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var tempIcon: UIImageView!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    
    func configureCell(weather: Weather) {
        dayLbl.text = weather.getTimeFromDt(Double(weather.dt)!)
        tempIcon.image = UIImage(named: "weather_\(weather.iconUrl)")
        maxTempLbl.text = "\(Int(weather.maxTemp))º"
        minTempLbl.text = "\(Int(weather.minTemp))º"
        dateLbl.text = weather.getDayFromDt(Double(weather.dt)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    
    
}
