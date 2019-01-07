//
//  MybookingCell.swift
//  GoGetMobile
//
//  Created by Deepak on 1/5/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit

class MybookingCell: UITableViewCell {

    @IBOutlet weak var lblBookingTime: UILabel!
    @IBOutlet weak var lblBookingDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
