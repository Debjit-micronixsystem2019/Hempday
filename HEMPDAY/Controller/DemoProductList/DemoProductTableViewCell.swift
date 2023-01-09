//
//  DemoProductTableViewCell.swift
//  HEMPDAY
//
//  Created by admin on 11/3/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit

class DemoProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productName : UILabel!
    @IBOutlet weak var productBrandName : UILabel!
    @IBOutlet weak var productCategory : UILabel!
    @IBOutlet weak var currencyCodeName : UILabel!
    @IBOutlet weak var locationName : UILabel!
    @IBOutlet weak var productDescription : UILabel!
    @IBOutlet weak var productUpdateAT : UILabel!
    @IBOutlet weak var productMinorUnits : UILabel!
    @IBOutlet weak var productWeight : UILabel!
    @IBOutlet weak var productType : UILabel!
    @IBOutlet weak var productExperiationDate : UILabel!
    @IBOutlet weak var productImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
