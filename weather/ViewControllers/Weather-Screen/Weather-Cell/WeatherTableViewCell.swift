//
//  WeatherTableViewCell.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// This class was designed and implemented for displaying weather info
class WeatherTableViewCell: UITableViewCell {

    static var identifier = "WeatherTableViewCell"
    static var nib = UINib(nibName: identifier, bundle: nil)
    
    /// Name Label
    @IBOutlet weak var nameLabel: UILabel? {
        didSet {
            nameLabel?.textColor = UIColor.blackColor
            nameLabel?.font      = UIFont.boldSystemFont(ofSize: 20)
        }
    }
    
    /// description Label
    @IBOutlet weak var descriptionLabel: UILabel? {
        didSet {
            descriptionLabel?.textColor = UIColor.blackColor.withAlphaComponent(0.5)
            descriptionLabel?.font      = UIFont.systemFont(ofSize: 18)
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
