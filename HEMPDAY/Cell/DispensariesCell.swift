//
//  DispensariesCell.swift
//  HEMPDAY
//
//  Created by admin on 12/23/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class DispensariesCell: UITableViewCell {
    
    @IBOutlet weak var arrowIMG : UIImageView!
    @IBOutlet weak var readMoreLbl : UILabel!
    @IBOutlet weak var title : UILabel!
    
    @IBOutlet weak var TableVWHeight :  NSLayoutConstraint!
    
    @IBOutlet weak var TableVW :  UITableView!
    
     var subPostarray : [SubPost]?
    
     var didSelectTapAction : ((SubPost)-> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
     //   print("subPostarray?.count",subPostarray?.count)
        TableVW.delegate = self
        TableVW.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUppost(choice : [SubPost]){
        subPostarray = choice
        TableVWHeight.constant = CGFloat(50 * subPostarray!.count)
        TableVW.reloadData()
    }

}
extension DispensariesCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subPostarray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableVW.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath) as! DropdownCell
        
        let subPost = subPostarray?[indexPath.row]
        cell.configCellUI(choice : subPost)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // didSelectTapAction?(subPostarray?[indexPath.row].content ?? "", subPostarray?[indexPath.row].like ?? "", subPostarray?[indexPath.row].dislike ?? "")
        didSelectTapAction?((subPostarray?[indexPath.row])!)
    }
}


