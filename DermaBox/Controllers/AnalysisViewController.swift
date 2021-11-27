//
//  AnalysisViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/09/05.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import ChowisSDK
import Alamofire
import CWLocalAlgorithm

class AnalysisViewController: BaseViewController {
    
    public typealias PoresClouldCallback = (_ result: Int, _ image: UIImage) -> Void
    public typealias WrinklesClouldCallback = (_ result: Int, _ image: UIImage) -> Void
    public typealias ImpuritiesClouldCallback = (_ result: Int, _ image: UIImage) -> Void
    public typealias SpotsClouldCallback = (_ result: Int, _ image: UIImage) -> Void
    public typealias KeratinClouldCallback = (_ result: Int, _ image: UIImage) -> Void
    
    var poresClouldCallback: PoresClouldCallback?
    var wrinklesClouldCallback: WrinklesClouldCallback?
    var impuritiesClouldCallback: ImpuritiesClouldCallback?
    var spotsClouldCallback: SpotsClouldCallback?
    var keratinClouldCallback: KeratinClouldCallback?
    
    @IBOutlet var analysisLabel: UILabel!
    @IBOutlet var poresButton: UIButton!
    @IBOutlet var spotsButton: UIButton!
    @IBOutlet var wrinklesButton: UIButton!
    @IBOutlet var impuritiesButton: UIButton!
    @IBOutlet var keratinButton: UIButton!
    @IBOutlet var expertAnalysisButton: UIButton!
    @IBOutlet var skinSensitivityButton: UIButton!
    @IBOutlet var blackheadButton: UIButton!
    @IBOutlet var skinToneButton: UIButton!
    @IBOutlet var totalAnalysisButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    @IBOutlet var poresButtonView: UIView!
    @IBOutlet var spotsButtonView: UIView!
    @IBOutlet var wrinklesButtonView: UIView!
    @IBOutlet var impuritiesButtonView: UIView!
    @IBOutlet var keratinButtonView: UIView!
    @IBOutlet var expertAnalysisButtonView: UIView!
    @IBOutlet var skinSensitivityButtonView: UIView!
    @IBOutlet var blackheadButtonView: UIView!
    @IBOutlet var skinToneButtonView: UIView!
    @IBOutlet var totalAnalysisButtonView: UIView!
    @IBOutlet var resultButtonView: UIView!
    
    @IBOutlet var analyzeButton: UIButton!
    @IBOutlet var analyzeButtonLabel: UILabel!
    @IBOutlet var detailsButton: UIButton!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var compareButton: UIButton!
    @IBOutlet var compareLabel: UILabel!
    @IBOutlet var threeDButton: UIButton!
    @IBOutlet var threeDLabel: UILabel!
    @IBOutlet var cautionLabel: UILabel!
    @IBOutlet var nomralLabel: UILabel!
    @IBOutlet var resultsLabel: UILabel!
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var resultsValueLabel: UILabel!
    @IBOutlet var averageValueLabel: UILabel!
    @IBOutlet var imageResultDescriptionLabel: UILabel!
    @IBOutlet var imagesPageControl: UIPageControl!
    @IBOutlet var detailsStackView: UIStackView!
    @IBOutlet var compareStackView: UIStackView!
    @IBOutlet var threeDStackView: UIStackView!
    @IBOutlet var analyzeStackView: UIStackView!
    @IBOutlet var resultAverageBackgroundView: UIView!
    @IBOutlet var imagesScrollView: UIScrollView!
    @IBOutlet var gradientLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var gradientView: UIView!
    @IBOutlet weak var analyzingAllView: UIView!
    @IBOutlet weak var analyzingAllLabel: UILabel!
    @IBOutlet weak var analyzingAllPoresLabel: UILabel!
    @IBOutlet weak var analyzingAllSpotsLabel: UILabel!
    @IBOutlet weak var analyzingAllWrinklesLabel: UILabel!
    @IBOutlet weak var analyzingAllImpuritiesLabel: UILabel!
    @IBOutlet weak var analyzingAllKeratinLabel: UILabel!
    
    @IBOutlet weak var analyzingAllPoresImageView: UIImageView!
    @IBOutlet weak var analyzingAllSpotsImageView: UIImageView!
    @IBOutlet weak var analyzingAllWrinklesImageView: UIImageView!
    @IBOutlet weak var analyzingAllImpuritiesImageView: UIImageView!
    @IBOutlet weak var analyzingAllKeratinImageView: UIImageView!
    
    @IBOutlet weak var poresAnalyzingAllProgressView: LinearProgressBar!
    @IBOutlet weak var spotsAnalyzingAllProgressView: LinearProgressBar!
    @IBOutlet weak var wrinklesAnalyzingAllProgressView: LinearProgressBar!
    @IBOutlet weak var impuritiesAnalyzingAllProgressView: LinearProgressBar!
    @IBOutlet weak var keratinAnalyzingAllProgressView: LinearProgressBar!
    
    @IBOutlet weak var poresAnalyzingAllView: UIView!
    @IBOutlet weak var spotsAnalyzingAllView: UIView!
    @IBOutlet weak var wrinklesAnalyzingAllView: UIView!
    @IBOutlet weak var impuritesAnalyzingAllView: UIView!
    @IBOutlet weak var keratinAnalyzingAllView: UIView!
    
    @IBOutlet weak var zoomOutButton: UIButton!
    
    var poresAnalyzeCount = 0
    var spotsAnalyzeCount = 0
    var wrinklesAnalyzeCount = 0
    var impuritiesAnalyzeCount = 0
    var keratinAnalyzeCount = 0
    
    var isPoresAvailable: Bool = false
    var isSpotsAvailable: Bool = false
    var isWrinklesAvailable: Bool = false
    var isImpuritiesAvailable: Bool = false
    var isKeratinAvailable: Bool = false
    var isSkinSensitivityAvailable: Bool = false
    var isSkinToneAvailable: Bool = false
    var isBlackheadAvailable: Bool = false
    
    let selectedButtonColor = #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1)
    let defaultButtonColor = #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1)
    let borderColor = #colorLiteral(red: 0.3621093035, green: 0.6783183217, blue: 0.5999593139, alpha: 1)
    let whiteColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let blackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
   // #colorLiteral(red: 0, green: 0.8661797643, blue: 0.6442741752, alpha: 1)
    
    var scrollWidth: CGFloat = 0.0
    var scrollHeight: CGFloat = 0.0
    var currentImageIndex = 0
    var analysisCount = 0
    var totalNumberOfAnalysis = 0
    var currentMode:DiagnosisMode!
    var onlyAnalyzeOnce = false
    let isCloudAnalysis = true
    let process = DispatchGroup()
    let cwLocalAnalysis = CWLocalAnalysis()
    var ffaResult = FFAModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.totalNumberOfAnalysis =
            DiagnosisInformation.shared.poresImages.count +
            DiagnosisInformation.shared.spotsImages.count +
            DiagnosisInformation.shared.wrinklesImages.count +
            DiagnosisInformation.shared.impuritiesImages.count +
            DiagnosisInformation.shared.keratinImages.count +
            DiagnosisInformation.shared.skinSensitivityImages.count +
            DiagnosisInformation.shared.blackheadImages.count

        self.imagesScrollView.layer.borderWidth = 2
        //self.imagesScrollView.layer.borderColor = selectedButtonColor.cgColor
        self.makeAllButtonBackgroundWhiteButSelectedButtonView()
        if self.checkTotalDiagnosisAvailability(shouldAffectUI: true) == false {

            self.expertAnalysisButtonView.isHidden = true
            _ = self.checkExpertDiagnosisAvailability(shouldAffectUI: true)

        } else {

            self.expertAnalysisButtonView.isHidden = !self.checkExpertDiagnosisAvailability(shouldAffectUI: false)
        }

