//
//  shawmeMoreCell.swift
//  HEMPDAY
//
//  Created by admin on 1/13/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit

class shawmeMoreCell: UITableViewCell {
    
      @IBOutlet weak var productnameLbl : UILabel!
      @IBOutlet weak var dateLbl : UILabel!
      @IBOutlet weak var productImg : UIImageView!
      @IBOutlet weak var backVW : UIView!
    
    @IBOutlet weak var productImgHeight : NSLayoutConstraint!
    @IBOutlet weak var productImgWidth : NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
