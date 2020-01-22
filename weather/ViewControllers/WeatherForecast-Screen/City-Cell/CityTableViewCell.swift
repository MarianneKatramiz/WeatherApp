//
//  CityTableViewCell.swift
//  weather
//
//  Created by Marianne Katramiz on 1/19/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// This class was designed and implemented for displaying city name
class CityTableViewCell: UITableViewCell {

    static var identifier = "CityTableViewCell"
    static var nib = UINib(nibName: identifier, bundle: nil)
    
    /// Name Label
    @IBOutlet weak var nameLabel: UILabel? {
        didSet {
            nameLabel?.textColor = UIColor.blackColor
            nameLabel?.font      = UIFont.boldSystemFont(ofSize: 25)
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