        self.totalAnalysisButtonView.isHidden = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.clickOriginal(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        self.imagesScrollView.addGestureRecognizer(tapGesture)
        self.addAnalyzingAllToView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self, selector:#selector(appMovedToForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
        self.localizeStrings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.onlyAnalyzeOnce == false {

            self.analyzeDiagnosis()
            self.onlyAnalyzeOnce = true
        }
    }
    
    private func addAnalyzingAllToView() {
        
        self.view.addSubview(self.analyzingAllView)
        self.analyzingAllView.translatesAutoresizingMaskIntoConstraints = false
        self.analyzingAllView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.analyzingAllView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.analyzingAllView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.analyzingAllView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.analyzingAllView.isHidden = true
    }
    
    fileprivate func checkTotalDiagnosisAvailability(shouldAffectUI: Bool) -> Bool {
        
        self.isPoresAvailable = DiagnosisInformation.shared.poresImages.count > 0 ? true : false
        self.isSpotsAvailable = DiagnosisInformation.shared.spotsImages.count > 0 ? true : false
        self.isWrinklesAvailable = DiagnosisInformation.shared.wrinklesImages.count > 0 ? true : false
        self.isImpuritiesAvailable = DiagnosisInformation.shared.impuritiesImages.count > 0 ? true : false
        self.isKeratinAvailable = DiagnosisInformation.shared.keratinImages.count > 0 ? true : false
        
        if shouldAffectUI {
            
            self.poresButtonView.isHidden      = !self.isPoresAvailable
            self.spotsButtonView.isHidden      = !self.isSpotsAvailable
            self.wrinklesButtonView.isHidden   = !self.isWrinklesAvailable
            self.impuritiesButtonView.isHidden = !self.isImpuritiesAvailable
            self.keratinButtonView.isHidden    = !self.isKeratinAvailable
        }
        
        self.poresAnalyzingAllView.isHidden     = !self.isPoresAvailable
        self.spotsAnalyzingAllView.isHidden     = !self.isSpotsAvailable
        self.wrinklesAnalyzingAllView.isHidden  = !self.isWrinklesAvailable
        self.impuritesAnalyzingAllView.isHidden = !self.isImpuritiesAvailable
        self.keratinAnalyzingAllView.isHidden   = !self.isKeratinAvailable
        
        return self.isPoresAvailable || self.isSpotsAvailable || self.isWrinklesAvailable || self.isImpuritiesAvailable || self.isKeratinAvailable
    }
    
    fileprivate func checkExpertDiagnosisAvailability(shouldAffectUI: Bool) -> Bool {
        
        self.isSkinSensitivityAvailable = DiagnosisInformation.shared.skinSensitivityImages.count > 0 ? true : false
        self.isBlackheadAvailable = DiagnosisInformation.shared.blackheadImages.count > 0 ? true : false
        
        if shouldAffectUI {
            
            self.skinSensitivityButtonView.isHidden = !self.isSkinSensitivityAvailable
            self.blackheadButtonView.isHidden = !self.isBlackheadAvailable
        }
        
        return self.isSkinSensitivityAvailable || self.isBlackheadAvailable || self.isSkinToneAvailable
    }

    func checkAndDismissIndicator() {
        
        self.analysisCount += 1
        self.poresAnalyzingAllProgressView.progressValue = (CGFloat(self.poresAnalyzeCount) / CGFloat(DiagnosisInformation.shared.poresImages.count)) * 100
        self.spotsAnalyzingAllProgressView.progressValue = (CGFloat(self.spotsAnalyzeCount) / CGFloat(DiagnosisInformation.shared.spotsImages.count)) * 100
        self.wrinklesAnalyzingAllProgressView.progressValue = (CGFloat(self.wrinklesAnalyzeCount) / CGFloat(DiagnosisInformation.shared.wrinklesImages.count)) * 100
        self.impuritiesAnalyzingAllProgressView.progressValue = (CGFloat(self.impuritiesAnalyzeCount) / CGFloat(DiagnosisInformation.shared.impuritiesImages.count)) * 100
        self.keratinAnalyzingAllProgressView.progressValue = (CGFloat(self.keratinAnalyzeCount) / CGFloat(DiagnosisInformation.shared.keratinImages.count)) * 100
        
        if self.poresAnalyzingAllProgressView.progressValue == 100 {
            self.analyzingAllPoresImageView.image = #imageLiteral(resourceName: "ic_select_n")
        }
        
        if self.spotsAnalyzingAllProgressView.progressValue == 100 {
            self.analyzingAllSpotsImageView.image = #imageLiteral(resourceName: "ic_select_n")
        }
        
        if self.wrinklesAnalyzingAllProgressView.progressValue == 100 {
            self.analyzingAllWrinklesImageView.image = #imageLiteral(resourceName: "ic_select_n")
        }
        
        if self.impuritiesAnalyzingAllProgressView.progressValue == 100 {
            self.analyzingAllImpuritiesImageView.image = #imageLiteral(resourceName: "ic_select_n")
        }
        
        if self.keratinAnalyzingAllProgressView.progressValue == 100 {
            self.analyzingAllKeratinImageView.image = #imageLiteral(resourceName: "ic_select_n")
        }
        
        if self.isKeratinAvailable {
            
            self.addImagesFromArray(diags: DiagnosisInformation.shared.keratinImages, mode: .keratin)
            self.keratinButtonPressed(self.keratinButton)
        }
        
        if self.isImpuritiesAvailable {
            
            self.addImagesFromArray(diags: DiagnosisInformation.shared.impuritiesImages, mode: .impurities)
            self.impuritiesButtonPressed(self.impuritiesButton)
        }
       
        if self.isWrinklesAvailable {
            
            self.addImagesFromArray(diags: DiagnosisInformation.shared.wrinklesImages, mode: .wrinkles)
            self.wrinklesButtonPressed(self.wrinklesButton)
        }
        
        if self.isSpotsAvailable {
            
            self.addImagesFromArray(diags: DiagnosisInformation.shared.spotsImages, mode: .spots)
            self.spotsButtonPressed(self.spotsButton)
        }
        
        if self.isPoresAvailable {
            
            self.addImagesFromArray(diags: DiagnosisInformation.shared.poresImages, mode: .pores)
            self.poresButtonPressed(self.poresButton)
        }
        
        if self.totalNumberOfAnalysis == self.analysisCount {
            
            self.analyzingAllView.isHidden = true
        }
    }
    
