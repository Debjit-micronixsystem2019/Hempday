//
//  DemoProductModel.swift
//  HEMPDAY
//
//  Created by admin on 11/3/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import Foundation

struct DemoDataResponseModel : Decodable {
    var data : [DemoProductListData]?
    var status : Int?
}
struct DemoProductListData : Decodable {
    var cannabinoidInformation : [cannabinoidInformationData]?
    var brand : String?
    var category : String?
    var clientId : Int?
    var currencyCode : String?
    var expirationDate : String?
    var inventoryUnitOfMeasure : String?
    var inventoryUnitOfMeasureToGramsMultiplier : Int?
   // var isMixAndMatch : String?
   // var isStackable : String?
    var locationId : Int?
    var locationName : String?
    var nutrients : String?
    var priceInMinorUnits : Int?
    var productDescription : String?
    var productId : Int?
    var productName : String?
    var productPictureURL : String?
    var productUnitOfMeasure : String?
   // var productUnitOfMeasureToGramsMultiplier : Int?
    var productUpdatedAt : String?
    var productWeight : Float?
    var purchaseCategory : String?
    var quantity : Float?
    var sku : String?
    var speciesName : String?
    var type : String?
    var weightTierInformation : [weightTierInformationData]?

}
struct cannabinoidInformationData : Decodable {
    var lowerRange : Float?
    var name : String?
    var unitOfMeasure : String?
    var unitOfMeasureToGramsMultiplier : Int?
    var upperRange : Float?
}

struct weightTierInformationData : Decodable {
    var gramAmount : Float?
    var name : String?
    var pricePerUnitInMinorUnits : Int?
}
