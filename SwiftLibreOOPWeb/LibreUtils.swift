//
//  LibreUtils.swift
//  SwitftOOPWeb
//
//  Created by Bjørn Inge Berg on 14.10.2018.
//  Copyright © 2018 Bjørn Inge Berg. All rights reserved.
//

import Foundation

class LibreUtils {
    
    public static var accessToken: String = "someaccesstoken"
   
    
    public static func GetParsedOOPResult(patch: [UInt8]) -> OOPCurrentValue? {
        let client = LibreOOPClient(accessToken: self.accessToken)
        var result : OOPCurrentValue? = nil
        let awaiter = DispatchSemaphore(value: 0)
        
        client.uploadReading(reading: patch ) { (response, success, errormessage) in
            if(!success) {
                NSLog("remote: upload reading failed! \(errormessage)")
                print("getparsedresult signal because of error")
                awaiter.signal()
                return
            }
            
            if let response = response, let uuid = response.result?.uuid {
                print("uuid received: " + uuid)
                client.getStatusIntervalled(uuid: uuid, { (success, errormessage, oopCurrentValue, newState) in
                    
                    NSLog("GetStatusIntervalled returned with success?: \(success), error: \(errormessage), response: \(String(describing: oopCurrentValue))), newState: \(newState)")
                    NSLog("GetStatusIntervalled  newState: \(newState)")
                    
                    result = oopCurrentValue
                    
                    print("getparsedresult signal")
                    awaiter.signal()
                    
                })
            } else {
                print("getparsedresult signal")
                awaiter.signal()
            }
            
            
        }
        print("awaiting getparsedresult")
        awaiter.wait()

        return result
    }

}
