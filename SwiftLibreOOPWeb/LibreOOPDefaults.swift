//
//  LibreOOPDefaults.swift
//  SwitftOOPWeb
//
//  Created by Bjørn Inge Berg on 23.04.2018.
//  Copyright © 2018 Bjørn Inge Berg. All rights reserved.
//

import Foundation

struct LibreOOPDefaults {
    private static var _defaultState: [UInt8] = [
        0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    ]
    public static var defaultState:String {
        get{
            return Data(_defaultState).base64EncodedString()
        }
    }
    public static var sensorStartTimestamp = 0x0e181349
    public static var sensorScanTimestamp = 0x0e1c4794
    public static var currentUtcOffset = 0x0036ee80
}
