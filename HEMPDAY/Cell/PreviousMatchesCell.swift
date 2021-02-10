//
//  PreviousMatchesCell.swift
//  HEMPDAY
//
//  Created by admin on 1/6/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit

class PreviousMatchesCell: UITableViewCell {
    
    @IBOutlet weak var productnameLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var productImg : UIImageView!
    @IBOutlet weak var backVW : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