    @objc fileprivate func clickOriginal(recognizer: UITapGestureRecognizer) {
        
        if self.currentMode == .pores {
            
            if self.currentImageIndex < DiagnosisInformation.shared.poresImages.count {
                
                if DiagnosisInformation.shared.poresImages[currentImageIndex].isAnalyzedImage {
                    
                    DiagnosisInformation.shared.poresImages[currentImageIndex].currentPath = DiagnosisInformation.shared.poresImages[currentImageIndex].originalPath
                    DiagnosisInformation.shared.poresImages[currentImageIndex].isAnalyzedImage = false
                
                } else {
                    
                    DiagnosisInformation.shared.poresImages[currentImageIndex].currentPath = DiagnosisInformation.shared.poresImages[currentImageIndex].analyzedPath
                    DiagnosisInformation.shared.poresImages[currentImageIndex].isAnalyzedImage = true
                }
                
                self.addImagesFromArray(diags: DiagnosisInformation.shared.poresImages, mode: .pores)
            }
        }
        
        if self.currentMode == .wrinkles {

            if self.currentImageIndex < DiagnosisInformation.shared.wrinklesImages.count {

                if DiagnosisInformation.shared.wrinklesImages[self.currentImageIndex].isAnalyzedImage {

                    DiagnosisInformation.shared.wrinklesImages[self.currentImageIndex].currentPath = DiagnosisInformation.shared.wrinklesImages[self.currentImageIndex].originalPath
                    DiagnosisInformation.shared.wrinklesImages[self.currentImageIndex].isAnalyzedImage = false

                } else {

                    DiagnosisInformation.shared.wrinklesImages[self.currentImageIndex].currentPath = DiagnosisInformation.shared.wrinklesImages[self.currentImageIndex].analyzedPath
                    DiagnosisInformation.shared.wrinklesImages[self.currentImageIndex].isAnalyzedImage = true
                }

                self.addImagesFromArray(diags: DiagnosisInformation.shared.wrinklesImages,mode: .wrinkles)
            }
        }

        if self.currentMode == .impurities {

            if self.currentImageIndex < DiagnosisInformation.shared.impuritiesImages.count {

                if DiagnosisInformation.shared.impuritiesImages[self.currentImageIndex].isAnalyzedImage {

                    DiagnosisInformation.shared.impuritiesImages[self.currentImageIndex].currentPath = DiagnosisInformation.shared.impuritiesImages[self.currentImageIndex].originalPath
                    DiagnosisInformation.shared.impuritiesImages[self.currentImageIndex].isAnalyzedImage = false

                } else {

                    DiagnosisInformation.shared.impuritiesImages[self.currentImageIndex].currentPath = DiagnosisInformation.shared.impuritiesImages[self.currentImageIndex].analyzedPath
                    DiagnosisInformation.shared.impuritiesImages[self.currentImageIndex].isAnalyzedImage = true
                }

                self.addImagesFromArray(diags: DiagnosisInformation.shared.impuritiesImages, mode: .impurities)
            }
        }
        
        if self.currentMode == .keratin {
            
            if self.currentImageIndex < DiagnosisInformation.shared.keratinImages.count {

                if DiagnosisInformation.shared.keratinImages[self.currentImageIndex].isAnalyzedImage {

                    DiagnosisInformation.shared.keratinImages[self.currentImageIndex].currentPath = DiagnosisInformation.shared.keratinImages[self.currentImageIndex].originalPath
                    DiagnosisInformation.shared.keratinImages[self.currentImageIndex].isAnalyzedImage = false

                } else {

                    DiagnosisInformation.shared.keratinImages[self.currentImageIndex].currentPath = DiagnosisInformation.shared.keratinImages[self.currentImageIndex].analyzedPath
                    DiagnosisInformation.shared.keratinImages[self.currentImageIndex].isAnalyzedImage = true
                }

                self.addImagesFromArray(diags: DiagnosisInformation.shared.keratinImages, mode: .keratin)
            }
        }
        
        if self.currentMode == .spots {
            
            if self.currentImageIndex < DiagnosisInformation.shared.spotsImages.count {

                if DiagnosisInformation.shared.spotsImages[self.currentImageIndex].isAnalyzedImage {

                    DiagnosisInformation.shared.spotsImages[self.currentImageIndex].currentPath = DiagnosisInformation.shared.spotsImages[self.currentImageIndex].originalPath
                    DiagnosisInformation.shared.spotsImages[self.currentImageIndex].isAnalyzedImage = false

                } else {

                    DiagnosisInformation.shared.spotsImages[self.currentImageIndex].currentPath = DiagnosisInformation.shared.spotsImages[self.currentImageIndex].analyzedPath
                    DiagnosisInformation.shared.spotsImages[self.currentImageIndex].isAnalyzedImage = true
                }

                self.addImagesFromArray(diags: DiagnosisInformation.shared.spotsImages, mode: .spots)
            }
        }
    }
    
    //MARK: - Pores Clould Analysis
    func getPoresClouldAnalysis(_ image: UIImage, completion: @escaping PoresClouldCallback) {
        
        self.poresClouldCallback = completion
        
        CWServiceManager.shared().analyzeSkinImage(
            withCloud: 0,
            accessToken: Util.shared.token,
            algorithmId: 10,
            customerId: 1,
            deviceType: 1,
            latitude: Util.shared.latitude,
            longitude: Util.shared.longitude,
            gender: Int(DiagnosisInformation.shared.customerGender.rawValue),
            age: 20,
            temperature: Util.shared.temperature,
            humidity: Util.shared.humidity,
            uvIndex: Int(Util.shared.uvIndex),
            skinColorGroup: Int(DiagnosisInformation.shared.customerSkinScalColorType.rawValue),
            ethnicity: 1,
            image: image,
            useMask: true,
            delegate: self,
            appID: App.app_id)
    }
    
