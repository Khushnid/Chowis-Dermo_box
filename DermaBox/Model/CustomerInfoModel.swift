//
//  CustomerInfoModel.swift
//  Chowis Analysis Skin 2
//
//  Created by ~Akhtamov on 4/21/21.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import Foundation

struct CustomerInfoModel : Codable {
    var error: Bool?
    var ID: Int?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var email: String?
    var birthDate: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.error = try container.decodeIfPresent(Bool.self, forKey: .error) ?? false
        self.ID = try container.decodeIfPresent(Int.self, forKey: .ID) ?? 0
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.birthDate = try container.decodeIfPresent(String.self, forKey: .birthDate) ?? ""
    }
}

