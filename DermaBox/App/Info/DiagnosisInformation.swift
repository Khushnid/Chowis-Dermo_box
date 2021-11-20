//
//  DiagnosisData.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/08/23.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import Foundation
import UIKit
import ChowisSDK

class DiagData {
    
    var originalPath: String = ""
    var analyzedPath: String = ""
    var threeDPath: String = ""
    var currentPath: String = ""
    var resultValue: Int = -1
    var isAnalyzed: Bool = false
    var isAnalyzedImage: Bool = true
    var isSelected: Bool = false
    var timeStamp: String = ""
    var wrinkleRect: CGRect = .zero
    var wrinkleUltraImageFile: String = ""
    var wrinkleFineImageFile: String = ""
    var wrinkleDeepImageFile: String = ""
    var wrinkleVeryDeepImageFile: String = ""
    var wrinkleUltraResultValue: Int = -1
    var wrinkleFineResultValue: Int = -1
    var wrinkleDeepResultValue: Int = -1
    var wrinkleVeryDeepResultValue: Int = -1
    
    init() {}
}

class DiagnosisInformation {

    static let shared = DiagnosisInformation()
    
    func resetAll() {
        
        self.poresImages.removeAll()
        self.wrinklesImages.removeAll()
        self.spotsImages.removeAll()
        self.impuritiesImages.removeAll()
        self.keratinImages.removeAll()
        self.skinSensitivityImages.removeAll()
        self.blackheadImages.removeAll()
        self.sebumUZoneimages.removeAll()
        self.sebumTZoneImages.removeAll()
        self.skinConditionsMoistureTZoneScores.removeAll()
        self.skinConditionsMoistureUZoneScores.removeAll()
        self.skinConditionsSebumTZoneScores.removeAll()
        self.skinConditionsSebumUZoneScores.removeAll()
        
        self.skinToneChinImage = DiagData()
        self.skinToneCheeckImage = DiagData()
        self.skinToneForeheadImage = DiagData()
        
        self.skinConditionsMoistureTZoneScore = -1
        self.skinConditionsMoistureUZoneScore = -1
        self.skinConditionsSebumTZoneScore = -1
        self.skinConditionsSebumUZoneScore = -1
        self.poresScore = -1
        self.spotsScore = -1
        self.wrinklesScore = -1
        self.impiritiesScore = -1
        self.keratinScore = -1
        self.skinSensitivityScore = -1
        self.blackheadScore = -1
        self.customerSkinScalColorType = kCWSkinScalpColorType_None
        self.customerEthnicity = kCWEthnicity_None
        self.customerGender = kCWGender_Female
    }
    
    var poresImages = [DiagData]()
    var spotsImages = [DiagData]()
    var wrinklesImages = [DiagData]()
    var impuritiesImages = [DiagData]()
    var keratinImages = [DiagData]()
    var skinSensitivityImages = [DiagData]()
    var blackheadImages = [DiagData]()
    var sebumUZoneimages = [DiagData]()
    var sebumTZoneImages = [DiagData]()
    
    var skinToneChinImage = DiagData()
    var skinToneCheeckImage = DiagData()
    var skinToneForeheadImage = DiagData()
    
    var ffaFrontImageName: String?
    var ffaLeftImageName: String?
    var ffaRightImageName: String?
    
    var skinConditionsMoistureTZoneScores = [Int]()
    var skinConditionsMoistureUZoneScores = [Int]()
    var skinConditionsSebumTZoneScores = [Int]()
    var skinConditionsSebumUZoneScores = [Int]()
    
    var skinConditionsMoistureTZoneScore: Int = -1
    var skinConditionsMoistureUZoneScore: Int = -1
    var skinConditionsSebumTZoneScore: Int = -1
    var skinConditionsSebumUZoneScore: Int = -1
    var poresScore: CGFloat = -1
    var spotsScore: CGFloat = -1
    var wrinklesScore: CGFloat = -1
    var impiritiesScore: CGFloat = -1
    var keratinScore: CGFloat = -1
    var skinSensitivityScore: CGFloat = -1
    var skinToneScore: CGFloat = -1
    var blackheadScore: CGFloat = -1
    
    var customerSkinScalColorType: CWSkinScalpColorType = kCWSkinScalpColorType_None
    var customerEthnicity: CWEthnicity = kCWEthnicity_None
    var customerGender: CWGender = kCWGender_Female
    var customerBirdthday: String = ""
}
