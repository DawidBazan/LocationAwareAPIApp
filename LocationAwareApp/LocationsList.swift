//
//  HygieneList.swift
//  AssignmentApp
//
//  Created by Dawid  on 22/01/2018.
//  Copyright © 2018 Dawid Bazan. All rights reserved.
//

import Foundation

struct LocationsStats:Decodable {
    
    let id: String
    let BusinessName: String
    let AddressLine1: String
    let AddressLine2: String
    let AddressLine3: String
    let PostCode: String
    let RatingValue: String
    let RatingDate: String
    let Longitude: String
    let Latitude: String
}
