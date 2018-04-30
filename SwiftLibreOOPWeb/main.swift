//
//  main.swift
//  SwitftOOPWeb
//
//  Created by Bjørn Inge Berg on 08.04.2018.
//  Copyright © 2018 Bjørn Inge Berg. All rights reserved.
//
import Foundation

// Example Libre patch contents.
// This would typically by a full readout of the sensor from a blureader,blucon, miaomiao or some other nfc to bluetooth bridge.
var patch : [UInt8] = [
    0x3a, 0xcf, 0x10, 0x16, 0x03, 0x00, 0x00, 0x00, // 0x00 Begin of header
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 0x01
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 0x02 End of header
    0x4f, 0x11, 0x08, 0x10, 0xad, 0x02, 0xc8, 0xd4, // 0x03 Begin of body. CRC shoud be 4f 11. trendIndex: 8, historyIndex: 16
    0x5b, 0x00, 0xaa, 0x02, 0xc8, 0xb4, 0x1b, 0x80, // 0x04
    0xa9, 0x02, 0xc8, 0x9c, 0x5b, 0x00, 0xa9, 0x02, // 0x05
    0xc8, 0x8c, 0x1b, 0x80, 0xb0, 0x02, 0xc8, 0x30, // 0x06
    0x5c, 0x80, 0xb0, 0x02, 0x88, 0xe6, 0x9c, 0x80, // 0x07
    0xb8, 0x02, 0xc8, 0x3c, 0x9d, 0x80, 0xb8, 0x02, // 0x08
    0xc8, 0x60, 0x9d, 0x80, 0xa1, 0x02, 0xc8, 0xdc, // 0x09
    0x9e, 0x80, 0xab, 0x02, 0xc8, 0x14, 0x9e, 0x80, // 0x0A
    0xa9, 0x02, 0xc8, 0xc0, 0x9d, 0x80, 0xab, 0x02, // 0x0B
    0xc8, 0x78, 0x9d, 0x80, 0xaa, 0x02, 0xc8, 0x40, // 0x0C
    0x9d, 0x80, 0xa8, 0x02, 0xc8, 0x08, 0x9d, 0x80, // 0x0D
    0xa8, 0x02, 0xc8, 0x2c, 0x5c, 0x80, 0xad, 0x02, // 0x0E
    0xc8, 0xf8, 0x5b, 0x00, 0x29, 0x06, 0xc8, 0xf4, // 0x0F
    0x9b, 0x80, 0xc9, 0x05, 0xc8, 0x8c, 0xde, 0x80, // 0x10
    0xc3, 0x05, 0xc8, 0x28, 0x9e, 0x80, 0x2c, 0x06, // 0x11
    0xc8, 0xd0, 0x9e, 0x80, 0x7b, 0x06, 0x88, 0xa6, // 0x12
    0x9e, 0x80, 0xf9, 0x05, 0xc8, 0xb0, 0x9e, 0x80, // 0x13
    0x99, 0x05, 0xc8, 0xf0, 0x9e, 0x80, 0x2e, 0x05, // 0x14
    0xc8, 0x00, 0x9f, 0x80, 0x81, 0x04, 0xc8, 0x48, // 0x15
    0xa0, 0x80, 0x5d, 0x04, 0xc8, 0x38, 0x9d, 0x80, // 0x16
    0x12, 0x04, 0xc8, 0x10, 0x9e, 0x80, 0xcf, 0x03, // 0x17
    0xc8, 0x4c, 0x9e, 0x80, 0x6f, 0x03, 0xc8, 0xb8, // 0x18
    0x9e, 0x80, 0x19, 0x03, 0xc8, 0x40, 0x9f, 0x80, // 0x19
    0xc5, 0x02, 0xc8, 0xf4, 0x9e, 0x80, 0xaa, 0x02, // 0x1A
    0xc8, 0xf8, 0x5b, 0x00, 0xa2, 0x04, 0xc8, 0x38, // 0x1B
    0x9a, 0x00, 0xd1, 0x04, 0xc8, 0x28, 0x9b, 0x80, // 0x1C
    0xe4, 0x04, 0xc8, 0xe0, 0x1a, 0x80, 0x8f, 0x04, // 0x1D
    0xc8, 0x20, 0x9b, 0x80, 0x22, 0x06, 0xc8, 0x50, // 0x1E
    0x5b, 0x80, 0xbc, 0x06, 0xc8, 0x54, 0x9c, 0x80, // 0x1F
    0x7f, 0x05, 0xc8, 0x24, 0x5c, 0x80, 0xc9, 0x05, // 0x20
    0xc8, 0x38, 0x5c, 0x80, 0x38, 0x05, 0xc8, 0xf4, // 0x21
    0x1a, 0x80, 0x37, 0x07, 0xc8, 0x84, 0x5b, 0x80, // 0x22
    0xfb, 0x08, 0xc8, 0x4c, 0x9c, 0x80, 0xfb, 0x09, // 0x23
    0xc8, 0x7c, 0x9b, 0x80, 0x77, 0x0a, 0xc8, 0xe4, // 0x24
    0x5a, 0x80, 0xdf, 0x09, 0xc8, 0x88, 0x9f, 0x80, // 0x25
    0x6d, 0x08, 0xc8, 0x2c, 0x9f, 0x80, 0xc3, 0x06, // 0x26
    0xc8, 0xb0, 0x9d, 0x80, 0xd9, 0x11, 0x00, 0x00, // 0x27 End of body. Time: 4569 (0xd911 -> bytes swapped -> 0x11d9 = 4569)
    0x72, 0xc2, 0x00, 0x08, 0x82, 0x05, 0x09, 0x51, // 0x28 Beginn of footer
    0x14, 0x07, 0x96, 0x80, 0x5a, 0x00, 0xed, 0xa6, // 0x29
    0x0e, 0x6e, 0x1a, 0xc8, 0x04, 0xdd, 0x58, 0x6d  // 0x2A End of footer
];

