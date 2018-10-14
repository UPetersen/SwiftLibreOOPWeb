//
//  MoreExamples.swift
//  SwitftOOPWeb
//
//  Created by Bjørn Inge Berg on 14.10.2018.
//  Copyright © 2018 Bjørn Inge Berg. All rights reserved.
//

import Foundation



func uploadReadingExample1(){

    let accessToken = "someName-FollowedByRandomNumberGivenToYouByLibreoopwebAdmin"
    let site = "https://libreoopweb.azurewebsites.net"
    let client = LibreOOPClient(accessToken: accessToken, site: site)
    
    var patch = LibreOOPDefaults.TestPatchAlwaysReturning63

    // A positive response from the oop webinterface provides the following string:
    // "Hey hop, response received: some value from android: currentBg: 63 FullAlgoResults: {"currenTrend":0,"currentBg":63.0,"currentTime":4568,"historicBg":[{"bg":111.0,"quality":0,"time":4095},{"bg":115.0,"quality":0,"time":4110},{"bg":113.0,"quality":0,"time":4125},{"bg":129.0,"quality":0,"time":4140},{"bg":172.0,"quality":0,"time":4155},{"bg":169.0,"quality":0,"time":4170},{"bg":137.0,"quality":0,"time":4185},{"bg":132.0,"quality":0,"time":4200},{"bg":153.0,"quality":0,"time":4215},{"bg":212.0,"quality":0,"time":4230},{"bg":260.0,"quality":0,"time":4245},{"bg":286.0,"quality":0,"time":4260},{"bg":295.0,"quality":0,"time":4275},{"bg":276.0,"quality":0,"time":4290},{"bg":232.0,"quality":0,"time":4305},{"bg":179.0,"quality":0,"time":4320},{"bg":153.0,"quality":0,"time":4335},{"bg":156.0,"quality":0,"time":4350},{"bg":167.0,"quality":0,"time":4365},{"bg":181.0,"quality":0,"time":4380},{"bg":179.0,"quality":0,"time":4395},{"bg":162.0,"quality":0,"time":4410},{"bg":150.0,"quality":0,"time":4425},{"bg":133.0,"quality":0,"time":4440},{"bg":115.0,"quality":0,"time":4455},{"bg":107.0,"quality":0,"time":4470},{"bg":100.0,"quality":0,"time":4485},{"bg":91.0,"quality":0,"time":4500},{"bg":81.0,"quality":0,"time":4515},{"bg":69.0,"quality":0,"time":4530},{"bg":62.0,"quality":0,"time":4545},{"bg":0.0,"quality":1,"time":4560}],"serialNumber":"","timestamp":0}
    
    //// If you want to experiment with the oop algorithm and feed it with tweaked data, you can uncomment the following code wich is an example for a different status byte instead of the status byte of the original data.
    //    // set 0x04 instead of 0x03 as status byte of the patch data
    //    patch[4] = UInt8(0x04)
    //    // recalculate patch data crcs such that the crcs match the modified data and the can be feed into the OOP algorithm
    //    patch = SensorData(bytes: patch)!.bytesWithCorrectCRC()
    
    //
    
    // Uploads one reading only. It uses the defaultstate,
    // meaning that the algorithm will see this as the first ever reading from the sensor
    // These parameters are assumed if you don't specify them:
    //  oldState: LibreOOPDefaults.defaultState, sensorStartTimestamp: LibreOOPDefaults.sensorStartTimestamp,
    //   sensorScanTimestamp: LibreOOPDefaults.sensorScanTimestamp, currentUtcOffset: LibreOOPDefaults.currentUtcOffset
    client.uploadReading(reading: patch ) { (response, success, errormessage) in
        if(!success) {
            NSLog("remote: upload reading failed! \(errormessage)")
            return
        }
        
        if let response = response, let uuid = response.result?.uuid {
            print("uuid received: " + uuid)
            
            // The completion handler will be called once the result is available, or when a timeout is received
            // The timeout can be calculated as approx (intervalSeconds * maxTries) seconds
            // In case of timeout, the success parameter will be false, errormessage will have contents
            // and the oopCurrentValue will be nil
            // In case of success, oopCurrentValue will be a struct containing the result of the Algorithm
            client.getStatusIntervalled(uuid: uuid, { (success, errormessage, oopCurrentValue, newState) in
                
                NSLog("GetStatusIntervalled returned with success?: \(success), error: \(errormessage), response: \(String(describing: oopCurrentValue))), newState: \(newState)")
                NSLog("GetStatusIntervalled  newState: \(newState)")
                
                if let oopCurrentValue = oopCurrentValue {
                    
                    NSLog("Decoded content")
                    NSLog("  Current trend: \(oopCurrentValue.currentTrend)")
                    NSLog("  Current bg: \(oopCurrentValue.currentBg)")
                    NSLog("  Current time: \(oopCurrentValue.currentTime)")
                    NSLog("  Serial Number: \(oopCurrentValue.serialNumber ?? "-")")
                    NSLog("  timeStamp: \(oopCurrentValue.timestamp)")
                    var i = 0
                    for historyValue in oopCurrentValue.historyValues {
                        NSLog(String(format: "    #%02d: time: \(historyValue.time), quality: \(historyValue.quality), bg: \(historyValue.bg)", i))
                        i += 1
                    }
                }
            })
        }
        
    }
}

func uploadMultiple(){
    
     // This uploads multiple readings. These readings are assumed to be cronological and from the same sensor
     // They should be about five minutes apart. Note that the newState returned from one reading will be
     // fed to the next reading as oldstate. This will in effect smooth any sensor noise.
     // Some example readings passed to the algorithm:
     // CurrentBGs with empty newState:
     //     ["0: 77.0", "1: 84.0", "2: 95.0", "3: 91.0", "4: 88.0"]
     // CurrentBGs with prevNewState as old state:
     //     ["0: 77.0", "1: 82.0", "2: 90.0", "3: 91.0", "4: 89.0"]
     // This subfolder should exist in your Documents Folder in the finder
     // It should contain reading1.txt, reading2.txt etc with full sensor readings as a base64 encoded string
     let accessToken = "someName-FollowedByRandomNumberGivenToYouByLibreoopwebAdmin"
     let site = "https://libreoopweb.azurewebsites.net"
    
     let client = LibreOOPClient(accessToken: accessToken, site: site)
     let subfolder = "librereadings"
     if let filescontents = LibreOOPClient.getLibreReadingsFromFolderContents(subfolder: subfolder) {
     
     let  readings = [
         LibreReadingResult(created: "2018-04-23T03:49:47.986Z", b64Contents: filescontents["reading1.txt"]!),
         LibreReadingResult(created: "2018-04-23T03:54:59.002Z", b64Contents: filescontents["reading2.txt"]!),
         LibreReadingResult(created: "2018-04-23T03:59:21.403Z", b64Contents: filescontents["reading3.txt"]!),
         LibreReadingResult(created: "2018-04-23T04:04:29.507Z", b64Contents: filescontents["reading4.txt"]!),
         LibreReadingResult(created: "2018-04-23T04:09:21.186Z", b64Contents: filescontents["reading5.txt"]!)
     
     ]
     
     if let res = client.uploadDependantReadings(readings: readings) {
         print("got result:")
         res.forEach { (success, error, val,newstate) in
             if success{
             print("\(val!.historyValues)")
             }
         }
     }
     
     } else {
        print ("could not read files in subfolder \(subfolder)")
     }
    
    
}
