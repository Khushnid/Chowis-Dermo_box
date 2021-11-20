//
//  BatchIDModel.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2021/03/20.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import Foundation

struct BatchIDModel: Codable {
    var status: Int?
    var msg: String?
    var body: BatchIDBodyModel?
    var batchID: Int? {
        return body?.batchID
    }
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case msg = "msg"
        case body = "body"
    }
}

struct BatchIDBodyModel: Codable {
    var batchID: Int

    enum CodingKeys: String, CodingKey {
        case batchID = "batch_id"
    }
}
