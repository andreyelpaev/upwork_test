//
//  MarkerView.swift
//  TestToUpwork
//
//  Created by Andrey Elpaev on 03/05/2017.
//  Copyright © 2017 ClearSofrware. All rights reserved.
//

import Foundation
import UIKit

class MarkerView: UIView {
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var backgroundImage: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var directionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(hexString: "#60c369")
        
        let like = UIImage(named: "like")?.withRenderingMode(.alwaysOriginal)
        let direction = UIImage(named: "direction")?.withRenderingMode(.alwaysOriginal)
        
        directionButton.setImage(direction, for: .normal)
        likeButton.setImage(like, for: .normal)
     
        self.roundCorners(corners: [.allCorners], radius: 5)
        costLabel.textColor = .white
        addressLabel.textColor = .white

        
    }
    
    
    
    static func loadFromNib() -> MarkerView {
        let nib = UINib(nibName: "MarkerView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! MarkerView
    }
    
}
