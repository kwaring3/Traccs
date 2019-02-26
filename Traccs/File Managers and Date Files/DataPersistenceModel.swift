//
//  DataPersistenceModel.swift
//  Traccs
//
//  Created by Kevin Waring on 2/25/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import Foundation


final class DataPersistenceModel {
    private static var filename = "Cause.plist"
    static var mainCause = [Create]()
    
    private init() {}
    
    static func save() {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(mainCause)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Property list encoding error (error)")
        }
    }
    static func add1(cause: Create) {
        mainCause.append(cause)
        save()
    }
    static func get() -> [Create] {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    mainCause = try PropertyListDecoder().decode([Create].self, from: data).sorted(by: {$0.createdAt > $1.createdAt})
                } catch {
                    print("Property list decode error: (error)")
                }
            } else {
                print("Data does not exist...")
            }
        } else {
            print("(filename) does not exist...")
            mainCause.removeAll()
            save()
        }
        return mainCause
    }
    static func deleteQuiz(index: Int) {
        mainCause.remove(at: index)
        save()
    }
    
}