    //MARK: - Pores Recursive Clould Analysis
    func poresRecursiveClouldAnalysis(index: Int) {
        
        if DiagnosisInformation.shared.poresImages.count > index {
            
            self.poresButtonPressed(self.poresButton)
            
            let imagePath = DiagnosisInformation.shared.poresImages[index].originalPath
            
            if let image = Util.shared.getImageFromDatabase(fileName: imagePath) {
                
                self.getPoresClouldAnalysis(image) { (result, resultImage) in
                    
                    DiagnosisInformation.shared.poresImages[index].resultValue = result
                    let ret = Util.shared.saveImageToDatabase(image: resultImage, fileName: DiagnosisInformation.shared.poresImages[index].analyzedPath)
                    if ret {
                        self.addImagesFromArray(diags: DiagnosisInformation.shared.poresImages, mode: .pores)
                        self.poresAnalyzeCount += 1
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            
                            self.poresRecursiveClouldAnalysis(index: index + 1)
                            self.checkAndDismissIndicator()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.analyzingAllView.isHidden = true
                        }
                    }
                }
                
            } else {
                
                self.checkAndDismissIndicator()
            }
            
        } else {
            
            self.poresClouldCallback = nil
            self.spotsRecursiveClouldAnalysis(index: 0)
        }
    }
    
    //MARK: - Spots Clould Analysis
    func getSpotsClouldAnalysis(_ image: UIImage, completion: @escaping SpotsClouldCallback) {
        
        self.spotsClouldCallback = completion
        
        CWServiceManager.shared().analyzeSkinImage(
            withCloud: 0,
            accessToken: Util.shared.token,
            algorithmId: 11,
            customerId: 1,
            deviceType: 1,
            latitude: Util.shared.latitude,
            longitude: Util.shared.longitude,
            gender: Int(DiagnosisInformation.shared.customerGender.rawValue),
            age: 20,
            temperature: Util.shared.temperature,
            humidity: Util.shared.humidity,
            uvIndex: Int(Util.shared.uvIndex),
            skinColorGroup: Int(DiagnosisInformation.shared.customerSkinScalColorType.rawValue),
            ethnicity: 1,
            image: image,
            useMask: true,
            delegate: self,
            appID: App.app_id)
    }
    
    //MARK: - Spots Recursive Clould Analysis
    func spotsRecursiveClouldAnalysis(index: Int) {
    
        if DiagnosisInformation.shared.spotsImages.count > index {
            
            self.spotsButtonPressed(self.spotsButton)
            
            let imagePath = DiagnosisInformation.shared.spotsImages[index].originalPath
            
            if let image = Util.shared.getImageFromDatabase(fileName: imagePath) {
                
                self.getSpotsClouldAnalysis(image) { (result, resultImage) in
                    
                    DiagnosisInformation.shared.spotsImages[index].resultValue = result
                    let ret = Util.shared.saveImageToDatabase(image: resultImage, fileName: DiagnosisInformation.shared.spotsImages[index].analyzedPath)
                    if ret {
                        self.addImagesFromArray(diags: DiagnosisInformation.shared.spotsImages, mode: .spots)
                        self.spotsAnalyzeCount += 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            
                            self.spotsRecursiveClouldAnalysis(index: index + 1)
                            self.checkAndDismissIndicator()
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            self.analyzingAllView.isHidden = true
                        }
                    }
                }
                
            } else {
                
                self.checkAndDismissIndicator()
            }
        
        } else {
            
            self.spotsClouldCallback = nil
            self.wrinklesRecursiveClouldAnalysis(index: 0)
        }
    }
    
    //MARK: - Wrinkles Clould Analysis
    func getWrinklesClouldAnalysis(_ image: UIImage, completion: @escaping WrinklesClouldCallback) {
        
        self.wrinklesClouldCallback = completion

        CWServiceManager.shared().analyzeSkinImage(
            withCloud: 0,
            accessToken: Util.shared.token,
            algorithmId: 13,
            customerId: 1,
            deviceType: 1,
            latitude: Util.shared.latitude,
            longitude: Util.shared.longitude,
            gender: Int(DiagnosisInformation.shared.customerGender.rawValue),
            age: 20,
            temperature: Util.shared.temperature,
            humidity: Util.shared.humidity,
            uvIndex: Int(Util.shared.uvIndex),
            skinColorGroup: Int(DiagnosisInformation.shared.customerSkinScalColorType.rawValue),
            ethnicity: 1,
            image: image,
            useMask: true,
            delegate: self,
            appID: App.app_id)
    }
    
    //MARK: - Wrinkles Recursive Clould Analysis
    func wrinklesRecursiveClouldAnalysis(index: Int) {
    
        if DiagnosisInformation.shared.wrinklesImages.count > index {
            
            self.wrinklesButtonPressed(self.wrinklesButton)
            
            let imagePath = DiagnosisInformation.shared.wrinklesImages[index].originalPath
            
            if let image = Util.shared.getImageFromDatabase(fileName: imagePath) {
                
                self.getWrinklesClouldAnalysis(image) { (result, resultImage) in
                    
                    DiagnosisInformation.shared.wrinklesImages[index].resultValue = result
                    let ret = Util.shared.saveImageToDatabase(image: resultImage, fileName: DiagnosisInformation.shared.wrinklesImages[index].analyzedPath)
                    if ret {
                        self.addImagesFromArray(diags: DiagnosisInformation.shared.wrinklesImages, mode: .wrinkles)
                        self.wrinklesAnalyzeCount += 1
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            
                            self.wrinklesRecursiveClouldAnalysis(index: index + 1)
                            self.checkAndDismissIndicator()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.analyzingAllView.isHidden = true
                        }
                    }
                }
                
            } else {
                
                self.checkAndDismissIndicator()
            }
            
        } else {
            
            self.wrinklesClouldCallback = nil
            self.impuritiesRecursiveClouldAnalysis(index: 0)
        }
    }
    
    //MARK: - Impurities Clould Analysis
    func getImpuritiesClouldAnalysis(_ image: UIImage, completion: @escaping ImpuritiesClouldCallback) {
        
        self.impuritiesClouldCallback = completion

        CWServiceManager.shared().analyzeSkinImage(
            withCloud: 0,
            accessToken: Util.shared.token,
            algorithmId: 12,
            customerId: 1,
            deviceType: 1,
            latitude: Util.shared.latitude,
            longitude: Util.shared.longitude,
            gender: Int(DiagnosisInformation.shared.customerGender.rawValue),
            age: 20,
            temperature: Util.shared.temperature,
            humidity: Util.shared.humidity,
            uvIndex: Int(Util.shared.uvIndex),
            skinColorGroup: Int(DiagnosisInformation.shared.customerSkinScalColorType.rawValue),
            ethnicity: 1,
            image: image,
            useMask: true,
            delegate: self,
            appID: App.app_id)
    }
    
    //MARK: - Impurities Recursive Clould Analysis
    func impuritiesRecursiveClouldAnalysis(index: Int) {
        
        if DiagnosisInformation.shared.impuritiesImages.count > index {
            
            self.impuritiesButtonPressed(self.impuritiesButton)
            
            let imagePath = DiagnosisInformation.shared.impuritiesImages[index].originalPath
            
            if let image = Util.shared.getImageFromDatabase(fileName: imagePath) {
                
                self.getImpuritiesClouldAnalysis(image) { (result, resultImage) in
                    
                    DiagnosisInformation.shared.impuritiesImages[index].resultValue = result
                    let ret = Util.shared.saveImageToDatabase(image: resultImage, fileName: DiagnosisInformation.shared.impuritiesImages[index].analyzedPath)
                    
                    if ret {
                        self.addImagesFromArray(diags: DiagnosisInformation.shared.impuritiesImages, mode: .impurities)
                        self.impuritiesAnalyzeCount += 1
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                         
                            self.impuritiesRecursiveClouldAnalysis(index: index + 1)
                            self.checkAndDismissIndicator()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.analyzingAllView.isHidden = true
                        }
                    }
                }
                
            } else {
                
                self.checkAndDismissIndicator()
            }
            
        } else {
            
            self.impuritiesClouldCallback = nil
            self.keratinRecursiveClouldAnalysis(index: 0)
        }
    }
    
    //MARK: - Keratin Clould Analysis
    func getKeratinClouldAnalysis(_ image: UIImage, completion: @escaping KeratinClouldCallback) {
        
        self.keratinClouldCallback = completion
        
        CWServiceManager.shared().analyzeSkinImage(
            withCloud: 0,
            accessToken: Util.shared.token,
            algorithmId: 14,
            customerId: 1,
            deviceType: 1,
            latitude: Util.shared.latitude,
            longitude: Util.shared.longitude,
            gender: Int(DiagnosisInformation.shared.customerGender.rawValue),
            age: 20,
            temperature: Util.shared.temperature,
            humidity: Util.shared.humidity,
            uvIndex: Int(Util.shared.uvIndex),
            skinColorGroup: Int(DiagnosisInformation.shared.customerSkinScalColorType.rawValue),
            ethnicity: 1,
            image: image,
            useMask: true,
            delegate: self,
            appID: App.app_id)
    }
    
    //MARK: - Keratin Recursive Clould Analysis
    func keratinRecursiveClouldAnalysis(index: Int) {
        
        if DiagnosisInformation.shared.keratinImages.count > index {
            
            self.keratinButtonPressed(self.keratinButton)
            
            let imagePath = DiagnosisInformation.shared.keratinImages[index].originalPath
            
            if let image = Util.shared.getImageFromDatabase(fileName: imagePath) {
                
                self.getKeratinClouldAnalysis(image) { (result, resultImage) in
                    
                    DiagnosisInformation.shared.keratinImages[index].resultValue = result
                    let ret = Util.shared.saveImageToDatabase(image: resultImage, fileName: DiagnosisInformation.shared.keratinImages[index].analyzedPath)
                    if ret {
                        self.addImagesFromArray(diags: DiagnosisInformation.shared.keratinImages, mode: .keratin)
                        self.keratinAnalyzeCount += 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            
                            self.keratinRecursiveClouldAnalysis(index: index + 1)
                            self.checkAndDismissIndicator()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.analyzingAllView.isHidden = true
                        }
                    }
                }
            } else {
                
                self.checkAndDismissIndicator()
            }
        } else {
            
            self.keratinClouldCallback = nil
            self.checkAndDismissIndicator()
        }
    }

    fileprivate func analyzeDiagnosis() {
        
        if self.isNetworkConnected() == false {
            ModalController.shared.presentTwoButtonMessagePopupViewController(
                withTitle: "NOTICE!".localized,
                message: "It seems like you are not connected to the internet!\nPlease go to the Setting and connect to the internet.".localized,
                leftButtonText: "OK".localized,
                rightButtonText: "Cancel".localized,
                presentingViewController: self,
                delegate: self)
            return
        }
        
        DispatchQueue.main.async {
            
            self.analyzingAllView.isHidden = false
            
            if self.checkExpertDiagnosisAvailability(shouldAffectUI: false) {
                
                if self.isSkinToneAvailable {
                    
                    // analyze skin tone
                }
                
                if self.isBlackheadAvailable {
                    
                    // analyze blackhead
                    for index in 0...DiagnosisInformation.shared.blackheadImages.count - 1 {
                        
                        if index % 2 == 0 {
                            
                            if let spotsImage = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.blackheadImages[index].originalPath) {
                                print(spotsImage)
                            }
                            
                        } else {
                            
                            if let impuritiesImage = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.blackheadImages[index].originalPath) {
                                print(impuritiesImage)
                            }
                        }
                        
                        self.checkAndDismissIndicator()
                    }
                }
                
                if self.isSkinSensitivityAvailable {
                    
                    // analyze skin sensitivity
                    for index in 0...DiagnosisInformation.shared.skinSensitivityImages.count - 1 {
                        
                        if let image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.skinSensitivityImages[index].originalPath) {
                            print(image)
//                            let result:CWAnalysisResult = CWImageAnalysis.shared().skin
//                            skinWrinkle(withInputImage: image, rect: DiagnosisInformation.shared.wrinklesImages[index].wrinkleRect)
                        }
                        
                        self.checkAndDismissIndicator()
                    }
                }
            }
            
            if self.checkTotalDiagnosisAvailability(shouldAffectUI: false) {
                
                self.poresRecursiveClouldAnalysis(index: 0)
            }
        }
    }
    
    fileprivate func localizeStrings() {
        
        self.analysisLabel.text = "ANALYSIS".localized
        self.poresButton.setTitle("Pores".localized, for: .normal)
        self.spotsButton.setTitle("Spots".localized, for: .normal)
        self.wrinklesButton.setTitle("Wrinkles".localized, for: .normal)
        self.impuritiesButton.setTitle("Impurities".localized, for: .normal)
        self.keratinButton.setTitle("Keratin".localized, for: .normal)
        self.resultButton.setTitle("RESULT".localized, for: .normal)
        self.analyzeButtonLabel.text = "ANALYZE".localized
        self.compareLabel.text = "COMPARE".localized
        self.threeDLabel.text = "3D".localized
        self.nomralLabel.text = "Normal".localized
        self.cautionLabel.text = "Caution".localized
        self.resultsLabel.text = "Results".localized
        self.averageLabel.text = "Average".localized
        self.analyzingAllPoresLabel.text = "Pores".localized
        self.analyzingAllSpotsLabel.text = "Spots".localized
        self.analyzingAllWrinklesLabel.text = "Wrinkles".localized
        self.analyzingAllImpuritiesLabel.text = "Impurities".localized
        self.analyzingAllKeratinLabel.text = "Keratin".localized
        self.analysisLabel.text = "Analysis Results Review".localized
        self.analyzingAllLabel.text = "Analyze All".localized
    }
    
    fileprivate func  addImagesFromArray(diags: [DiagData], mode: DiagnosisMode) {
        
        DispatchQueue.main.async {
            
            for imageView in self.imagesScrollView.subviews {
                
                imageView.removeFromSuperview()
            }
            
            if diags.count > 0 {
                
                var index = 0
                
                self.imagesScrollView.contentSize = CGSize(width: CGFloat(diags.count) * self.scrollWidth, height: self.scrollHeight)
                
                for diag in diags {
                    
                    var rectFrame = CGRect()
                    
                    rectFrame.origin.x = self.scrollWidth * CGFloat(index)
                    rectFrame.origin.y = 0
                    rectFrame.size.width = self.scrollWidth
                    rectFrame.size.height = self.scrollHeight
                    
                    let imageView = UIImageView(frame: rectFrame)
                    
                    if let img = Util.shared.getImageFromDatabase(fileName: diag.currentPath) {
                        
                        imageView.image = img
                    }
                    
                    imageView.isUserInteractionEnabled = true
                    self.imagesScrollView.addSubview(imageView)
                    
                    index = index + 1
                }
                
                self.imagesPageControl.isHidden = false
                self.imagesPageControl.numberOfPages = index
                self.resultsValueLabel.text = "-"
                var value = 0
                var count = 0
                
                diags.forEach { (diag) in
                    
                    if diag.resultValue != -1 {
                        
                        value += diag.resultValue
                        count += 1
                    }
                }
                
                if count == 0 {
                    
                    return
                }
                
                var average = Int(value/count)
                
                if average >= 100 {
                    average = 100
                }
                
                self.averageValueLabel.text = "\(average)"
                self.imageResultDescriptionLabel.text = self.getDiagnosisDescription(withValue: average, mode: mode)
                self.updateGradientViewWithValue(resultValue: diags[self.currentImageIndex].resultValue)
                
                let rect = CGRect(x: 0, y: CGFloat(self.currentImageIndex) * self.scrollWidth, width: self.scrollWidth, height: self.scrollHeight)
                
                DispatchQueue.main.async {
                    
                    self.imagesScrollView.scrollRectToVisible(rect, animated: false)
                    self.imagesScrollView.layoutSubviews()
                    self.imagesScrollView.layoutIfNeeded()
                    self.viewDidLayoutSubviews()
                }
                
            } else {
                
                self.imagesPageControl.numberOfPages = 0
            }
        }
    }
    
    fileprivate func updateGradientViewWithValue(resultValue: Int) {
        
        self.gradientLeadingConstraint.constant = self.gradientView.frame.size.width / 100 * CGFloat(resultValue)
        
        if resultValue >= 0 && resultValue <= 100 {
            self.resultsValueLabel.text = "\(resultValue)"
        }
        
        if resultValue > 100 {
            self.resultsValueLabel.text = "100"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollWidth = self.imagesScrollView.frame.width
        self.scrollHeight = self.imagesScrollView.frame.height
        
        self.resultAverageBackgroundView.layer.cornerRadius = 8
        self.resultAverageBackgroundView.layer.borderWidth = 1
        self.resultAverageBackgroundView.layer.borderColor = #colorLiteral(red: 0.7066905499, green: 0.7018448114, blue: 0.7061030269, alpha: 1)
        
        for button in [self.poresButton, self.spotsButton, self.wrinklesButton, self.impuritiesButton, self.keratinButton, self.expertAnalysisButton, self.skinSensitivityButton, self.blackheadButton, self.skinToneButton, self.totalAnalysisButton] {
            
            button?.backgroundColor = .clear
            button?.titleLabel?.numberOfLines = 0
        }
        
        for buttonView in [self.poresButtonView, self.spotsButtonView, self.wrinklesButtonView, self.impuritiesButtonView, self.keratinButtonView, self.expertAnalysisButtonView, self.resultButtonView, self.skinSensitivityButtonView, self.blackheadButtonView, self.skinToneButtonView, self.totalAnalysisButtonView] {
            
            buttonView?.layer.cornerRadius = 8
            buttonView?.layer.borderColor = self.borderColor.cgColor
            buttonView?.layer.borderWidth = 1
        }
        
        self.resultButtonView.backgroundColor = self.defaultButtonColor
        self.resultButton.titleLabel?.numberOfLines = 0
    }
    
    fileprivate func makeAllButtonBackgroundWhiteButSelectedButtonView(
        selectedButtonView: UIView? = nil,
        selectedButton: UIButton? = nil) {
        
        for button in [self.poresButton, self.spotsButton, self.wrinklesButton, self.impuritiesButton, self.keratinButton, self.expertAnalysisButton, self.skinSensitivityButton, self.blackheadButton, self.skinToneButton, self.totalAnalysisButton] {
            
            button?.setTitleColor(self.blackColor, for: .normal)
        }
        
        for buttonView in [self.poresButtonView, self.spotsButtonView, self.wrinklesButtonView, self.impuritiesButtonView, self.keratinButtonView, self.expertAnalysisButtonView, self.skinSensitivityButtonView, self.blackheadButtonView, self.skinToneButtonView, self.totalAnalysisButtonView] {
            
            buttonView?.backgroundColor = self.whiteColor
        }
        
        selectedButtonView?.backgroundColor = self.defaultButtonColor
        selectedButton?.setTitleColor(self.blackColor, for: .normal)
    }
    
    @IBOutlet weak var testImageV: UIImageView!
    
    func ffaAnalysis() {
        
        let opticNumber = defaults.value(forKey: OPTIC_NUMBER) as? String ?? "XX"
        let date = Date()
        process.enter()
        
        var ffaFrontImageName: String = ""

        self.ffaResult.pictureFilepaths?.removeAll()
        
        if let ffaFrontImgName = DiagnosisInformation.shared.ffaFrontImageName {
            ffaFrontImageName = ffaFrontImgName
            self.ffaResult.pictureFilepaths?.append(ffaFrontImageName)
        }
        
        if let ffaLeftImageName = DiagnosisInformation.shared.ffaLeftImageName {
            self.ffaResult.pictureFilepaths?.append(ffaLeftImageName)
        }
        
        if let ffaRightImageName = DiagnosisInformation.shared.ffaRightImageName {
            self.ffaResult.pictureFilepaths?.append(ffaRightImageName)
        }
        
        print("FFA FRONT IMAGE: ", ffaFrontImageName)
        
        let frontFilePath = Util.shared.getFilePath(ffaFrontImageName)
        print("FFA FRONT IMAGE FILE: ", frontFilePath)
        guard let data = NSData(contentsOf: frontFilePath) else { process.leave(); return }
        print("FFA FRONT IMAGE DATA: ", data)
        guard let image = UIImage(data: data as Data) else { process.leave(); return }
        print("FFA FRONT IMAGE IMAGE: ", image)
        self.testImageV.image = image
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { process.leave(); return }
        print("FFA FRONT IMAGE IMAGEDAGA: ", imageData)
        let uploadData = UploadDataModel(data: imageData, name: "image", fileName: ffaFrontImageName, mimeType: "image/jpeg")
        print("FFA FRONT IMAGE UPLOAD DATA: ", uploadData)
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Accept": "application/json",
            "app_id": "1"
        ]
        
        var gender = ""
        if DiagnosisInformation.shared.customerGender == kCWGender_Male {
            gender = "1"
        } else if DiagnosisInformation.shared.customerGender == kCWGender_Female {
            gender = "0"
        }
        
        var clientAge = 23
        let birthday = DiagnosisInformation.shared.customerBirdthday
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        if let birthDay = dateFormatter.date(from: birthday) {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: birthDay, to: now)
            if let age = ageComponents.year {
                clientAge = age
            }
        }
        
        let parameters: Parameters = [
            "optic_number": opticNumber,
            "customer_id": "1",
            "device_type": "7",
            "date": date.formatDateToString(withString: "YYYYMMdd"),
            "time": date.formatDateToString(withString: "HHmmss"),
            "latitude": Util.shared.latitude,
            "longitude": Util.shared.longitude,
            "gender": gender,
            "age": "\(clientAge)",
            "country_code": Locale.current.regionCode ?? "KR",
            "led_info": "XX",
            "device_model_name": UIDevice().modelName,
            "os": Device.os,
            "temperature": Util.shared.temperature,
            "humidity": Util.shared.humidity,
            "uv_index": Util.shared.uvIndex,
            "capture_zone_code": "1",
            "skin_color_group": "\(DiagnosisInformation.shared.customerSkinScalColorType.rawValue)",
            "ethnicity": "\(DiagnosisInformation.shared.customerEthnicity.rawValue)"
        ]
        
        print("PARAMETERS: ", parameters)
        
        ServiceManager.shared.uploadFFA(parameters: parameters, uploadData: uploadData, headers: headers){ (result, error) in
            print("ServiceManager result: ", result as Any)
            print("ServiceManager error: ", error)
            defer { self.process.leave() }
            guard let result = result else { return }
            self.ffaResult = result
            guard
                result.status == 200,
                let body = result.results,
                let analysisData = body.analysisData,
                error == nil
            else { return }
            
            self.doOneImageDownload(
                downloadUrl: analysisData.pores?.mask?.url,
                identifier: .PORES,
                originalImageName: frontFilePath)
            self.doOneImageDownload(
                downloadUrl: analysisData.spots?.mask?.url,
                identifier: .SPOTS,
                originalImageName: frontFilePath)
            self.doOneImageDownload(
                downloadUrl: analysisData.darkcircles?.mask?.url,
                identifier: .DARKCIRCLES,
                originalImageName: frontFilePath)
            self.doOneImageDownload(
                downloadUrl: analysisData.wrinkles?.mask?.url,
                identifier: .WRINKLES,
                originalImageName: frontFilePath)
        }
    }
    
    func doOneImageDownload(downloadUrl: String?, identifier: diagnosisIdentifier, originalImageName: URL) {
        process.enter()
        guard let downloadUrl = downloadUrl else {
            process.leave()
            return
        }
        
        let imageName = Util.shared.createImageName()
        let textName = Util.shared.createTextName()
        let textfileURL = Util.shared.getFilePath(textName)
        let imagefileURL = Util.shared.getFilePath(imageName)
        let destination: DownloadRequest.Destination = { _, _ in
            return (textfileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        ServiceManager.shared.download("http://\(downloadUrl)", destination: destination) { result in
            guard result.error == nil else {
                self.process.leave()
                return
            }
            DispatchQueue.global(qos: .default).async {
                if identifier == .DARKCIRCLES {
                    let _ = self.cwLocalAnalysis.readMaskFFADarkCircle(Util.shared.formatToCWString(originalImageName), inputTextFilePath: Util.shared.formatToCWString(textfileURL), outputFilePath: Util.shared.formatToCWString(imagefileURL))
                } else {
                    let _ = self.cwLocalAnalysis.getAnalyzedImage(Util.shared.formatToCWString(originalImageName), inputTextFilePath: Util.shared.formatToCWString(textfileURL), outputFilePath: Util.shared.formatToCWString(imagefileURL))
                }
                
                switch(identifier) {
                case .PORES:
                    self.ffaResult.results?.analysisData?.pores?.imageFileName = imageName
                case .SPOTS:
                    self.ffaResult.results?.analysisData?.spots?.imageFileName = imageName
                case .DARKCIRCLES:
                    self.ffaResult.results?.analysisData?.darkcircles?.imageFileName = imageName
                case .WRINKLES:
                    self.ffaResult.results?.analysisData?.wrinkles?.imageFileName = imageName
                }
                
                guard let data = NSData(contentsOf: imagefileURL) else { return }
                guard let image = UIImage(data: data as Data) else { return }
                DispatchQueue.main.async {
                    self.testImageV.image = image
                }
                
                print("IMAGE: ", image)
                
                print("imagefileURL: ", imagefileURL)
                self.process.leave()
            }
        }
    }
    
    @IBAction func zoomOutButtonPressed(_ sender: Any) {
        
        self.zoomOutButton.isSelected = !self.zoomOutButton.isSelected
        self.testImageV.isHidden = !self.zoomOutButton.isSelected
        self.ffaAnalysis()
    }
    
    @IBAction func poresButtonPressed(_ sender: UIButton) {
        
        self.currentMode = .pores
        self.currentImageIndex = 0
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.poresButtonView,
            selectedButton: self.poresButton)
        
        self.addImagesFromArray(
            diags: DiagnosisInformation.shared.poresImages,
            mode: .pores)
        
        self.detailsStackView.isHidden = true
        self.compareStackView.isHidden = false
        self.threeDStackView.isHidden = false
        self.analyzeStackView.isHidden = false
    }
    
    @IBAction func spotsButtonPressed(_ sender: UIButton) {
        
        self.currentMode = .spots
        self.currentImageIndex = 0
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.spotsButtonView,
            selectedButton: self.spotsButton)
        
        self.addImagesFromArray(
            diags: DiagnosisInformation.shared.spotsImages,
            mode: .spots)
        
        self.detailsStackView.isHidden = true
        self.compareStackView.isHidden = false
        self.threeDStackView.isHidden = true
        self.analyzeStackView.isHidden = false
    }
    
    @IBAction func wrinklesButtonPressed(_ sender: UIButton) {
        
        self.currentMode = .wrinkles
        self.currentImageIndex = 0
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.wrinklesButtonView,
            selectedButton: self.wrinklesButton)
        
        self.addImagesFromArray(
            diags: DiagnosisInformation.shared.wrinklesImages,
            mode: .wrinkles)
        
        self.detailsStackView.isHidden = true
        self.compareStackView.isHidden = false
        self.threeDStackView.isHidden = true
        self.analyzeStackView.isHidden = true
    }
    
    @IBAction func impuritiesButtonPressed(_ sender: UIButton) {
        
        self.currentMode = .impurities
        self.currentImageIndex = 0
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.impuritiesButtonView,
            selectedButton: self.impuritiesButton)
        
        self.addImagesFromArray(
            diags: DiagnosisInformation.shared.impuritiesImages,
            mode: .impurities)
        
        self.detailsStackView.isHidden = true
        self.compareStackView.isHidden = false
        self.threeDStackView.isHidden = true
        self.analyzeStackView.isHidden = false
    }
    
    @IBAction func keratinButtonPressed(_ sender: UIButton) {
        
        self.currentMode = .keratin
        self.currentImageIndex = 0
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.keratinButtonView,
            selectedButton: self.keratinButton)
        
        self.addImagesFromArray(
            diags: DiagnosisInformation.shared.keratinImages,
            mode: .keratin)
        
        self.detailsStackView.isHidden = true
        self.compareStackView.isHidden = false
        self.threeDStackView.isHidden = true
        self.analyzeStackView.isHidden = false
    }
    
    @IBAction func detailsButtonPressed(_ sender: UIButton) {
        
        let index = self.imagesPageControl.currentPage
        
        if DiagnosisInformation.shared.wrinklesImages.count > index {
            
            ModalController.shared.presentFullWrinkleAnalysisViewController(presentingViewController: self, wrinkleData: DiagnosisInformation.shared.wrinklesImages[index])
        }
    }
    
    @IBAction func compareButtonPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "GoToCompareVC", sender: self)
    }
    
    @IBAction func threeDButtonPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "GoToThreeDVC", sender: self)
    }
    
    @IBAction func skinSensitivityButtonPressed(_ sender: UIButton) {
        
        self.currentMode = .skinSensitivity
        
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.skinSensitivityButtonView,
            selectedButton: self.skinSensitivityButton)
        
        self.addImagesFromArray(
            diags: DiagnosisInformation.shared.keratinImages,
            mode: .keratin)
    }
    
    @IBAction func blackheadButtonPressed(_ sender: UIButton) {
        
        self.currentMode = .blackhead
        
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.blackheadButtonView,
            selectedButton: self.blackheadButton)
        
        self.addImagesFromArray(
            diags: DiagnosisInformation.shared.keratinImages,
            mode: .keratin)
    }
    
    @IBAction func skinToneButtonPressed(_ sender: UIButton) {
        
        self.currentMode = .skinTone
        
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.skinToneButtonView,
            selectedButton: self.skinToneButton)
        
        self.addImagesFromArray(
            diags: DiagnosisInformation.shared.keratinImages,
            mode: .keratin)
    }
    
    @IBAction func totalAnalysisButtonPressed(_ sender: UIButton) {
        
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.totalAnalysisButtonView,
            selectedButton: self.totalAnalysisButton)
        
        self.skinSensitivityButtonView.isHidden = true
        self.blackheadButtonView.isHidden = true
        self.skinToneButtonView.isHidden = true
        
        _ = self.checkTotalDiagnosisAvailability(shouldAffectUI: true)
        self.totalAnalysisButtonView.isHidden = true
        self.expertAnalysisButtonView.isHidden = !self.checkExpertDiagnosisAvailability(shouldAffectUI: false)
        
        if self.isKeratinAvailable {
            
            self.poresButtonPressed(self.poresButton)
        }
        
        if self.isImpuritiesAvailable {
            
            self.impuritiesButtonPressed(self.impuritiesButton)
        }
        
        if self.isWrinklesAvailable {
            
            self.wrinklesButtonPressed(self.wrinklesButton)
        }
        
        if self.isSpotsAvailable {
            
            self.spotsButtonPressed(self.spotsButton)
        }
        
        if self.isPoresAvailable {
            
            self.poresButtonPressed(self.poresButton)
        }
    }
    
    @IBAction func expertAnalysisButtonPressed(_ sender: UIButton) {
        
        self.makeAllButtonBackgroundWhiteButSelectedButtonView(
            selectedButtonView: self.expertAnalysisButtonView,
            selectedButton: self.expertAnalysisButton)
        
        self.poresButtonView.isHidden = true
        self.spotsButtonView.isHidden = true
        self.wrinklesButtonView.isHidden = true
        self.impuritiesButtonView.isHidden = true
        self.keratinButtonView.isHidden = true
        
        self.expertAnalysisButtonView.isHidden = true
        self.totalAnalysisButtonView.isHidden = !self.checkTotalDiagnosisAvailability(shouldAffectUI: false)
        _ = self.checkExpertDiagnosisAvailability(shouldAffectUI: true)
        
        if self.isSkinToneAvailable {
            
            self.skinToneButtonPressed(self.skinToneButton)
        }
        
        if self.isBlackheadAvailable {
            
            self.blackheadButtonPressed(self.blackheadButton)
        }
        
        if self.isSkinSensitivityAvailable {
            
            self.skinSensitivityButtonPressed(self.skinSensitivityButton)
        }
    }
    
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "GoToResultVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToThreeDVC" {
            
            if let vc = segue.destination as? ThreeDViewController {
                
                let index = self.imagesPageControl.currentPage
                
                if self.currentMode == .pores {
                    
                    if let image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.poresImages[index].originalPath) {
                        
                        vc.image = image
                    }
                    
                    vc.threeDPath = DiagnosisInformation.shared.poresImages[index].threeDPath
                    
                    
                } else if self.currentMode == .wrinkles {
                    
                    if let image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.wrinklesImages[index].originalPath) {
                        
                        vc.image = image
                    }
                    
                    vc.threeDPath = DiagnosisInformation.shared.wrinklesImages[index].threeDPath
                }
            }
        } else if segue.identifier == "GoToCompareVC" {
            
            if let vc = segue.destination as? CompareViewController {
                
                vc.mode = self.currentMode
            }
        }
    }
}