// A positive response from the oop webinterface provides the following string:
// "Hey hop, response received: some value from android: currentBg: 63 FullAlgoResults: {"currenTrend":0,"currentBg":63.0,"currentTime":4568,"historicBg":[{"bg":111.0,"quality":0,"time":4095},{"bg":115.0,"quality":0,"time":4110},{"bg":113.0,"quality":0,"time":4125},{"bg":129.0,"quality":0,"time":4140},{"bg":172.0,"quality":0,"time":4155},{"bg":169.0,"quality":0,"time":4170},{"bg":137.0,"quality":0,"time":4185},{"bg":132.0,"quality":0,"time":4200},{"bg":153.0,"quality":0,"time":4215},{"bg":212.0,"quality":0,"time":4230},{"bg":260.0,"quality":0,"time":4245},{"bg":286.0,"quality":0,"time":4260},{"bg":295.0,"quality":0,"time":4275},{"bg":276.0,"quality":0,"time":4290},{"bg":232.0,"quality":0,"time":4305},{"bg":179.0,"quality":0,"time":4320},{"bg":153.0,"quality":0,"time":4335},{"bg":156.0,"quality":0,"time":4350},{"bg":167.0,"quality":0,"time":4365},{"bg":181.0,"quality":0,"time":4380},{"bg":179.0,"quality":0,"time":4395},{"bg":162.0,"quality":0,"time":4410},{"bg":150.0,"quality":0,"time":4425},{"bg":133.0,"quality":0,"time":4440},{"bg":115.0,"quality":0,"time":4455},{"bg":107.0,"quality":0,"time":4470},{"bg":100.0,"quality":0,"time":4485},{"bg":91.0,"quality":0,"time":4500},{"bg":81.0,"quality":0,"time":4515},{"bg":69.0,"quality":0,"time":4530},{"bg":62.0,"quality":0,"time":4545},{"bg":0.0,"quality":1,"time":4560}],"serialNumber":"","timestamp":0}

