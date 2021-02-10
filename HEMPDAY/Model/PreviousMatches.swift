//
//  PreviousMatches.swift
//  HEMPDAY
//
//  Created by admin on 1/6/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import Foundation
import UIKit

struct productListData {
     var date : String
     var product_image : String
     var product_name : String
    init( date : String, product_image : String, product_name : String) {
        self.date = date
        self.product_image = product_image
        self.product_name = product_name
    }
}
