//
//  Create.swift
//  Traccs
//
//  Created by Kevin Waring on 2/25/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import Foundation


struct Create: Codable {
    let image: Data
    let title: String
    let causeDescription: String?
    let createdAt: String
    //let update1: [Update]
}
