//
//  HomeViewCell.swift
//  HEMPDAY
//
//  Created by admin on 12/22/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    @IBOutlet weak var productimgVW : UIImageView!
    @IBOutlet weak var productNameimgVW : UIImageView!
    @IBOutlet weak var productPriceimgVW : UIImageView!
    @IBOutlet weak var productQuantityimgVW : UIImageView!
    @IBOutlet weak var dispensaryimgVW : UIImageView!

    @IBOutlet weak var distancelbl : UILabel!


    @IBOutlet weak var tradingVW : UIView!
    @IBOutlet weak var t_DeliveryNowButton : UIButton!
    @IBOutlet weak var t_PickUpButton : UIButton!
    
    @IBOutlet weak var viewDetailsButton : UIButton!
    @IBOutlet weak var nonTradingVW : UIView!


    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