//// If you want to experiment with the oop algorithm and feed it with tweaked data, you can uncomment the following code wich is an example for a different status byte instead of the status byte of the original data.
//    // set 0x04 instead of 0x03 as status byte of the patch data
//    patch[4] = UInt8(0x04)
//    // recalculate patch data crcs such that the crcs match the modified data and the can be feed into the OOP algorithm
//    patch = SensorData(bytes: patch)!.bytesWithCorrectCRC()

//note that the accesstoken will be given to you by the libreoopweb admin
let accessToken = "someName-FollowedByRandomNumberGivenToYouByLibreoopwebAdmin"


let site = "https://libreoopweb.azurewebsites.net"
let remote = LibreOOPClient(accessToken: accessToken, site: site)


// Uploads one reading only. It uses the defaultstate,
// meaning that the algorithm will see this as the first ever reading from the sensor
// These parameters are assumed if you don't specify them:
//  oldState: LibreOOPDefaults.defaultState, sensorStartTimestamp: LibreOOPDefaults.sensorStartTimestamp,
//   sensorScanTimestamp: LibreOOPDefaults.sensorScanTimestamp, currentUtcOffset: LibreOOPDefaults.currentUtcOffset
remote.uploadReading(reading: patch ) { (response, success, errormessage) in
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
        remote.getStatusIntervalled(uuid: uuid, { (success, errormessage, oopCurrentValue, newState) in
            
            NSLog("GetStatusIntervalled returned with success?: \(success), error: \(errormessage), response: \(String(describing: oopCurrentValue))), newState: \(newState)")
            NSLog("GetStatusIntervalled  newState: \(newState)")
            
            if let oopCurrentValue = oopCurrentValue {
                
                /*NSLog("Decoded content")
                 NSLog("  Current trend: \(oopCurrentValue.currentTrend)")
                 NSLog("  Current bg: \(oopCurrentValue.currentBg)")
                 NSLog("  Current time: \(oopCurrentValue.currentTime)")
                 NSLog("  Serial Number: \(oopCurrentValue.serialNumber ?? "-")")
                 NSLog("  timeStamp: \(oopCurrentValue.timestamp)")
                 var i = 0
                 for historyValue in oopCurrentValue.historyValues {
                 NSLog(String(format: "    #%02d: time: \(historyValue.time), quality: \(historyValue.quality), bg: \(historyValue.bg)", i))
                 i += 1
                 }*/
            }
        })
    }
    
    
    
}

/*
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
let subfolder = "librereadings"
if let filescontents = LibreOOPClient.getLibreReadingsFromFolderContents(subfolder:subfolder) {
    
    let  readings = [
        LibreReadingResult(created: "2018-04-23T03:49:47.986Z", b64Contents: filescontents["reading1.txt"]!),
        LibreReadingResult(created: "2018-04-23T03:54:59.002Z", b64Contents: filescontents["reading2.txt"]!),
        LibreReadingResult(created: "2018-04-23T03:59:21.403Z", b64Contents: filescontents["reading3.txt"]!),
        LibreReadingResult(created: "2018-04-23T04:04:29.507Z", b64Contents: filescontents["reading4.txt"]!),
        LibreReadingResult(created: "2018-04-23T04:09:21.186Z", b64Contents: filescontents["reading5.txt"]!)
        
    ]
    
    if let res = remote.uploadDependantReadings(readings: readings) {
        print("got result:")
        res.forEach { (success, error, val,newstate) in
            if success{
                print(val?.currentBg ?? "")
            }
        }
    }
    
} else {
    print ("could not read files in subfolder \(subfolder)")
}

*/


//This semaphore wait is neccessary when running as a mac os cli program. Consider removing this in a GUI app
//it kinda works like python's input() or raw_input() in a cli program, except it doesn't accept input, ofcourse..
let sema = DispatchSemaphore( value: 0 )
sema.wait()