extension AnalysisViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = Int((self.imagesScrollView?.contentOffset.x ?? 0) / self.scrollWidth)
        self.imagesPageControl?.currentPage = page
        self.currentImageIndex = page
        
        if self.currentMode == .pores {
            
            if DiagnosisInformation.shared.poresImages.count > page {
                
                self.updateGradientViewWithValue(resultValue: DiagnosisInformation.shared.poresImages[page].resultValue)
                
            } else {
                
                self.resultsValueLabel.text = ""
            }
            
        } else if self.currentMode == .spots {
            
            if DiagnosisInformation.shared.spotsImages.count > page {
                
                self.updateGradientViewWithValue(resultValue: DiagnosisInformation.shared.spotsImages[page].resultValue)
                
            } else {
                
                self.resultsValueLabel.text = ""
            }
            
        } else if self.currentMode == .wrinkles {
            
            if DiagnosisInformation.shared.wrinklesImages.count > page {
                
                self.updateGradientViewWithValue(resultValue: DiagnosisInformation.shared.wrinklesImages[page].resultValue)
                
            } else {
                
                self.resultsValueLabel.text = ""
            }
            
        } else if self.currentMode == .impurities {
            
            if DiagnosisInformation.shared.impuritiesImages.count > page {
                
                self.updateGradientViewWithValue(resultValue: DiagnosisInformation.shared.impuritiesImages[page].resultValue)
                
            } else {
                
                self.resultsValueLabel.text = ""
            }
            
        } else if self.currentMode == .keratin {
            
            if DiagnosisInformation.shared.keratinImages.count > page {
                
                self.updateGradientViewWithValue(resultValue: DiagnosisInformation.shared.keratinImages[page].resultValue)
                
            } else {
                
                self.resultsValueLabel.text = ""
            }
        }
    }
}

