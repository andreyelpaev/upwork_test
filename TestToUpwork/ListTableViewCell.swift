//
//  ListTableViewCell.swift
//  TestToUpwork
//
//  Created by Andrey Elpaev on 02/05/2017.
//  Copyright © 2017 ClearSofrware. All rights reserved.
//

import UIKit


class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        costLabel.textColor = UIColor(hexString: "#d33232")
        nameLabel.textColor = UIColor(hexString: "#4c93b0")
        addressLabel.textColor = UIColor(hexString: "#565656")
        distanceLabel.textColor = UIColor(hexString: "#4c93b0")
        
        

    }
}
