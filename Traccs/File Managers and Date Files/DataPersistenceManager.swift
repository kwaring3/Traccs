//
//  DataPersistenceManager.swift
//  Traccs
//
//  Created by Kevin Waring on 2/25/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import Foundation


final class DataPersistenceManager {
    private init() {}
    
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func filepathToDocumentsDiretory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
