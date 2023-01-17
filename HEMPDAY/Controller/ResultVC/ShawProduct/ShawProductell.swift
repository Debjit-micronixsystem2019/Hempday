//
//  ShawProductell.swift
//  HEMPDAY
//
//  Created by admin on 7/15/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit

class ShawProductell: UITableViewCell {
    
    @IBOutlet weak var productimgVW : UIImageView!
    @IBOutlet weak var dispensaryNameLbl : UILabel!
    @IBOutlet weak var distanceLbl : UILabel!
    @IBOutlet weak var priceLbl : UILabel!
    @IBOutlet weak var urlButtan : UIButton!
    @IBOutlet weak var pickUPBtn : UIButton!
    @IBOutlet weak var deliveryBtn : UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
