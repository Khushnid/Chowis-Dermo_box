//
//  CustomerRespInfoModel.swift
//  DermaBox
//
//  Created by ~Akhtamov on 6/5/21.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import Foundation

//"ERROR CASE"
//"runtimeDate": "2021-06-04T20:04:29.5192265Z",
//    "error": true,
//    "responseMessage": "an error occurred"

//"SUCCESS CASE"
//    "runtimeDate": "2021-06-04T20:05:42.8971562Z",
//    "error": false,
//    "responseMessage": "ok"

struct CustomerRespInfoModel : Codable {
    var error: Bool?
    var responseMessage: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.error = try container.decodeIfPresent(Bool.self, forKey: .error) ?? false
        self.responseMessage = try container.decodeIfPresent(String.self, forKey: .responseMessage) ?? ""
    }
}

struct RequestBodyFormDataKeyvalue {
    var sKey: String
    var sValue : String
}
