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
    let documentID: String
    var update1: [String: String]
    
    init(dict: [String: Any]) {
     let urlString = dict["causeImageURL"] as? String ?? "No image"
        self.image = URL(string: urlString)!
        self.createdAt = dict["createdAt"] as? String ?? "no date"
        self.causeDescription = dict["causeDescription"] as? String ?? "no description"
        self.title = dict["causeTitle"] as? String ?? "no title"
        self.documentID = dict["documentID"] as? String ?? "no title"
        self.update1 = dict["update1"] as? [String:String] ?? [:]
    }
}
