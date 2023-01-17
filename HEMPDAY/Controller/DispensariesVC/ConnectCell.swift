//
//  ConnectCell.swift
//  HEMPDAY
//
//  Created by admin on 2/19/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit

class ConnectCell: UITableViewCell {
    
    @IBOutlet weak var postOwnerNameLbl : UILabel!
    @IBOutlet weak var postIMG : UIImageView!
    @IBOutlet weak var postDateLbl : UILabel!
    @IBOutlet weak var authoreNameLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
