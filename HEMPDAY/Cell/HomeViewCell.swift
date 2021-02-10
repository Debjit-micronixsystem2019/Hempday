//
//  HomeViewCell.swift
//  HEMPDAY
//
//  Created by admin on 12/22/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    @IBOutlet weak var lbl : UILabel!
    @IBOutlet weak var backVW : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backVW.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
