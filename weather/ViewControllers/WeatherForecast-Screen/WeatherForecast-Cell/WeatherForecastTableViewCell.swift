//
//  WeatherForecastTableViewCell.swift
//  weather
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// This class was designed and implemented for Weather Forecast display info
class WeatherForecastTableViewCell: UITableViewCell {

    static var identifier = "WeatherForecastTableViewCell"
    static var nib = UINib(nibName: identifier, bundle: nil)
    
    /// Time Label
    @IBOutlet weak var timeLabel: UILabel? {
        didSet {
            timeLabel?.textColor = UIColor.blackColor
            timeLabel?.font      = UIFont.systemFont(ofSize: 15)
            timeLabel?.textAlignment = .left
        }
    }
    
    /// Title Label
    @IBOutlet weak var titleLabel: UILabel? {
        didSet {
            titleLabel?.textColor = UIColor.blackColor
            titleLabel?.font      = UIFont.systemFont(ofSize: 18)
        }
    }
      
    // Description Label
    @IBOutlet weak var descriptionLabel: UILabel? {
        didSet {
            descriptionLabel?.textColor = UIColor.blackColor.withAlphaComponent(0.5)
            descriptionLabel?.font      = UIFont.systemFont(ofSize: 15)
        }
    }
    
    /// Temperature Label
    @IBOutlet weak var temperatureLabel: UILabel? {
        didSet {
            temperatureLabel?.textColor = UIColor.blackColor
            temperatureLabel?.font      = UIFont.boldSystemFont(ofSize: 25)
            temperatureLabel?.textAlignment = .right
        }
    }
    
    /// Min Temp Label
    @IBOutlet weak var minTempLabel: UILabel? {
        didSet {
            minTempLabel?.textColor = UIColor.blackColor
            minTempLabel?.font      = UIFont.systemFont(ofSize: 15)
        }
    }
    
    /// Max Temp Label
    @IBOutlet weak var maxTempLabel: UILabel? {
        didSet {
            maxTempLabel?.textColor = UIColor.blackColor
            maxTempLabel?.font      = UIFont.systemFont(ofSize: 15)
        }
    }
    
    /// Wind Speed Label
    @IBOutlet weak var windSpeedLabel: UILabel? {
        didSet {
            windSpeedLabel?.textColor = UIColor.blackColor
            windSpeedLabel?.font      = UIFont.systemFont(ofSize: 15)
        }
    }
    
    /// awake
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }

    /// selected state
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
