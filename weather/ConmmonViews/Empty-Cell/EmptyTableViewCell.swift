//
//  EmptyTableViewCell.swift
//  weather
//
//  Created by Marianne Katramiz on 1/18/20.
//  Copyright © 2020 Marianne Katramiz. All rights reserved.
//

import UIKit

/// This class was designed and implemented to customize table cell view for empty cell with label
class EmptyTableViewCell: UITableViewCell {

    static var identifier = "EmptyTableViewCell"
    static var nib = UINib(nibName: identifier, bundle: nil)
    
    /// Title Label
    @IBOutlet weak var titleLabel: UILabel? {
        didSet {
            titleLabel?.textColor = UIColor.blackColor.withAlphaComponent(0.5)
            titleLabel?.font      = UIFont.systemFont(ofSize: 18)
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
