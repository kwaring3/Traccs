//
//  DonateModel.swift
//  Traccs
//
//  Created by Kevin Waring on 3/4/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import Foundation
//init [string: Any]

struct Donate {
    let causeTitle: String
    let causeDescription: String
    let causeImageURL: String?
    let causeId: String
    let donationAmount: Double
    
    init(dict: [String: Any]) {
        self.causeTitle = dict["causeTitle"] as? String ?? "No Username"
        self.causeDescription = dict["causeDescription"] as? String ?? "no description"
        self.causeImageURL = dict["causeImageURL"] as? String ?? "no URL"
        self.causeId = dict["causeId"] as? String ?? "no cause id"
        self.donationAmount = dict["donationAmount"] as? Double ?? 0.0 
    }
    
}
