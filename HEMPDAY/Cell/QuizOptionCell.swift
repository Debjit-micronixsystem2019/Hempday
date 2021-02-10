//
//  QuizOptionCell.swift
//  HEMPDAY
//
//  Created by admin on 12/22/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class QuizOptionCell: UITableViewCell {
    
    @IBOutlet weak var optionLbl : UILabel!
    @IBOutlet weak var backgroundimageView : UIImageView!

    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }
       
       func configCellUI( choice  : choices!){
           optionLbl.text = choice.choice_option
       }

}
