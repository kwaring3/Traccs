//
//  Create.swift
//  Traccs
//
//  Created by Kevin Waring on 2/25/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import Foundation


struct AdminCause: Codable {
    let image: URL
    let title: String
    let causeDescription: String?
    let createdAt: String
    //let update1: [Update]
    
    init(dict: [String: Any]) {
     let urlString = dict["causeImageURL"] as? String ?? "No image"
        self.image = URL(string: urlString)!
        self.createdAt = dict["createdAt"] as? String ?? "no date"
        self.causeDescription = dict["causeDescription"] as? String ?? "no description"
        self.title = dict["causeTitle"] as? String ?? "no title"
        
    }
}
