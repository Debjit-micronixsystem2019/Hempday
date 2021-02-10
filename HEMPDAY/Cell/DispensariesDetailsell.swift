//
//  DispensariesDetailsell.swift
//  HEMPDAY
//
//  Created by admin on 2/9/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit

class DispensariesDetailsell: UITableViewCell {
    
    @IBOutlet weak var author_image : UIImageView!{
        didSet{
            author_image.layer.cornerRadius = author_image.frame.size.width / 2
            author_image.clipsToBounds = true
        }
    }
    @IBOutlet weak var author_name : UILabel!
    @IBOutlet weak var date : UILabel!
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var readMoreButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
