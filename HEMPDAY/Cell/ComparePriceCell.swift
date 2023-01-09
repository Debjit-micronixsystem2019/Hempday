//
//  ComparePriceCell.swift
//  HEMPDAY
//
//  Created by admin on 1/14/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit

class ComparePriceCell: UITableViewCell {
    
    @IBOutlet weak var productnameLbl : UILabel!
    @IBOutlet weak var addressLbl : UILabel!
    @IBOutlet weak var productImg : UIImageView!
    @IBOutlet weak var siteBtn : UIButton!
    @IBOutlet weak var priceLbl : UILabel!
    @IBOutlet weak var distanceLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
