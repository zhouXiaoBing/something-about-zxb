//
//  BleTableViewCell.swift
//  Caliper_Reader
//
//  Created by Wesley Chen on 2017/4/15.
//  Copyright © 2017年 Wesley Chen. All rights reserved.
//

import UIKit

class BleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var deviceUUID: UILabel!
    @IBOutlet weak var deviceRSSI: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
