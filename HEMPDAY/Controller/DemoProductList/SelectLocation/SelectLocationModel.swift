//
//  SelectLocationModel.swift
//  HEMPDAY
//
//  Created by admin on 11/3/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import Foundation

// MARK: - LocationResponse
struct LocationResponse: Codable {
    let status: Int?
    let data: [SelectLocationData]?
}

// MARK: - Datum
struct SelectLocationData: Codable {
    let locationID: Int?
    let locationName, importID, website: String?
  //  let hoursOfOperation: JSONNull?
    let clientID: Int?
    let clientName: String?
    let locationLogoURL: String?
    let timeZone: String?
    let address: Address?
    let phoneNumber, email: String?
    let licenseType: [String]?

    enum CodingKeys: String, CodingKey {
        case locationID = "locationId"
        case locationName
        case importID = "importId"
        case website
        case clientID = "clientId"
        case clientName, locationLogoURL, timeZone, address, phoneNumber, email, licenseType
    }
}

// MARK: - Address
struct Address: Codable {
    let streetAddress1, streetAddress2, city, state: String?
    let county, zip, country: String?
}
