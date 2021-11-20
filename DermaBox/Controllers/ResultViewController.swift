//
//  ResultViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/09/06.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController, UIDocumentInteractionControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet var moistureView: UIView!
    @IBOutlet var graphView: UIView!
    @IBOutlet var spiderView: UIView!
    @IBOutlet var skinConditionsLabel: UILabel!
    @IBOutlet var skinConditonsResultLabel: UILabel!
    @IBOutlet var tZoneResultLabel: UILabel!
    @IBOutlet var uZoneResultLabel: UILabel!
    @IBOutlet var sebumHightLabel: UILabel!
    @IBOutlet var sebumLabel: UILabel!
    @IBOutlet var sebumLowLabel: UILabel!
    @IBOutlet var moistureDehydratedLabel: UILabel!
    @IBOutlet var moistureLabel: UILabel!
    @IBOutlet var moistureNormalLabel: UILabel!
    @IBOutlet var tZoneImageView: UIImageView!
    @IBOutlet var uZoneImageView: UIImageView!
    @IBOutlet var tZoneLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var tZoneBottomConstraint: NSLayoutConstraint!
    @IBOutlet var uZoneLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var uZoneBottomConstriaint: NSLayoutConstraint!
    @IBOutlet var sendAndCloseButton: UIButton!
    @IBOutlet var poresLabel: UILabel!
    @IBOutlet var spotsLabel: UILabel!
    @IBOutlet var wrinklesLabel: UILabel!
    @IBOutlet var impuritiesLabel: UILabel!
    @IBOutlet var keratinLabel: UILabel!
    @IBOutlet var poresGradientLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var poresGradientView: UIView!
    @IBOutlet var spotsGradientLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var spotsGradientView: UIView!
    @IBOutlet var wrinklesGradientLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var wrinklesGradientView: UIView!
    @IBOutlet var impuritiesGradientLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var impuritiesGradientView: UIView!
    @IBOutlet var keratinGradientLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var keratinGradientView: UIView!
    @IBOutlet var poresResultValueLabel: UILabel!
    @IBOutlet var spotsResultValueLabel: UILabel!
    @IBOutlet var wrinklesResultValueLabel: UILabel!
    @IBOutlet var impuritiesResultValueLabel: UILabel!
    @IBOutlet var keratinResultValueLabel: UILabel!
    @IBOutlet var poresResultDescriptionLabel: UIButton!
    @IBOutlet var spotsResultDescriptionLabel: UIButton!
    @IBOutlet var wrinklesResultDescriptionLabel: UIButton!
    @IBOutlet var impuritiesResultDescriptionLabel: UIButton!
    @IBOutlet var keratinResultDescriptionLabel: UIButton!
    @IBOutlet var moistureButton: UIButton!
    @IBOutlet var wrinklesButton: UIButton!
    @IBOutlet var poresButton: UIButton!
    @IBOutlet var impuritiesButton: UIButton!
    @IBOutlet var keratinButton: UIButton!
    @IBOutlet var spotsButton: UIButton!
    @IBOutlet var spiderViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var graphViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var moistureViewWidthConstraints: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var moistureGraphImageView: UIImageView!
    @IBOutlet var rightArrowButton: UIButton!
    @IBOutlet var leftArrowButton: UIButton!
    @IBOutlet var poresDotView: UIView!
    @IBOutlet var spotsDotView: UIView!
    @IBOutlet var keratinDotView: UIView!
    @IBOutlet var impuritiesDotView: UIView!
    @IBOutlet var wrinklesDotView: UIView!
    @IBOutlet var moistureDotView: UIView!
    @IBOutlet var TUZoneRightXConstraint: NSLayoutConstraint!
    @IBOutlet var poresDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var poresDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var moistureDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var moistureDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var wrinklesDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var wrinklesDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var impuritiesDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var impuritiesDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var keratinDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var keratinDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var spotsDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var spotsDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var spiderImageView: UIImageView!
    @IBOutlet var tZoneLabel: UILabel!
    @IBOutlet var uZoneLabel: UILabel!
    @IBOutlet var poresNormalLabel: UILabel!
    @IBOutlet var poresCautionLabel: UILabel!
    @IBOutlet var spotsNormalLabel: UILabel!
    @IBOutlet var spotsCautionLabel: UILabel!
    @IBOutlet var wrinklesNormalLabel: UILabel!
    @IBOutlet var wrinklesCautionLabel: UILabel!
    @IBOutlet var impuritiesNormalLabel: UILabel!
    @IBOutlet var impuritiesCautionLabel: UILabel!
    @IBOutlet var keratinNormalLabel: UILabel!
    @IBOutlet var keratinCautionLabel: UILabel!
    @IBOutlet var optimumLabel: UILabel!
    @IBOutlet var payAttentionToCareLabel: UILabel!
    @IBOutlet var needToCareLabel: UILabel!
    @IBOutlet var intensiveCareNeededLabel: UILabel!
    @IBOutlet var uZoneLeadingDottedView: UIView!
    @IBOutlet var uZoneBottomDottedView: UIView!
    @IBOutlet var tZoneLeadingDottedView: UIView!
    @IBOutlet var tZoneBottomDottedView: UIView!
    @IBOutlet var expertLabel: UILabel!
    @IBOutlet var skinSensitivityLabel: UILabel!
    @IBOutlet var skinSensitivityNormalLabel: UILabel!
    @IBOutlet var skinSensitivityCautionLabel: UILabel!
    @IBOutlet var skinSensitivityResultValueLabel: UILabel!
    @IBOutlet var skinSensitivityResultDescriptionButton: UIButton!
    @IBOutlet var skinSensitivityGradientLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var blackheadLabel: UILabel!
    @IBOutlet var blackheadNormalLabel: UILabel!
    @IBOutlet var blackheadCautionLabel: UILabel!
    @IBOutlet var blackheadResultValueLabel: UILabel!
    @IBOutlet var blackheadResultDescriptionButton: UIButton!
    @IBOutlet var blackheadGradientLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var skinToneLabel: UILabel!
    @IBOutlet var skinToneNormalLabel: UILabel!
    @IBOutlet var skinToneCautionLabel: UILabel!
    @IBOutlet var skinToneResultValueLabel: UILabel!
    @IBOutlet var skinToneResultDescriptionButton: UIButton!
    @IBOutlet var skinToneGradientLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var expertResultView: UIView!
    @IBOutlet var skinToneView: UIView!
    @IBOutlet var expertSpiderView: UIView!
    @IBOutlet var expertSpiderImageView: UIImageView!
    @IBOutlet var expertPoresDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var expertPoresDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var expertMoistureDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var expertMoistureDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var expertWrinklesDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var expertWrinklesDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var expertImpuritiesDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var expertImpuritiesDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var exprtKeratinDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var expertKeratinDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var expertSpotsDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var expertSpotsDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var expertBlackheadDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var expertBlackheadDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var expertSkinSensitivityDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var expertSkinSensitivityDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var expertSebumDotViewCenterXConstraints: NSLayoutConstraint!
    @IBOutlet var expertSebumDotViewCenterYConstraints: NSLayoutConstraint!
    @IBOutlet var expertPoresDotView: UIView!
    @IBOutlet var expertSpotsDotView: UIView!
    @IBOutlet var expertKeratinDotView: UIView!
    @IBOutlet var expertImpuritiesDotView: UIView!
    @IBOutlet var expertWrinklesDotView: UIView!
    @IBOutlet var expertMoistureDotView: UIView!
    @IBOutlet var expertSebumDotView: UIView!
    @IBOutlet var expertSkinSensitivityDotView: UIView!
    @IBOutlet var expertBlackheadDotView: UIView!
    @IBOutlet var expertMoistureButton: UIButton!
    @IBOutlet var expertWrinklesButton: UIButton!
    @IBOutlet var expertPoresButton: UIButton!
    @IBOutlet var expertImpuritiesButton: UIButton!
    @IBOutlet var expertKeratinButton: UIButton!
    @IBOutlet var expertSpotsButton: UIButton!
    @IBOutlet var expertBlackheadButton: UIButton!
    @IBOutlet var expertSebumButton: UIButton!
    @IBOutlet var expertSkinSensitivityButton: UIButton!
    @IBOutlet var expertGraphViewWidthConstratin: NSLayoutConstraint!
    @IBOutlet var skinToneWidthConstraint: NSLayoutConstraint!
    @IBOutlet var expertSpiderViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var expertOptimumLabel: UILabel!
    @IBOutlet var expertPayAttentionToCareLabel: UILabel!
    @IBOutlet var expertNeedToCareLabel: UILabel!
    @IBOutlet var expertIntensiveCareNeededLabel: UILabel!
    @IBOutlet var skinSensitivityGradientView: UIView!
    @IBOutlet var blackheadGradientView: UIView!
    @IBOutlet var skinToneGradientView: UIView!
    
    @IBOutlet var moistureGraphHolderView: UIView!
    @IBOutlet var TUZOneStackView: UIStackView!
    @IBOutlet var UZoneStackView: UIStackView!
    @IBOutlet var TZoneStackView: UIStackView!
    @IBOutlet var UTZonesBackgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    //MARK: - Properties
    var isSendingSucceed: Bool = false
    var isMoistureAvailable: Bool = false
    var spiderRadius: CGFloat = 0
    var isExpertVersionAvailable = false
    var pdfDATA = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DiagnosisInformation.shared.skinSensitivityImages.count > 0 || DiagnosisInformation.shared.blackheadImages.count > 0 || DiagnosisInformation.shared.skinToneScore != -1 {
            
            self.isExpertVersionAvailable = true
        }
        
        self.spiderRadius = self.spiderImageView.frame.size.height / 2 * 226.0 / 242.0
        self.uZoneImageView.isHidden = true
        self.tZoneImageView.isHidden = true
        self.tZoneLeadingConstraint.constant = -10
        self.tZoneBottomConstraint.constant = 10
        self.uZoneLeadingConstraint.constant = -10
        self.uZoneBottomConstriaint.constant = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.localizeStrings()
    }
    
    fileprivate func localizeStrings() {
        
        self.skinConditionsLabel.text = "SKIN CONDITIONS".localized
        self.tZoneLabel.text = "T Zone".localized
        self.uZoneLabel.text = "U Zone".localized
        self.sebumHightLabel.text = "High".localized
        self.sebumLabel.text = "Sebum".localized
        self.sebumLowLabel.text = "Low".localized
        self.moistureDehydratedLabel.text = "Dehydrated".localized
        self.moistureLabel.text = "Moisture".localized
        self.moistureNormalLabel.text = "Normal".localized
        self.poresLabel.text = "Pores".localized
        self.spotsLabel.text = "Spots".localized
        self.wrinklesLabel.text = "Wrinkles".localized
        self.impuritiesLabel.text = "Impurities".localized
        self.keratinLabel.text = "Keratin".localized
        self.skinSensitivityLabel.text = "Skin Sensitivity".localized
        self.blackheadLabel.text = "Blackhead".localized
        self.skinToneLabel.text = "Skin Tone".localized
        self.expertLabel.text = "EXPERT".localized
        self.titleLabel.text = "Results".localized
        for label in [
            self.poresNormalLabel,
            self.spotsNormalLabel,
            self.wrinklesNormalLabel,
            self.impuritiesNormalLabel,
            self.keratinNormalLabel,
            self.skinSensitivityNormalLabel,
            self.blackheadNormalLabel,
            self.skinToneNormalLabel] {
            
            label?.text = "Normal".localized
        }
  
        for label in [
            self.poresCautionLabel,
            self.spotsCautionLabel,
            self.wrinklesCautionLabel,
            self.impuritiesCautionLabel,
            self.keratinCautionLabel,
            self.skinSensitivityCautionLabel,
            self.blackheadCautionLabel,
            self.skinToneCautionLabel] {
            
            label?.text = "Caution".localized
        }
        
        self.moistureButton.setTitle("Moisture".localized, for: .normal)
        self.wrinklesButton.setTitle("Wrinkles".localized, for: .normal)
        self.impuritiesButton.setTitle("Impurities".localized, for: .normal)
        self.keratinButton.setTitle("Keratin".localized, for: .normal)
        self.spotsButton.setTitle("Spots".localized, for: .normal)
        self.poresButton.setTitle("Pores".localized, for: .normal)
        
        self.expertMoistureButton.setTitle("Moisture".localized, for: .normal)
        self.expertWrinklesButton.setTitle("Wrinkles".localized, for: .normal)
        self.expertImpuritiesButton.setTitle("Impurities".localized, for: .normal)
        self.expertKeratinButton.setTitle("Keratin".localized, for: .normal)
        self.expertSpotsButton.setTitle("Spots".localized, for: .normal)
        self.expertPoresButton.setTitle("Pores".localized, for: .normal)
        self.expertSkinSensitivityButton.setTitle("Skin Sensitivity".localized, for: .normal)
        self.expertBlackheadButton.setTitle("Blackhead".localized, for: .normal)
        self.expertSebumButton.setTitle("Sebum".localized, for: .normal)
        
        self.optimumLabel.text = "Optimum".localized
        self.payAttentionToCareLabel.text = "Pay attention to care".localized
        self.needToCareLabel.text = "Need to care".localized
        self.intensiveCareNeededLabel.text = "Intensive care needed".localized
        
        self.expertOptimumLabel.text = "Optimum".localized
        self.expertPayAttentionToCareLabel.text = "Pay attention to care".localized
        self.expertNeedToCareLabel.text = "Need to care".localized
        self.expertIntensiveCareNeededLabel.text = "Intensive care needed".localized
        
        self.sendAndCloseButton.setTitle("Send".localized, for: .normal)
    }
    
    fileprivate func drawProPoresDot() {
        
        if DiagnosisInformation.shared.poresImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.poresImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            self.poresGradientLeadingConstraint.constant = self.poresGradientView.frame.size.width / 100 * CGFloat(average)
            self.poresResultValueLabel.text = "\(average)"
            self.poresResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .pores), for: .normal)
            
            self.poresDotView.isHidden = false
            self.poresDotViewCenterXConstraints.constant = -spiderRadius / 100 * CGFloat(average)
            
            if average >= 33 {
                
                self.poresButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.poresGradientLeadingConstraint.constant = 0
            self.poresResultValueLabel.text = ""
            self.poresResultDescriptionLabel.isHidden = true
            self.poresDotView.isHidden = true
        }
        
        self.drawExpertPoresDot()
    }
    
    fileprivate func drawExpertPoresDot() {
        
        if DiagnosisInformation.shared.poresImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.poresImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            let poresScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 80.0)) * poresScore
            let yvalue = sqrt((poresScore * poresScore) - (xValue * xValue))
            self.expertPoresDotViewCenterXConstraints.constant = -xValue
            self.expertPoresDotViewCenterYConstraints.constant = -yvalue
            
            self.poresGradientLeadingConstraint.constant = self.poresGradientView.frame.size.width / 100 * CGFloat(average)
            self.poresResultValueLabel.text = "\(average)"
            self.poresResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .pores), for: .normal)
            
            self.expertPoresDotView.isHidden = false
            
            if average >= 33 {
                
                self.expertPoresButton.setTitleColor(.red, for: .normal)
            }
            
            
        } else {
            
            self.poresGradientLeadingConstraint.constant = 0
            self.poresResultValueLabel.text = ""
            self.poresResultDescriptionLabel.isHidden = true
            self.poresDotView.isHidden = true
        }
    }
    
    fileprivate func drawProSpotsDot() {
        
        if DiagnosisInformation.shared.spotsImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.spotsImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            self.spotsGradientLeadingConstraint.constant = self.spotsGradientView.frame.size.width / 100 * CGFloat(average)
            self.spotsResultValueLabel.text = "\(average)"
            self.spotsResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .spots), for: .normal)
            let spotsScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 30.0)) * spotsScore
            let yvalue = sqrt((spotsScore * spotsScore) - (xValue * xValue))
            self.spotsDotViewCenterXConstraints.constant = -xValue
            self.spotsDotViewCenterYConstraints.constant = yvalue
            self.spotsDotView.isHidden = false
            
            if average >= 41 {
                
                self.spotsButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.spotsGradientLeadingConstraint.constant = 0
            self.spotsResultValueLabel.text = ""
            self.spotsResultDescriptionLabel.isHidden = true
            self.spotsDotView.isHidden = true
        }
        
        self.drawExpertSpotsDot()
    }
    
    fileprivate func drawExpertSpotsDot() {
        
        if DiagnosisInformation.shared.spotsImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.spotsImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            self.spotsGradientLeadingConstraint.constant = self.spotsGradientView.frame.size.width / 100 * CGFloat(average)
            self.spotsResultValueLabel.text = "\(average)"
            self.spotsResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .spots), for: .normal)
            let spotsScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 60.0)) * spotsScore
            let yvalue = sqrt((spotsScore * spotsScore) - (xValue * xValue))
            self.expertSpotsDotViewCenterXConstraints.constant = -xValue
            self.expertSpotsDotViewCenterYConstraints.constant = yvalue
            self.expertSpotsDotView.isHidden = false
            
            if average >= 41 {
                
                self.expertSpotsButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.spotsGradientLeadingConstraint.constant = 0
            self.spotsResultValueLabel.text = ""
            self.spotsResultDescriptionLabel.isHidden = true
            self.expertSpotsDotView.isHidden = true
        }
    }
    
    fileprivate func drawProWrinklesDot() {
        
        if DiagnosisInformation.shared.wrinklesImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.wrinklesImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            self.wrinklesGradientLeadingConstraint.constant = self.wrinklesGradientView.frame.size.width / 100 * CGFloat(average)
            self.wrinklesResultValueLabel.text = "\(average)"
            self.wrinklesResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .wrinkles), for: .normal)
            
            let wrinklesScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 30.0)) * wrinklesScore
            let yvalue = sqrt((wrinklesScore * wrinklesScore) - (xValue * xValue))
            self.wrinklesDotViewCenterXConstraints.constant = xValue
            self.wrinklesDotViewCenterYConstraints.constant = -yvalue
            self.wrinklesDotView.isHidden = false
            
            if average >= 46 {
                
                self.wrinklesButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.wrinklesGradientLeadingConstraint.constant = 0
            self.wrinklesResultValueLabel.text = ""
            self.wrinklesResultDescriptionLabel.isHidden = true
            self.wrinklesDotView.isHidden = true
        }
        
        self.drawExpertWrinklesDot()
    }
    
    fileprivate func drawExpertWrinklesDot() {
        
        if DiagnosisInformation.shared.wrinklesImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.wrinklesImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            self.wrinklesGradientLeadingConstraint.constant = self.wrinklesGradientView.frame.size.width / 100 * CGFloat(average)
            self.wrinklesResultValueLabel.text = "\(average)"
            self.wrinklesResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .wrinkles), for: .normal)
            
            let wrinklesScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 60.0)) * wrinklesScore
            let yvalue = sqrt((wrinklesScore * wrinklesScore) - (xValue * xValue))
            self.expertWrinklesDotViewCenterXConstraints.constant = xValue
            self.expertWrinklesDotViewCenterYConstraints.constant = yvalue
            self.expertWrinklesDotView.isHidden = false
            
            if average >= 46 {
                
                self.expertWrinklesButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.wrinklesGradientLeadingConstraint.constant = 0
            self.wrinklesResultValueLabel.text = ""
            self.wrinklesResultDescriptionLabel.isHidden = true
            self.expertWrinklesDotView.isHidden = true
        }
    }
    
    fileprivate func drawProImpuritiesDot() {
        
        if DiagnosisInformation.shared.impuritiesImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.impuritiesImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            self.impuritiesGradientLeadingConstraint.constant = self.impuritiesGradientView.frame.size.width / 100 * CGFloat(average)
            self.impuritiesResultValueLabel.text = "\(average)"
            self.impuritiesResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .impurities), for: .normal)
            
            self.impuritiesDotView.isHidden = false
            self.impuritiesDotViewCenterXConstraints.constant = spiderRadius / 100 * CGFloat(average)
            
            if average >= 24 {
                
                self.impuritiesButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.impuritiesGradientLeadingConstraint.constant = 0
            self.impuritiesResultValueLabel.text = ""
            self.impuritiesResultDescriptionLabel.isHidden = true
            self.impuritiesDotView.isHidden = true
        }
        
        self.drawExpertImpuritiesDot()
    }
    
    fileprivate func drawExpertImpuritiesDot() {
        
        if DiagnosisInformation.shared.impuritiesImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.impuritiesImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            self.impuritiesGradientLeadingConstraint.constant = self.impuritiesGradientView.frame.size.width / 100 * CGFloat(average)
            self.impuritiesResultValueLabel.text = "\(average)"
            self.impuritiesResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .impurities), for: .normal)
            
            let impuritiesScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 20.0)) * impuritiesScore
            let yvalue = sqrt((impuritiesScore * impuritiesScore) - (xValue * xValue))
            self.expertImpuritiesDotViewCenterXConstraints.constant = xValue
            self.expertImpuritiesDotViewCenterYConstraints.constant = yvalue
            
            self.expertImpuritiesDotView.isHidden = false
            
            if average >= 24 {
                
                self.expertImpuritiesButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.impuritiesGradientLeadingConstraint.constant = 0
            self.impuritiesResultValueLabel.text = ""
            self.impuritiesResultDescriptionLabel.isHidden = true
            self.expertImpuritiesDotView.isHidden = true
        }
    }
    
    fileprivate func drawProKeratinDot() {
        
        if DiagnosisInformation.shared.keratinImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.keratinImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            var average = value/count
            
            if average > 100 {
                average = 100
            }
            self.keratinGradientLeadingConstraint.constant = self.keratinGradientView.frame.size.width / 100 * CGFloat(average)
            self.keratinResultValueLabel.text = "\(average)"
            self.keratinResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .keratin), for: .normal)
            
            let keratinScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 30.0)) * keratinScore
            let yvalue = sqrt((keratinScore * keratinScore) - (xValue * xValue))
            self.keratinDotViewCenterXConstraints.constant = xValue
            self.keratinDotViewCenterYConstraints.constant = yvalue
            self.keratinDotView.isHidden = false
            
            if average >= 23 {
                
                self.keratinButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.keratinGradientLeadingConstraint.constant = 0
            self.keratinResultValueLabel.text = ""
            self.keratinResultDescriptionLabel.isHidden = true
            self.keratinDotView.isHidden = true
        }
        
        self.drawExpertKeratinDot()
    }
    
    fileprivate func drawExpertKeratinDot() {
        
        if DiagnosisInformation.shared.keratinImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.keratinImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            var average = value/count
            if average > 100 {
                average = 100
            }
            self.keratinGradientLeadingConstraint.constant = self.keratinGradientView.frame.size.width / 100 * CGFloat(average)
            self.keratinResultValueLabel.text = "\(average)"
            self.keratinResultDescriptionLabel.setTitle(self.getDiagnosisDescription(withValue: average, mode: .keratin), for: .normal)
            
            let keratinScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 20.0)) * keratinScore
            let yvalue = sqrt((keratinScore * keratinScore) - (xValue * xValue))
            self.exprtKeratinDotViewCenterXConstraints.constant = -xValue
            self.expertKeratinDotViewCenterYConstraints.constant = yvalue
            self.expertKeratinDotView.isHidden = false
            
            if average >= 23 {
                
                self.expertKeratinButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.keratinGradientLeadingConstraint.constant = 0
            self.keratinResultValueLabel.text = ""
            self.keratinResultDescriptionLabel.isHidden = true
            self.expertKeratinDotView.isHidden = true
        }
    }
    
    fileprivate func drawProMoistureDot() {
        
        if DiagnosisInformation.shared.skinConditionsMoistureTZoneScore >= 0 && DiagnosisInformation.shared.skinConditionsMoistureUZoneScore >= 0 {
            
            let average = (DiagnosisInformation.shared.skinConditionsMoistureTZoneScore + DiagnosisInformation.shared.skinConditionsMoistureUZoneScore) / 2
            
            let moistureScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 30.0)) * moistureScore
            let yvalue = sqrt((moistureScore * moistureScore) - (xValue * xValue))
            self.moistureDotViewCenterXConstraints.constant = -xValue
            self.moistureDotViewCenterYConstraints.constant = -yvalue
            self.moistureDotView.isHidden = false
            
            if average >= 76 {
                
                self.moistureButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.moistureDotView.isHidden = true
        }
        
        self.drawExpertMoistureDot()
    }
    
    fileprivate func drawExpertMoistureDot() {
        
        if DiagnosisInformation.shared.skinConditionsMoistureTZoneScore >= 0 && DiagnosisInformation.shared.skinConditionsMoistureUZoneScore >= 0 {
            
            let average = (DiagnosisInformation.shared.skinConditionsMoistureTZoneScore + DiagnosisInformation.shared.skinConditionsMoistureUZoneScore) / 2
            
            let moistureScore = self.spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(self.sinFromDegrees(degrees: 40.0)) * moistureScore
            let yvalue = sqrt((moistureScore * moistureScore) - (xValue * xValue))
            self.expertMoistureDotViewCenterXConstraints.constant = -xValue
            self.expertMoistureDotViewCenterYConstraints.constant = -yvalue
            self.expertMoistureDotView.isHidden = false
            
            if average >= 76 {
                
                self.expertMoistureButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.expertMoistureDotView.isHidden = true
        }
    }
    
    fileprivate func drawExpertSkinSensitivityDot() {
        
        if DiagnosisInformation.shared.skinSensitivityImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.skinSensitivityImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            self.skinSensitivityGradientLeadingConstraint.constant = self.skinSensitivityGradientView.frame.size.width / 100 * CGFloat(average)
            self.skinSensitivityResultValueLabel.text = "\(average)"
            self.skinSensitivityResultDescriptionButton.setTitle(self.getDiagnosisDescription(withValue: average, mode: .skinSensitivity), for: .normal)
            
            let skinSensitivityScore = spiderRadius * CGFloat(average) / 100
            self.expertSkinSensitivityDotViewCenterYConstraints.constant = -skinSensitivityScore
            self.expertSkinSensitivityDotView.isHidden = false

            if average >= 76 {

                self.expertSkinSensitivityButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.skinSensitivityGradientLeadingConstraint.constant = 0
            self.skinSensitivityResultValueLabel.text = ""
            self.skinSensitivityResultDescriptionButton.isHidden = true
            self.expertSkinSensitivityDotView.isHidden = true
        }
    }
    
    fileprivate func drawExpertBackheadDot() {
        
        if DiagnosisInformation.shared.blackheadImages.count > 0 {
            
            var value = 0
            var count = 0
            
            DiagnosisInformation.shared.blackheadImages.forEach { (diag) in
                
                if diag.resultValue != -1 {
                    
                    value += diag.resultValue
                    count += 1
                }
            }
            
            if count == 0 {
                
                return
            }
            
            let average = value/count
            self.blackheadGradientLeadingConstraint.constant = self.blackheadGradientView.frame.size.width / 100 * CGFloat(average)
            self.blackheadResultValueLabel.text = "\(average)"
            self.blackheadResultDescriptionButton.setTitle(self.getDiagnosisDescription(withValue: average, mode: .blackhead), for: .normal)
            
            let blackheadScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 30.0)) * blackheadScore
            let yvalue = sqrt((blackheadScore * blackheadScore) - (xValue * xValue))
            self.expertBlackheadDotViewCenterXConstraints.constant = xValue
            self.expertBlackheadDotViewCenterYConstraints.constant = -yvalue
            self.expertBlackheadDotView.isHidden = false

            if average >= 76 {

                self.expertBlackheadButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.blackheadGradientLeadingConstraint.constant = 0
            self.blackheadResultValueLabel.text = ""
            self.blackheadResultDescriptionButton.isHidden = true
            self.expertBlackheadDotView.isHidden = true
        }
    }
    
    fileprivate func drawExpertSebumDot() {
        
        if DiagnosisInformation.shared.skinConditionsSebumTZoneScore >= 0 && DiagnosisInformation.shared.skinConditionsSebumUZoneScore >= 0 {
            
            let average = (DiagnosisInformation.shared.skinConditionsSebumTZoneScore + DiagnosisInformation.shared.skinConditionsSebumUZoneScore) / 2
            
            let sebumScore = spiderRadius * CGFloat(average) / 100
            let xValue = CGFloat(sinFromDegrees(degrees: 40.0)) * sebumScore
            let yvalue = sqrt((sebumScore * sebumScore) - (xValue * xValue))
            self.expertSebumDotViewCenterXConstraints.constant = xValue
            self.expertSebumDotViewCenterYConstraints.constant = -yvalue
            self.expertSebumDotView.isHidden = false

            if average >= 76 {

                self.expertSebumButton.setTitleColor(.red, for: .normal)
            }
            
        } else {
            
            self.expertSebumDotView.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        self.spiderRadius = self.spiderImageView.frame.size.height / 2 * 226.0 / 242.0
        
        for label in [
            self.poresResultDescriptionLabel,
            self.wrinklesResultDescriptionLabel,
            self.impuritiesResultDescriptionLabel,
            self.keratinResultDescriptionLabel,
            self.spotsResultDescriptionLabel,
            self.skinSensitivityResultDescriptionButton,
            self.blackheadResultDescriptionButton,
            self.skinToneResultDescriptionButton,
            self.poresResultValueLabel,
            self.spotsResultValueLabel,
            self.wrinklesResultValueLabel,
            self.impuritiesResultValueLabel,
            self.keratinResultValueLabel
        ] {
            
            label?.layer.cornerRadius = 4
        }
        
        for view in [
            self.poresDotView,
            self.wrinklesDotView,
            self.impuritiesDotView,
            self.keratinDotView,
            self.spotsDotView,
            self.moistureDotView,
            self.expertPoresDotView,
            self.expertWrinklesDotView,
            self.expertImpuritiesDotView,
            self.expertKeratinDotView,
            self.expertSpotsDotView,
            self.expertMoistureDotView,
            self.expertSkinSensitivityDotView,
            self.expertBlackheadDotView,
            self.expertSebumDotView] {
            
            view?.layer.cornerRadius = (view?.frame.size.height ?? 0) / 2.3
            view?.isHidden = true
        }
        
        self.sendAndCloseButton.layer.cornerRadius = self.sendAndCloseButton.frame.size.height / 2
        self.sendAndCloseButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.sendAndCloseButton.frame.size.height / 2)
        self.moistureViewWidthConstraints.constant = self.scrollView.frame.size.width
        self.graphViewWidthConstraint.constant = self.scrollView.frame.size.width
        self.spiderViewWidthConstraint.constant = self.scrollView.frame.size.width
        self.skinToneWidthConstraint.constant = self.scrollView.frame.size.width
        self.expertSpiderViewWidthConstraint.constant = self.scrollView.frame.size.width
        self.expertGraphViewWidthConstratin.constant = self.scrollView.frame.size.width
        
        if self.isExpertVersionAvailable {
            
            self.spiderView.isHidden = true
            self.expertSpiderView.isHidden = false
            self.expertResultView.isHidden = false
            
            if DiagnosisInformation.shared.skinToneScore == -1 {
                
                self.skinToneView.isHidden = true
                
            } else {
                
                self.skinToneView.isHidden = false
            }
            
        } else {
            
            self.skinToneView.isHidden = true
            self.spiderView.isHidden = false
            self.expertSpiderView.isHidden = true
            self.expertResultView.isHidden = true
        }
        
        if DiagnosisInformation.shared.skinConditionsMoistureTZoneScore == -1 && DiagnosisInformation.shared.skinConditionsMoistureUZoneScore == -1 && DiagnosisInformation.shared.skinConditionsSebumTZoneScore == -1 && DiagnosisInformation.shared.skinConditionsSebumUZoneScore == -1 {
            
            self.moistureView.isHidden = true
            
        } else {
            
            self.isMoistureAvailable = true
            self.tZoneLeadingConstraint.constant = moistureGraphImageView.frame.size.width / 100 * CGFloat(DiagnosisInformation.shared.skinConditionsMoistureTZoneScore) - 10
            self.tZoneBottomConstraint.constant = -moistureGraphImageView.frame.size.width / 100 * CGFloat(DiagnosisInformation.shared.skinConditionsSebumTZoneScore) + 10
            self.uZoneLeadingConstraint.constant = moistureGraphImageView.frame.size.width / 100 * CGFloat(DiagnosisInformation.shared.skinConditionsMoistureUZoneScore) - 10
            self.uZoneBottomConstriaint.constant = -moistureGraphImageView.frame.size.width / 100 * CGFloat(DiagnosisInformation.shared.skinConditionsSebumUZoneScore) + 10
            
            self.uZoneResultLabel.text = Util.shared.getDescriptionShineMoistureValue(moistureValue: DiagnosisInformation.shared.skinConditionsMoistureUZoneScore, oilValue: DiagnosisInformation.shared.skinConditionsSebumUZoneScore)
            self.tZoneResultLabel.text = Util.shared.getDescriptionShineMoistureValue(moistureValue: DiagnosisInformation.shared.skinConditionsMoistureTZoneScore, oilValue: DiagnosisInformation.shared.skinConditionsSebumTZoneScore)
            
            self.skinConditonsResultLabel.text = Util.shared.calcSkinTypeWithValueT(valueT: DiagnosisInformation.shared.skinConditionsSebumTZoneScore, U: DiagnosisInformation.shared.skinConditionsSebumUZoneScore)
            self.tZoneImageView.isHidden = false
            self.uZoneImageView.isHidden = false
            
            self.sebumHightLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            self.sebumLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            self.sebumLowLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        }
        
        
        self.drawProPoresDot()
        self.drawProSpotsDot()
        self.drawProWrinklesDot()
        self.drawProImpuritiesDot()
        self.drawProKeratinDot()
        self.drawProMoistureDot()
        self.drawExpertSkinSensitivityDot()
        self.drawExpertBackheadDot()
        self.drawExpertSebumDot()
        
        let lan = defaults.object(forKey: CURRENT_LANGUAGE) as? String ?? ""
        if lan == "he" {
            TUZoneRightXConstraint.constant = 20
            UTZonesBackgroundImage.image = UIImage(imageLiteralResourceName: "explain")
            TZoneStackView.removeArrangedSubview(self.tZoneLabel)
            TZoneStackView.setNeedsLayout()
            TZoneStackView.layoutIfNeeded()
            TZoneStackView.insertArrangedSubview(tZoneLabel, at: 1)
            TZoneStackView.setNeedsLayout()
            UZoneStackView.removeArrangedSubview(self.uZoneLabel)
            UZoneStackView.setNeedsLayout()
            UZoneStackView.layoutIfNeeded()
            UZoneStackView.insertArrangedSubview(uZoneLabel, at: 1)
            UZoneStackView.setNeedsLayout()
        } else {
            TUZoneRightXConstraint.constant = -20
            UTZonesBackgroundImage.image = UIImage(imageLiteralResourceName: "explain-reversed")
            TZoneStackView.removeArrangedSubview(self.tZoneLabel)
            TZoneStackView.setNeedsLayout()
            TZoneStackView.layoutIfNeeded()
            TZoneStackView.insertArrangedSubview(tZoneLabel, at: 0)
            TZoneStackView.setNeedsLayout()
            UZoneStackView.removeArrangedSubview(self.uZoneLabel)
            UZoneStackView.setNeedsLayout()
            UZoneStackView.layoutIfNeeded()
            UZoneStackView.insertArrangedSubview(uZoneLabel, at: 0)
            UZoneStackView.setNeedsLayout()
        }
    }
    
    func sinFromDegrees(degrees: Double) -> Double {
        
        return __sinpi(degrees/180.0)
    }
    
    @IBAction func leftArrowButtonPressed(_ sender: Any) {
        let page = (self.scrollView?.contentOffset.x ?? 0) / self.scrollView.frame.size.width - 1
        let pageX = page * self.scrollView.frame.size.width
        let frame = CGRect(x: pageX, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
        self.scrollView.scrollRectToVisible(frame, animated: true)
        if page == 0
        {  leftArrowButton.isHidden = true  }
        else
        {  leftArrowButton.isHidden = false  }
    }
    
    @IBAction func rightArrowButtonPressed(_ sender: Any) {
        let page = (self.scrollView?.contentOffset.x ?? 0) / self.scrollView.frame.size.width + 1
        let pageX = page * self.scrollView.frame.size.width
        let frame = CGRect(x: pageX, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
        self.scrollView.scrollRectToVisible(frame, animated: true)
        if page == 0
        {  leftArrowButton.isHidden = true  }
        else
        {  leftArrowButton.isHidden = false  }
    }
    
    @IBAction func sendAndCloseButtonPressed(_ sender: Any) {
        
        let name = defaults.value(forKey: USER_FIRST_NAME) as? String ?? ""
        let surname = defaults.value(forKey: USER_LAST_NAME) as? String ?? ""
        let fullname = "\(name) \(surname)"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateNow = formatter.string(from: date)
        let graphImage : UIImage = graphView.asImage()
        let spiderImage : UIImage = spiderView.asImage()
        let moistureImage : UIImage = moistureGraphHolderView.asImage()
        let TUZoneImage : UIImage = TUZOneStackView.asImage()
        let pdfCreator = PDFCreator(name: fullname, date: dateNow, graph: graphImage, spider: spiderImage, moisture: moistureImage, TUZone: TUZoneImage)
        ModalController.shared.presentPDFResultPopupViewController(with: pdfCreator.createFlyer(), delegate: self, presentingViewController: self)
    }
    
    @IBAction func unwindToFirstViewController(_ sender: UIStoryboardSegue) {
            
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}

extension ResultViewController: PDFResultPopupViewControllerDelegate {
    
    func didSelectPDFResultViewControllerLeftButtonPressed() {
        let pdfFileName : String = "\(defaults.value(forKey: USER_FIRST_NAME) as? String ?? "")_Results"
        let customerID : Int = defaults.value(forKey: USER_ID) as? Int ?? 0
        let fullname = "\(defaults.value(forKey: USER_FIRST_NAME) as? String ?? "") \(defaults.value(forKey: USER_LAST_NAME) as? String ?? "")"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateNow = formatter.string(from: date)
        let pdfCreator = PDFCreator(name: fullname, date: dateNow, graph: graphView.asImage(), spider: spiderView.asImage(), moisture: moistureGraphHolderView.asImage(), TUZone: TUZOneStackView.asImage())
        let pdfData = pdfCreator.createFlyer()
        let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
        vc.completionWithItemsHandler = { [self](activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in

            if !completed {
                return
            }
            self.showActivityIndicator()
            sendToDBPisgaServer(pdf: pdfData, id: customerID, fileName: pdfFileName)
            pdfDATA = pdfData
        }
        present(vc, animated: true, completion: nil)
    }
    
    func sendToDBPisgaServer(pdf: Data?, id: Int, fileName: String) {
        self.isSendingSucceed = false
        ServiceManager.shared.Doc(docData: pdf, id: id, fileName: fileName) { (resp, error) in
            self.hideActivityIndicator()
            if let error = error {
                print("ERROR: \(error)")
                return
                    
                    self.showOneButtonMessage(title: "NOTICE!".localized, message: "Sending Failed".localized, buttonText: "RETRY".localized, mainIcon: #imageLiteral(resourceName: "failedIcon"))
            }
            if let resp = resp {
                if resp.error == false {
                    self.isSendingSucceed = true
                    DispatchQueue.main.async {
                        //NOTE: - Clear all data
                        self.showOneButtonMessage(title: "NOTICE!".localized, message: "Successfully Sent".localized, buttonText: "CLOSE".localized, mainIcon: #imageLiteral(resourceName: "skinToneCheckBoxChecked"))
                    }
                } else {
                    self.showOneButtonMessage(title: "NOTICE!".localized, message: "Sending Failed".localized, buttonText: "RETRY".localized, mainIcon: #imageLiteral(resourceName: "failedIcon"))
                }
            }
        }
    }
    
    func showOneButtonMessage(title: String, message: String, buttonText: String, mainIcon: UIImage) {
        ModalController.shared.presentOneButtonMessagePopupViewController(
            presentingViewController: self,
            titleText: title,
            messageText: message,
            buttonText: buttonText, icon: mainIcon, delegate: self)
    }
    
    func didSelectPDFResultPopupViewControllerRightButtonPressed() {
        
    }
}

extension ResultViewController: OneButtonMessagePopupViewControllerDelegate {
    
    func didSelectOneButtonMessagePopupOkPressed() {
        if isSendingSucceed {
            defaults.removeObject(forKey: USER_PHONE_NUMBER)
            defaults.removeObject(forKey: USER_FIRST_NAME)
            defaults.removeObject(forKey: USER_LAST_NAME)
            defaults.removeObject(forKey: USER_BIRTHDAY)
            defaults.removeObject(forKey: USER_EMAIL_ADDRESS)
            defaults.removeObject(forKey: USER_ID)
            self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
        } else {
            let customerID = defaults.value(forKey: USER_ID) as? Int ?? 0
            self.showActivityIndicator()
            self.sendToDBPisgaServer(pdf: pdfDATA, id: customerID, fileName: "Results")
        }
    }
}
