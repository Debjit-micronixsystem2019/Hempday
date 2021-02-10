//
//  Dispanseries.swift
//  HEMPDAY
//
//  Created by admin on 1/18/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import Foundation
struct Dispensariec {
     var address : String
     var dispensari_name : String
     var latitude : Double
     var longitude : Double
    
    init( address : String, dispensari_name : String, latitude : Double, longitude : Double) {
        self.address = address
        self.dispensari_name = dispensari_name
        self.latitude = latitude
        self.longitude = longitude
    }
}