extension AnalysisViewController: CWServiceDelegate {
    
    func cwServiceDidFailWithError(_ error: Error?) {
        
        self.hideActivityIndicator()
        print("CWServiceDidFailWithError: \(error?.localizedDescription ?? "")")
    }
    
    func cwServiceDidFailLoginWithError(_ error: Error?) {
        
        self.hideActivityIndicator()
        print("CWServiceDidFailLoginWithError: \(error?.localizedDescription ?? "")")
    }
    
    func cwServiceDidSuccessLogin(withAccessToken accessToken: String, appLicense: String) {
        
        print("cwServiceDidSuccessLogin: \(accessToken)")
    }
    
    func cwServiceDidFailGetAnalysisAlgorithmListWithError(_ error: Error?) {
        
        self.hideActivityIndicator()
        print("CWServiceDidFailGetAnalysisAlgorithmListWithError: \(error?.localizedDescription ?? "")")
    }
    
    func cwServiceDidSuccessGetAnalysisAlgorithmList(withResult result: [AnyHashable : Any]) {
        
        print("cwServiceDidSuccessGetAnalysisAlgorithmList: \(result.description)")
    }
    
    func cwServiceDidFailAnalyzeImageWithError(_ error: Error?) {
        
        self.hideActivityIndicator()
        print("cwServiceDidSuccessGetAnalysisAlgorithmList: \(error.debugDescription)")
    }
    
