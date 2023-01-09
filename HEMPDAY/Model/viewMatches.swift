//
//  viewMatches.swift
//  HEMPDAY
//
//  Created by admin on 1/13/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import Foundation
import UIKit

struct viewMatchesData {
     var product_image : String
     var product_name : String
     var product_prise : String
    var main_product : String
    init( product_image : String, product_name : String, product_prise : String, main_product : String) {
        self.product_image = product_image
        self.product_name = product_name
        self.product_prise = product_prise
        self.main_product = main_product
    }
}

