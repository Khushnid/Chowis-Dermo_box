//
//  FFAModel.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2021/01/31.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import Foundation

//MARK: FFA Model
public struct FFAModel: Codable {
    var status: Int?
    var service: String?
    var error: String?
    var msg: String?
    var results: FFABodyModel?
    
    var pictureFilepaths: [String]? = [String]()
    var dateTime: Date?
    var userID: Int?
    var batchID: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case service = "service"
        case error = "error"
        case msg = "msg"
        case results = "body"
        
        case pictureFilepaths = "pictureFilepaths"
        case dateTime = "dateTime"
        case userID = "userID"
    }
}

struct FFABodyModel: Codable {
    var timeElapsed: String?
    var analysisData: FFAAnalysisDataModel?
    var pictureFilepaths: [String]? = [String]()
    var score: Int?
    var questionScores: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case timeElapsed = "total_time_elapsed"
        case analysisData = "analysis_data"
        
        case pictureFilepaths = "pictureFilepaths"
        case score = "score"
        case questionScores = "questionScores"
    }
}

struct FFAAnalysisDataModel: Codable {
    var spots: FFADataModel?
    var pores: FFADataModel?
    var darkcircles: FFADataModel?
    var wrinkles: FFADataModel?
    
    enum CodingKeys: String, CodingKey {
        case spots = "spots"
        case pores = "pores"
        case darkcircles = "darkcircles"
        case wrinkles = "wrinkles"
    }
}

struct FFADataModel: Codable {
    var timeElapsed: String?
    var algorithmId: Int?
    var analysisId: Int?
    var mask: FFAMaskModel?
    var values: FFAValueModel?
    var imageFileName: String?

    enum CodingKeys: String, CodingKey {
        case timeElapsed = "time_elapsed"
        case algorithmId = "algorithm_id"
        case analysisId = "analysis_id"
        case mask = "mask"
        case values = "values"
        case imageFileName = "imageFileName"
    }
}

struct FFAMaskModel: Codable {
    var url: String?
    var size: Int?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case size = "size"
    }
}

struct FFAValueModel: Codable {
    var score: Int?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case score = "score"
        case description = "description"
    }
}

struct FFARequestModel: Codable {
    var pictureFilepaths: [String]? = [String]()
    var userID: Int?
}

extension FFAModel {
    var poresScore: Int {
        guard let score = results?.analysisData?.pores?.values?.score else { return 0 }
        return score
    }
    var spotsScore: Int {
        guard let score = results?.analysisData?.spots?.values?.score else { return 0 }
        return score
    }
    var darkcirclesScore: Int {
        guard let score = results?.analysisData?.darkcircles?.values?.score else { return 0 }
        return score
    }
    var wrinklesScore: Int {
        guard let score = results?.analysisData?.wrinkles?.values?.score else { return 0 }
        return score
    }
    var overallScore: Int {
//        guard let score = results?.score else {
//            let averageDiagnoseResult = Utility.average(poresScore, wrinklesScore, spotsScore, darkcirclesScore)
//            let computedDiagnoseResult = (100 - averageDiagnoseResult) * 8
//            let computedQuestionnairePoint = Utility.sum(questionScores ?? [0]) * 2
//            return (Int(computedDiagnoseResult) + computedQuestionnairePoint) / 10
//        }
        return 33
    }
    var questionScores: [Int]? {
        guard let scores = results?.questionScores else { return nil }
        return scores
    }
    var originalPicturePaths: [String]? {
        guard let paths = pictureFilepaths ?? results?.pictureFilepaths else { return [String]() }
        return paths
    }
}
