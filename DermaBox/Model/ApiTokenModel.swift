//
//  ApiTokenModel.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2021/03/20.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import Foundation

struct ApiTokenModel: Codable {
    var status: Int?
    var msg: String?
    var body: ApiTokenBodyModel?
    var accessToken: String? {
        return body?.accessToken //?? ""
    }
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case msg = "msg"
        case body = "body"
    }
}

struct ApiTokenBodyModel: Codable  {
    var tokenType: String
    var accessToken: String
    var expiresIn: Int?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
    }
}
