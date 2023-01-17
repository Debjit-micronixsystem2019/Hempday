//
//  DropdownCell.swift
//  HEMPDAY
//
//  Created by admin on 2/12/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit

class DropdownCell: UITableViewCell {
    
    @IBOutlet weak var postTitle : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configCellUI( choice  : SubPost!){
        postTitle.text = choice.title
    }

}