    func cwServiceWillAnalyzeByBuiltInModule() {
        
        print("CWServiceWillAnalyzeByBuiltInModule")
    }
    
    func cwServiceDidSuccessAnalyzeImage(withResult result: [AnyHashable : Any]) {
        
        print("ANALYZE RESULT: \(result)")
        guard let statusCode = result["status"] as? Int else { return }
        
        if statusCode == 200 {
            
            guard let message = result["msg"] as? String else { return }
            
            if message == "success" {
                
                guard let dictionary = result["body"] as? Dictionary<String, Any> else { return }
                
                guard let outputDic = dictionary["outputFilePath"] as? Dictionary<String, Any> else { return }
                guard let values = dictionary["values"] as? Dictionary<String, Any> else { return }
                
                guard let result = values["level"] as? Int else { return }
                guard let outputImageUrl = outputDic["thumbnail_url"] as? String else { return }
                ServiceManager.shared.getImageFromUrl(url: "http://\(outputImageUrl)") { (image) in
                    
                    if let keratinClouldCallback = self.keratinClouldCallback {
                        
                        keratinClouldCallback(result, image)
                    }
                    
                    if let poresClouldCallback = self.poresClouldCallback {
                        
                        poresClouldCallback(result, image)
                    }
                    
                    if let spotsClouldCallback = self.spotsClouldCallback {
                        
                        spotsClouldCallback(result, image)
                    }
                    
                    if let wrinklesClouldCallback = self.wrinklesClouldCallback {
                        
                        wrinklesClouldCallback(result, image)
                    }
                    
                    if let impuritiesClouldCallback = self.impuritiesClouldCallback {
                        
                        impuritiesClouldCallback(result, image)
                    }
                }
                
            } else {
                
                print("Failed to analyze image")
                
                if let keratinClouldCallback = self.keratinClouldCallback {
                    
                    keratinClouldCallback(-1, UIImage())
                }
                
                if let poresClouldCallback = self.poresClouldCallback {
                    
                    poresClouldCallback(-1, UIImage())
                }
                
                if let spotsClouldCallback = self.spotsClouldCallback {
                    
                    spotsClouldCallback(-1, UIImage())
                }
                
                if let wrinklesClouldCallback = self.wrinklesClouldCallback {
                    
                    wrinklesClouldCallback(-1, UIImage())
                }
                
                if let impuritiesClouldCallback = self.impuritiesClouldCallback {
                    
                    impuritiesClouldCallback(-1, UIImage())
                }
            }
            
        } else {
            
            print("Failed to analyze image")
            if let keratinClouldCallback = self.keratinClouldCallback {
                
                keratinClouldCallback(-1, UIImage())
            }
            
            if let poresClouldCallback = self.poresClouldCallback {
                
                poresClouldCallback(-1, UIImage())
            }
            
            if let spotsClouldCallback = self.spotsClouldCallback {
                
                spotsClouldCallback(-1, UIImage())
            }
            
            if let wrinklesClouldCallback = self.wrinklesClouldCallback {
                
                wrinklesClouldCallback(-1, UIImage())
            }
            
            if let impuritiesClouldCallback = self.impuritiesClouldCallback {
                
                impuritiesClouldCallback(-1, UIImage())
            }
        }
    }
}

extension AnalysisViewController: TwoButtonMessagePopupViewControllerDelegate {
    
    func didSelectTwoButtonMessagePopupViewControllerLeftButtonPressed() {
        
        self.goToWifiSetting()
    }
    
    func didSelectTwoButtonMessagePopupViewControllerRightButtonPressed() {
        
    }
}

extension AnalysisViewController {

    @objc func appMovedToForeground() {
        self.analyzeDiagnosis()
    }
}
