//
//  LibreOOPCredentials.swift
//  SwitftOOPWeb
//
//  Created by Uwe Petersen on 11.10.18.
//  Copyright © 2018 Bjørn Inge Berg. All rights reserved.
//

import Foundation

/// Structure to retrieve the access token for the SwiftOOPWeb web interface.s
///
/// To be initialized with the name of the file that contains the accessToken string. The file must be located in the documents directory of the current user.
struct LibreOOPCredentials {
    // file that contains the access token as a string, must be located on the documents directory.
    var file: String

    func accessToken() -> String? {

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            do {
                let token = try String(contentsOf: fileURL, encoding: .utf8)
                return token
            }
            catch {/* error handling here */}
            print("\nError: File '\(fileURL.path)' not found. \n")
        }
        return nil
    }
    
}
