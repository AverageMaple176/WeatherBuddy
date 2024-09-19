//
//  FileManger+Extension.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import Foundation

extension FileManager {
    static var fileName = "Cities.json"
    static var storageURL = URL.documentsDirectory.appendingPathComponent(fileName, conformingTo: .json)
    
    func fileExists() -> Bool {
        fileExists(atPath: Self.storageURL.path())
    }
    
    func readFile() throws -> Data {
        do {
            return try Data(contentsOf: Self.storageURL)
        } catch {
            throw error
        }
    }
    
    func saveFile(contents: String) throws {
        do {
            try contents.write(to: Self.storageURL, atomically: true, encoding: .utf8)
        } catch {
            throw error
        }
    }
}
