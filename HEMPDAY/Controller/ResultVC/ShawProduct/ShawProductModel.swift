//
//  ShawProductModel.swift
//  HEMPDAY
//
//  Created by admin on 7/15/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import Foundation

struct productData {
     var address : String
     var distance : String
     var prise : String
     var product_image : String
     var dispensari_name : String
     var site_link : String
    var site_title : String
    var product_name : String
    var latitude : String
    var longitude : String

    init( address : String, distance : String, prise : String, product_image : String, dispensari_name : String, site_link : String, site_title : String, product_name : String, latitude : String, longitude : String) {
        self.address = address
        self.distance = distance
        self.prise = prise
        self.product_image = product_image
        self.dispensari_name = dispensari_name
        self.site_link = site_link
        self.site_title = site_title
        self.product_name = product_name
        self.latitude = latitude
        self.longitude = longitude

    }
}
