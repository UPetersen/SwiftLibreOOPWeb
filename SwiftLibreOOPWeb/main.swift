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
var patch: [UInt8] = LibreOOPDefaults.TestPatchAlwaysReturning63;



//note that the accesstoken will be given to you by the libreoopweb admin
//let accessToken = "someName-FollowedByRandomNumberGivenToYouByLibreoopwebAdmin"
guard let accessToken = LibreOOPCredentials(file: "/SwiftLibreOOPWeb/LibreOOPAccessToken.txt").accessToken() else {
    print("Error: no acces token")
    abort()
}

/*
 Please see MoreExamples.swift for a more advanced version of this where you can specify callbacks and tweak parameters
 LibreUtils.GetParsedOOPResult is blocking and is therefore not suited for usage in gui apps (unless you run it in a background thread)
 
 */
LibreUtils.accessToken = accessToken

//patch[4] = UInt8(0x04)
var result  = LibreUtils.GetParsedOOPResult(patch: patch)

print("result? \(result)")



//This semaphore wait is neccessary when running as a mac os cli program. Consider removing this in a GUI app
//it kinda works like python's input() or raw_input() in a cli program, except it doesn't accept input, ofcourse..
let sema = DispatchSemaphore( value: 0 )
sema.wait()
