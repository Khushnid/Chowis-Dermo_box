//
//  CurrentUser.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2021/03/20.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import Foundation

class CurrentUser {
    static let shared = CurrentUser()
    var weather: OneCallWeatherModel?
    var ffaResult: FFAModel?
    var ffaRequest: FFARequestModel?
    var questionScores: [Int]?
    var batchID: Int = -1
    var tokenID: String = ""
    var isBluetoothNeeded: Bool = false
}
