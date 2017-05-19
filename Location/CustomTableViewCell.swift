//
//  CustomTableViewCell.swift
//  Location
//
//  Created by Alex Sisan on 19/04/2017.
//  Copyright © 2017 Alex Sisan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //Category Controller
    @IBOutlet weak var rateTitleLabel: UILabel!
    @IBOutlet weak var rateImageView: UIImageView!
    
    //Pub Detail Controller
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    //Results Controller
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
