//
//  DiagnosisViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/08/02.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import ChowisSDK
import AVFoundation
import Foundation
import AssetsLibrary
import ARKit


enum DiagnosisMode : String {
    case skinConcern
    case skinConditions
    case beginSkinConditions
    case pores
    case wrinkles
    case keratin
    case impurities
    case spots
    case skinSensitivity
    case skinTone
    case blackhead
}

enum SkinToneMode {
    
    case none
    case cheek
    case chin
    case forehead
}

class DiagnosisViewController: BaseViewController {
    
    @IBOutlet var analysisTtitleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var faceCameraView: UIView!
    @IBOutlet var skinConditionView: UIView!
    //@IBOutlet var skinConcernButton: UIButton!
    @IBOutlet var skinConditionsButton: UIButton!
    @IBOutlet var poresButton: UIButton!
    @IBOutlet var spotsButton: UIButton!
    @IBOutlet var wrinklesButton: UIButton!
    @IBOutlet var impuritiesButton: UIButton!
    @IBOutlet var keratinButton: UIButton!
    @IBOutlet var skinSensitivityButton: UIButton!
    @IBOutlet var skinToneButton: UIButton!
    @IBOutlet var blackheadButton: UIButton!
    @IBOutlet var menuScrollView: UIScrollView!
    @IBOutlet var professionalMenuView: UIView!
    @IBOutlet var expertMenuView: UIView!
    @IBOutlet var moistureContentView: UIView!
    @IBOutlet var moistureGraphView: UIView!
    @IBOutlet var cameraHolderView: UIView!
    @IBOutlet var professionalContentHolderView: UIView!
    @IBOutlet var professionalCapturedImagesCollectionView: UICollectionView!
    @IBOutlet var analyzeButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var professionalCameraHolderView: UIView!
    @IBOutlet var professionalCameraImageView: UIImageView!
    @IBOutlet var womanFaceImageView: UIImageView!
    @IBOutlet var womanFaceMButtonYCenterConstraint: NSLayoutConstraint!
    @IBOutlet var womanFaceMButtonXCenterConstraint: NSLayoutConstraint!
    @IBOutlet var womanFaceOButtonXCenterConstraint: NSLayoutConstraint!
    @IBOutlet var womanFaceOButtonYCenterConstraint: NSLayoutConstraint!
    @IBOutlet var moistureNormalLabel: UILabel!
    @IBOutlet var moistureLabel: UILabel!
    @IBOutlet var moistureDehydratedLabel: UILabel!
    @IBOutlet var sebumHighLabel: UILabel!
    @IBOutlet var sebumLabel: UILabel!
    @IBOutlet var sebumLowLabel: UILabel!
    @IBOutlet var skinConditionsAnalyzeButton: UIButton!
    @IBOutlet var skinConditionsAnalyzeLabel: UILabel!
    @IBOutlet var skinConditionsMButton: UIButton!
    @IBOutlet var skinConditionsOButton: UIButton!
    @IBOutlet var skinConditionsWomanFaceOButton: UIButton!
    @IBOutlet var skinConditionsWomanFaceMButton: UIButton!
    @IBOutlet var skinConditionsLabel: UILabel!
    @IBOutlet var skinConditionsResultLabel: UILabel!
    @IBOutlet var akinConditionsTZoneLabel: UILabel!
    @IBOutlet var akinConditionsUZoneLabel: UILabel!
    @IBOutlet var skinConditionsTZoneResultLabel: UILabel!
    @IBOutlet var skinConditionsUZoneResultLabel: UILabel!
    @IBOutlet var expertCapturedImageCollectionView: UICollectionView!
    @IBOutlet var expertContentHolderView: UIView!
    @IBOutlet var expertCameraHolderView: UIView!
    @IBOutlet var expertCameraImageView: UIImageView!
    @IBOutlet var expertWomanFaceImageView: UIImageView!
    @IBOutlet var expertAnalyzeButton: UIButton!
    @IBOutlet var expertDeleteButton: UIButton!
    @IBOutlet var expertDotButtonCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var expertDotButtonCenterYConstraint: NSLayoutConstraint!
    @IBOutlet var tZoneLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var tZoneBottomConstraint: NSLayoutConstraint!
    @IBOutlet var uZoneLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var uZoneBottomConstraint: NSLayoutConstraint!
    @IBOutlet var moistureGraphImageView: UIImageView!
    @IBOutlet var tZoneImageView: UIImageView!
    @IBOutlet var uZoneImageView: UIImageView!
    @IBOutlet var cameraView: CWVideoPlayer!
    @IBOutlet var uZoneLeadingDottedView: UIView!
    @IBOutlet var uZoneBottomDottedView: UIView!
    @IBOutlet var tZoneLeadingDottedView: UIView!
    @IBOutlet var tZoneBottomDottedView: UIView!
    @IBOutlet var wifiButton: UIButton!
    @IBOutlet var skinToneView: UIView!
    @IBOutlet var faceDotDescriptionLabel: UILabel!
    @IBOutlet var noMackupButton: UIButton!
    @IBOutlet var captureCheckAreaLabel: UILabel!
    @IBOutlet var autoFocusCameraLabel: UILabel!
    @IBOutlet var skinToneRetakeButton: UIButton!
    @IBOutlet var skinToneDoneButton: UIButton!
    @IBOutlet var skinToneCameraHolderView: UIView!
    @IBOutlet var skinToneImageView: UIImageView!
    @IBOutlet var skinToneFaceImageView: UIImageView!
    @IBOutlet var skinToneChinButton: UIButton!
    @IBOutlet var skinToneForeheadButton: UIButton!
    @IBOutlet var skinToneCheekButton: UIButton!
    @IBOutlet var skinToneChinCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var skinToneChinCenterYConstraint: NSLayoutConstraint!
    @IBOutlet var skinToneForeheadCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var skinToneForeheadCenterYConstraint: NSLayoutConstraint!
    @IBOutlet var skinToneCheekCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var skinToneCheekCenterYConstraint: NSLayoutConstraint!
    @IBOutlet var skinToneContentHolderView: UIView!
    @IBOutlet var skinToneSkinColorHolderView: UIView!
    @IBOutlet var skinToneSkinColorView: UIView!
    @IBOutlet var skinToneSkinColorLabel: UILabel!
    @IBOutlet var foreheadSkinColorView: UIView!
    @IBOutlet var cheekSkinColorView: UIView!
    @IBOutlet var chinSkinColorView: UIView!
    @IBOutlet var foreheadSkinColorLineView: UIView!
    @IBOutlet var cheekSkinColorLineView: UIView!
    @IBOutlet var chinSkinColorLineView: UIView!
    @IBOutlet var previewView: UIView!
    @IBOutlet var followGuideLabel: UILabel!
    @IBOutlet var photoTakenAutomaticallyLabel: UILabel!
    @IBOutlet var ledLightLabel: UILabel!
    @IBOutlet var ledLightSwitch: UISwitch!
    @IBOutlet var lightingButton: UIButton!
    @IBOutlet var lightingLabel: UILabel!
    @IBOutlet var lookStraightButton: UIButton!
    @IBOutlet var lookStraightLabel: UILabel!
    @IBOutlet var facePositionButton: UIButton!
    @IBOutlet var faicePositionLabel: UILabel!
    @IBOutlet var guideFaceImageView: UIImageView!
    @IBOutlet var capturedImageView: UIImageView!
    @IBOutlet var rightView: UIView!
    @IBOutlet var middleView: UIView!
    @IBOutlet var leftView: UIView!
    @IBOutlet weak var lblCountDown: UILabel!
    @IBOutlet var TUZonesBackgroundImage: UIImageView!
    @IBOutlet var TZoneStackView: UIStackView!
    @IBOutlet var UZoneStackView: UIStackView!
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var currentMode:DiagnosisMode!
    let defaultButtonColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
    let selectedButtonColor = #colorLiteral(red: 0.9137254902, green: 0.8705882353, blue: 0.5803921569, alpha: 1)
    let analyzedButtonColor = #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)
    var isCameraConfigurationDone:Bool = false
    var skinToneMode:SkinToneMode = .none
    var captureCount = 0
    var ffaRequest = FFARequestModel()
    var captureTime = 2
    var seconds = 3
    var countDownTimer: Timer?
    let configuration = ARFaceTrackingConfiguration()
    var faceNode = SCNNode()
    var leftEye = SCNNode()
    var rightEye = SCNNode()
    lazy var isARCapable = ARFaceTrackingConfiguration.isSupported
    var isFaceLookingFront: Bool = false
    var isFaceLeftSide: Bool = false
    var isFaceRightSide: Bool = false
    var isLightingGood: Bool = false
    var isFacePositionGood: Bool = false
    var isARSceneRunning: Bool = false
    var centerX: CGFloat = 0.0
    var centerY: CGFloat = 0.0
    var centerXAllowance: CGFloat = 30
    var centerYAllowance: CGFloat = 30
    var faceDistanceRangeInCm = 24...40
    lazy var arScene = ARSCNView()
    let albumName = "Chowis Analyzer Selfi"
    var cropImageRect = CGRect()
    var imageView = UIImageView()
    var twoButtonIndicator : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tZoneImageView.isHidden = true
        self.uZoneImageView.isHidden = true
        self.tZoneLeadingConstraint.constant = -10
        self.tZoneBottomConstraint.constant = 10
        self.uZoneLeadingConstraint.constant = -10
        self.uZoneBottomConstraint.constant = 10
                
        self.isWiFiConnected(withBool: false)
        self.defaultUIDesign()
        self.cameraNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cameraInit()
        self.localizeStrings()
    }
    
    override var shouldAutorotate: Bool {
        
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if let videoPreviewLayerConnection = videoPreviewLayer.connection {
            let deviceOrientation = UIDevice.current.orientation
            guard let newVideoOrientation = AVCaptureVideoOrientation(deviceOrientation: deviceOrientation),
                  deviceOrientation.isPortrait || deviceOrientation.isLandscape else {
                return
            }
            
            videoPreviewLayerConnection.videoOrientation = newVideoOrientation
        }
    }
    
    func startCamera() {
        
        self.guideFaceImageView.image = UIImage(named: "guide_front")
        self.captureCount = 0
        self.previewView.isHidden = false
        self.captureSession = AVCaptureSession()
        self.captureSession?.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) else { return }
        
        do {
            
            let input = try AVCaptureDeviceInput(device: backCamera)
            self.stillImageOutput = AVCapturePhotoOutput()
            self.stillImageOutput.isHighResolutionCaptureEnabled = true
            
            if self.captureSession?.canAddInput(input) ?? false && ((captureSession?.canAddOutput(stillImageOutput)) != nil) {
                
                self.captureSession?.addInput(input)
                self.captureSession?.addOutput(stillImageOutput)
                if let captureSession = self.captureSession {
                    self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                }
                
                self.videoPreviewLayer.videoGravity = .resizeAspectFill
                self.videoPreviewLayer.connection?.videoOrientation = .landscapeLeft
                self.previewView.layer.addSublayer(videoPreviewLayer)
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    self.captureSession?.startRunning()
                    
                    DispatchQueue.main.async {
                        
                        self.videoPreviewLayer.frame = self.previewView.bounds
                    }
                }
                
                DispatchQueue.main.async {
                    
                    var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
                    if self.windowOrientation != .unknown {
                        if let videoOrientation = AVCaptureVideoOrientation(interfaceOrientation: self.windowOrientation) {
                            initialVideoOrientation = videoOrientation
                        }
                    }
                    
                    self.videoPreviewLayer.connection?.videoOrientation = initialVideoOrientation
                }
            }
        } catch _  {
            
        }
        
        self.enableScreenTab()
        self.setupAutoCaptureSession(true)
    }
    
    var windowOrientation: UIInterfaceOrientation {
        if #available(iOS 13.0, *) {
            return view.window?.windowScene?.interfaceOrientation ?? .unknown
        } else {
            return .unknown
        }
    }
    
    func enableScreenTab() {
        
        let leftViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(leftViewTapped))
        let middleViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(middleViewTapped))
        let rightViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(rightViewTapped))
        
        self.leftView.addGestureRecognizer(leftViewTapGesture)
        self.middleView.addGestureRecognizer(middleViewTapGesture)
        self.rightView.addGestureRecognizer(rightViewTapGesture)
    }
    
    func disableScreenTab() {
        
        for v in [self.leftView, self.middleView, self.rightView] {
            
            if let recognizers = v?.gestureRecognizers {
                
                for recognizer in recognizers {
                    
                    self.previewView.removeGestureRecognizer(recognizer)
                }
            }
        }
    }
    
    @objc func leftViewTapped() {
        
        self.didCaptureView()
    }
    
    @objc func middleViewTapped() {
        
        self.didCaptureView()
    }
    
    @objc func rightViewTapped() {
        
        self.didCaptureView()
    }
    
    func didCaptureView() {
        
        self.disableScreenTab()
        
        if self.captureCount >= 3 {
            
            return
        }
        
        let photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        self.stillImageOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if CWConnectManager.shared().isConnected() {
            
            CWConnectManager.shared().disconnect(with: self)
        }
        
        self.cameraView.close()
        self.cameraView.stop()
        self.captureSession?.stopRunning()
    }
    
    fileprivate func isWiFiConnected(withBool isAvailable:Bool) {
        
        self.wifiButton.isUserInteractionEnabled = !isAvailable
        if isAvailable
        {  self.wifiButton.tintColor = .systemYellow  }
        else
        {  self.wifiButton.tintColor = .lightGray  }
    }
    
    fileprivate func cameraNotifications() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwVideoPlayerDidStartDecodingNotification(notification:)),
            name: NSNotification.Name(rawValue: CWVideoPlayerDidStartDecoding),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidConectedNotification(notification:)),
            name: NSNotification.Name(rawValue: CWHandSetDidConectedNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidDisconnectedNotification(notification:)),
            name: NSNotification.Name(rawValue: CWHandSetDidDisconnectedNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidErrorNotification(notification:)),
            name: NSNotification.Name(rawValue: CWHandSetDidErrorNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidEofNotification(notification:)),
            name: NSNotification.Name(rawValue: CWHandSetDidEofNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidReceiveBatterySoCNotification(notification:)),
            name: NSNotification.Name(rawValue: CWHandSetDidReceiveBatterySoCNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidPressCameraButtonNotification(notification:)),
            name: NSNotification.Name(rawValue: CWHandSetDidPressCameraButtonNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidPressModeButtonNotification(notification:)),
            name: NSNotification.Name(rawValue: CWHandSetDidPressModeButtonNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetDidChangeVideoStreamingResolutionNotification(notification:)),
            name: NSNotification.Name(rawValue: CWHandSetDidChangeVideoStreamingResolution),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwVideoPlayerFPSNotification(notification:)),
            name:NSNotification.Name.CWVideoPlayerFPS,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetSleepAfter10SecNotification(notification:)),
            name:NSNotification.Name(rawValue: CWHandSetSleepAfter10SecNotify),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cwHandSetSleepAfter1SecNotification(notification:)),
            name:NSNotification.Name(rawValue: CWHandSetSleepAfter1SecNotify),
            object: nil)
    }
    
    fileprivate func cameraInit() {
        
        self.cameraView.open()
        self.cameraView.m_Delegate = self
        
        CWHandSetBroker.shared().setHandSetType(kCWHandSetType_CDP_Skin)
        
        _ = self.connectToDevice()
    }
    
    func connectToDevice() -> Bool {
        
        let optic  = UserDefaults.standard.object(forKey: OPTIC_NUMBER) as? String
        
        if(optic != nil && 0 < optic?.count ?? 0) {
            
            if self.isCNDPConnected() {
                
                let config = CWHandSetBroker.shared().loadHandSetConfiguration(withOpticNumber: optic?.uppercased() ?? "", update:false, delegate:self)
                
                if config == kCWResult_Ok {
                    
                    if(CWConnectManager.shared().isConnected() == false) {
                        
                        self.showActivityIndicator()
                        
                        let isConnectedStream = CWConnectManager.shared().connect(withVideoStreamStart: true, delegate: self)
                        self.isWiFiConnected(withBool: isConnectedStream)
                        if isConnectedStream == false {
                            
                            self.hideActivityIndicator()
                            self.showToastMessageWith(text: "There is no handset connected".localized)
                            
                        } else {
                            
                            self.hideActivityIndicator()
                        }
                        
                    } else {
                        
                        self.isWiFiConnected(withBool: true)
                    }
                } else {
                    
                    ModalController.shared.presentOneButtonMessagePopupViewController(
                        presentingViewController: self,
                        titleText: "NOTICE!".localized,
                        messageText: "Failed to load device configuration. Please try again!".localized,
                        buttonText: "OK".localized)
                }
                
            } else {
                twoButtonIndicator = 0
                ModalController.shared.presentTwoButtonMessagePopupViewController(
                    withTitle: "NOTICE!".localized,
                    message: "You are not connected to the device. Please connect to your device to continue analysis.".localized,
                    leftButtonText: "Connect".localized,
                    rightButtonText: "Cancel".localized,
                    presentingViewController: self,
                    delegate: self)
            }
        }
        
        return CWConnectManager.shared().isConnected()
    }
    
    fileprivate func defaultUIDesign() {
        //self.akinConditionsTZoneLabel.text = "T Zone".localized
        //self.akinConditionsUZoneLabel.text = "U Zone".localized
//        stackView.removeArrangedSubview(CCodePicker)
//        stackView.setNeedsLayout()
//        stackView.layoutIfNeeded()
//        stackView.insertArrangedSubview(CCodePicker, at: 1)
//        stackView.setNeedsLayout()
        let currentLan = defaults.object(forKey: CURRENT_LANGUAGE) as? String ?? "en"
        if currentLan == "he" {
            TUZonesBackgroundImage.image = UIImage(imageLiteralResourceName: "explain")
            TZoneStackView.removeArrangedSubview(self.akinConditionsTZoneLabel)
            TZoneStackView.setNeedsLayout()
            TZoneStackView.layoutIfNeeded()
            TZoneStackView.insertArrangedSubview(akinConditionsTZoneLabel, at: 1)
            TZoneStackView.setNeedsLayout()
            UZoneStackView.removeArrangedSubview(self.akinConditionsUZoneLabel)
            UZoneStackView.setNeedsLayout()
            UZoneStackView.layoutIfNeeded()
            UZoneStackView.insertArrangedSubview(akinConditionsUZoneLabel, at: 1)
            UZoneStackView.setNeedsLayout()
        } else {
            TUZonesBackgroundImage.image = UIImage(imageLiteralResourceName: "explain-reversed")
            TZoneStackView.removeArrangedSubview(self.akinConditionsTZoneLabel)
            TZoneStackView.setNeedsLayout()
            TZoneStackView.layoutIfNeeded()
            TZoneStackView.insertArrangedSubview(akinConditionsTZoneLabel, at: 0)
            TZoneStackView.setNeedsLayout()
            UZoneStackView.removeArrangedSubview(self.akinConditionsUZoneLabel)
            UZoneStackView.setNeedsLayout()
            UZoneStackView.layoutIfNeeded()
            UZoneStackView.insertArrangedSubview(akinConditionsUZoneLabel, at: 0)
            UZoneStackView.setNeedsLayout()
        }
        self.sebumHighLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        self.sebumLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        self.sebumLowLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        self.professionalCapturedImagesCollectionView.layer.cornerRadius = 4
        self.professionalCapturedImagesCollectionView.layer.borderWidth = 1
        self.professionalCapturedImagesCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        self.professionalCapturedImagesCollectionView.backgroundColor = .clear
        
        self.expertCapturedImageCollectionView.layer.cornerRadius = 4
        self.expertCapturedImageCollectionView.layer.borderWidth = 1
        self.expertCapturedImageCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        self.expertCapturedImageCollectionView.backgroundColor = .clear
        
        self.cameraView.layer.borderWidth = 2
        self.cameraView.layer.borderColor = selectedButtonColor.cgColor
        
        self.professionalCameraHolderView.layer.borderWidth = 2
        self.professionalCameraHolderView.layer.borderColor = selectedButtonColor.cgColor
        
        self.professionalCameraImageView.layer.borderWidth = 2
        self.professionalCameraImageView.layer.borderColor = selectedButtonColor.cgColor
        
        self.expertCameraHolderView.layer.borderWidth = 2
        self.expertCameraHolderView.layer.borderColor = selectedButtonColor.cgColor
        
        self.expertCameraImageView.layer.borderWidth = 2
        self.expertCameraImageView.layer.borderColor = selectedButtonColor.cgColor
        
        self.skinToneCameraHolderView.layer.borderWidth = 2
        self.skinToneCameraHolderView.layer.borderColor = selectedButtonColor.cgColor
        
        self.skinToneImageView.layer.borderWidth = 2
        self.skinToneImageView.layer.borderColor = selectedButtonColor.cgColor
        
        self.skinToneSkinColorView.layer.borderWidth = 4
        self.skinToneSkinColorView.layer.borderColor = UIColor.white.cgColor
        
        self.foreheadSkinColorView.layer.borderWidth = 2
        self.foreheadSkinColorView.layer.borderColor = UIColor.darkGray.cgColor
        
        self.cheekSkinColorView.layer.borderWidth = 2
        self.cheekSkinColorView.layer.borderColor = UIColor.darkGray.cgColor
        
        self.chinSkinColorView.layer.borderWidth = 2
        self.chinSkinColorView.layer.borderColor = UIColor.darkGray.cgColor
        
        self.skinToneSkinColorView.layer.masksToBounds = false
        self.skinToneSkinColorView.layer.shadowColor = UIColor.black.cgColor
        self.skinToneSkinColorView.layer.shadowOpacity = 0.2
        self.skinToneSkinColorView.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.skinToneSkinColorView.layer.shadowRadius = 4
        
        for button: UIButton? in [
            
            //self.skinConcernButton,
            self.skinConditionsButton,
            self.poresButton,
            self.spotsButton,
            self.wrinklesButton,
            self.impuritiesButton,
            self.keratinButton,
            self.skinSensitivityButton,
            self.skinToneButton,
            self.blackheadButton] {
            button?.backgroundColor = defaultButtonColor
        }
        
        if defaults.value(forKey: FULL_FACIAL_ANALYSIS) as? Int ?? 0 == 1 {
            self.poresButton.backgroundColor = self.selectedButtonColor
            
            self.poresButtonPressed(self.skinConditionsButton)
            self.skinConditionsButton.isHidden = true
        } else {
            self.skinConditionsButton.isHidden = false
            self.skinConditionsButton.backgroundColor = self.selectedButtonColor
            self.skinConditionsButtonPressed(self.skinConditionsButton)
        }
    }
    
    fileprivate func localizeStrings() {
        
        self.analysisTtitleLabel.text = "ANALYSIS".localized
        
        //self.skinConcernButton.setTitle("Skin Concern".localized, for: .normal)
        self.skinConditionsButton.setTitle("Skin Conditions".localized, for: .normal)
        self.poresButton.setTitle("Pores".localized, for: .normal)
        self.spotsButton.setTitle("Spots".localized, for: .normal)
        self.wrinklesButton.setTitle("Wrinkles".localized, for: .normal)
        self.impuritiesButton.setTitle("Impurities".localized, for: .normal)
        self.keratinButton.setTitle("Keratin".localized, for: .normal)
        
        self.skinConditionsLabel.text = "SKIN CONDITIONS".localized
        self.akinConditionsTZoneLabel.text = "T Zone".localized
        self.akinConditionsUZoneLabel.text = "U Zone".localized
        self.sebumHighLabel.text = "High".localized
        self.sebumLabel.text = "Sebum".localized
        self.sebumLowLabel.text = "Low".localized
        self.moistureDehydratedLabel.text = "Dehydrated".localized
        self.moistureLabel.text = "Moisture".localized
        self.moistureNormalLabel.text = "Normal".localized
        
        self.analyzeButton.setTitle("ANALYZE".localized, for: .normal)
        self.deleteButton.setTitle("DELETE".localized, for: .normal)
        self.expertAnalyzeButton.setTitle("ANALYZE".localized, for: .normal)
        self.expertDeleteButton.setTitle("DELETE".localized, for: .normal)
        
        self.faceDotDescriptionLabel.text = "To capture image tap on the location points.".localized
        self.captureCheckAreaLabel.text = "Capture Cheek Area".localized
        self.autoFocusCameraLabel.text = "Auto Focus Camera".localized
        self.skinToneRetakeButton.setTitle("Retake".localized, for: .normal)
        self.skinToneDoneButton.setTitle("Done".localized, for: .normal)
        self.noMackupButton.setTitle("No makeup".localized, for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for button: UIButton? in [
            //self.skinConcernButton,
            self.skinConditionsButton,
            self.poresButton,
            self.spotsButton,
            self.wrinklesButton,
            self.impuritiesButton,
            self.keratinButton,
            self.skinSensitivityButton,
            self.skinToneButton,
            self.blackheadButton,
            self.analyzeButton,
            self.deleteButton,
            self.expertAnalyzeButton,
            self.expertDeleteButton] {
            
            button?.layer.cornerRadius = button!.frame.size.height / 2
        }
        
        self.skinToneRetakeButton.layer.cornerRadius = self.skinToneRetakeButton.frame.size.height / 2
        self.skinToneDoneButton.layer.cornerRadius = self.skinToneDoneButton.frame.size.height / 2
        self.skinToneRetakeButton.layer.borderWidth = 1
        self.skinToneRetakeButton.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.6235294118, blue: 0.5294117647, alpha: 1).cgColor
        self.womanFaceOButtonYCenterConstraint.constant = -self.womanFaceImageView.frame.size.height / 255 * 60
        self.womanFaceMButtonYCenterConstraint.constant =  (-self.womanFaceImageView.frame.size.height / 155 * 2) + 10
        
        self.womanFaceOButtonXCenterConstraint.constant = self.womanFaceImageView.frame.size.width / 240 * 6
        self.womanFaceMButtonXCenterConstraint.constant = self.womanFaceImageView.frame.size.width / 240 * 36
        
        self.expertDotButtonCenterYConstraint.constant = self.expertWomanFaceImageView.frame.size.height / 185 * 15
        self.expertDotButtonCenterXConstraint.constant = -self.expertWomanFaceImageView.frame.size.width / 138 * 24
        
        self.skinToneForeheadCenterXConstraint.constant = self.skinToneFaceImageView.frame.size.width / 2 * 8 / 154
        self.skinToneForeheadCenterYConstraint.constant = -self.skinToneFaceImageView.frame.size.height / 2 * 94 / 212
        
        self.skinToneCheekCenterXConstraint.constant = self.skinToneFaceImageView.frame.size.width / 2 * 74 / 154
        self.skinToneCheekCenterYConstraint.constant = self.skinToneFaceImageView.frame.size.height / 2 * 31 / 212
        
        self.skinToneChinCenterXConstraint.constant = self.skinToneFaceImageView.frame.size.width / 2 * 10 / 154
        self.skinToneChinCenterYConstraint.constant = self.skinToneFaceImageView.frame.size.height / 2 * 135 / 212
    }
    
    //MARK: - Notifications
    @objc func cwHandSetSleepAfter1SecNotification(notification: NSNotification) {
        print("cwHandSetSleepAfter1SecNotification")
    }
    
    @objc func cwHandSetSleepAfter10SecNotification(notification: NSNotification) {
        print("cwHandSetSleepAfter10SecNotification")
    }
    
    @objc func cwVideoPlayerFPSNotification(notification: NSNotification) {
        print("cwVideoPlayerFPSNotification")
        self.hideActivityIndicator()
    }
    
    @objc func cwHandSetDidChangeVideoStreamingResolutionNotification(notification: NSNotification) {
        print("cwHandSetDidChangeVideoStreamingResolutionNotification")
    }
    
    @objc func cwHandSetDidPressModeButtonNotification(notification: NSNotification) {
        print("cwHandSetDidPressModeButtonNotification")
    }
    
    @objc func cwHandSetDidPressCameraButtonNotification(notification: NSNotification) {
        print("cwHandSetDidPressCameraButtonNotification")
        if(CWConnectManager.shared().isConnected() == false) {
            
            self.hideActivityIndicator()
            return
        }
        
        if currentMode == .skinConditions {
            
            if skinConditionsMButton.isSelected {
                
                self.showActivityIndicator()
                
                self.cameraView.setMode(kCWModeSkinMoisture, skinScalpColorType: DiagnosisInformation.shared.customerSkinScalColorType, ethnicity:DiagnosisInformation.shared.customerEthnicity)
                
            } else {
                
                if(self.cameraView.getState() != kCWVideoPlayerState_Play) {
                    
                    if(self.cameraView.getState() == kCWVideoPlayerState_Pause) {
                        
                        self.cameraView.play()
                        self.addSubViewToContentView(subview: self.cameraHolderView, contentHolderView: self.moistureContentView)
                    }
                    return
                }
                
                self.cameraView.getCapture()
            }
            
            return
        }
        
        if(self.cameraView.getState() != kCWVideoPlayerState_Play) {
            
            if(self.cameraView.getState() == kCWVideoPlayerState_Pause) {
                
                if self.cameraView.getMode() == kCWModeSkinPores && self.currentMode == .blackhead {
                    
                    self.setMode(mode:kCWModeSkinAcne)
                }
                
                self.cameraView.play()
                self.professionalCameraImageView.isHidden = true
                self.expertCameraImageView.isHidden = true
            }
            return
        }
        
        if(self.cameraView.getMode() == kCWModeNone) {
            
            return
        }
        
        self.showActivityIndicator()
        
        let captureResult: CWResult = self.cameraView.getCapture()
        
        if(captureResult == kCWResult_Fail) {
            
            self.hideActivityIndicator()
        }
    }
    
    @objc func cwHandSetDidReceiveBatterySoCNotification(notification: NSNotification) {
        print("cwHandSetDidReceiveBatterySoCNotification")
    }
    
    @objc func cwHandSetDidEofNotification(notification: NSNotification) {
        print("cwHandSetDidEofNotification")
    }
    
    @objc func cwHandSetDidErrorNotification(notification: NSNotification) {
        print("cwHandSetDidErrorNotification")
        self.hideActivityIndicator()
    }
    
    @objc func cwHandSetDidDisconnectedNotification(notification: NSNotification) {
        self.wifiButton.isUserInteractionEnabled = true
        self.wifiButton.tintColor = .lightGray
        print("cwHandSetDidDisconnectedNotification")
    }
    
    @objc func cwHandSetDidConectedNotification(notification: NSNotification) {
        print("cwHandSetDidConectedNotification")
    }
    
    @objc func cwVideoPlayerDidStartDecodingNotification(notification: NSNotification) {
        print("cwVideoPlayerDidStartDecodingNotification")
        self.cameraView.setContinuousServoFocus(onOff: true)
    }
    
    func addSubViewToContentView(subview: UIView, contentHolderView: UIView) {
        
        for contentSubview in contentHolderView.subviews {
            
            contentSubview.removeFromSuperview()
        }
        
        contentHolderView.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.topAnchor.constraint(equalTo: contentHolderView.topAnchor).isActive = true
        subview.leftAnchor.constraint(equalTo: contentHolderView.leftAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: contentHolderView.bottomAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: contentHolderView.rightAnchor).isActive = true
    }
    
    func deleteDiagnosisDataFromArray(diagnosisData: inout [DiagData]) {
        
        var index = 0
        var selectedIndex = 0
        
        for diag in diagnosisData {
            
            if diag.isSelected {
                
                selectedIndex = index
                if self.currentMode == .blackhead {
                    
                    if selectedIndex % 2 == 0 {
                        
                        if diagnosisData.count > selectedIndex + 1 {
                            
                            let firstDelete = Util.shared.deleteImageFromDatabase(fileName: diagnosisData[selectedIndex].originalPath)
                            
                            if firstDelete {
                                
                                diagnosisData.remove(at: selectedIndex)
                            }
                            
                            let secondDelete = Util.shared.deleteImageFromDatabase(fileName: diagnosisData[selectedIndex].originalPath)
                            
                            if secondDelete {
                                
                                diagnosisData.remove(at: selectedIndex)
                            }
                        }
                        
                    } else {
                        
                        if diagnosisData.count > selectedIndex - 1 {
                            
                            let firstDeleted = Util.shared.deleteImageFromDatabase(fileName: diagnosisData[selectedIndex - 1].originalPath)
                            
                            if firstDeleted {
                                
                                diagnosisData.remove(at: selectedIndex - 1)
                            }
                            
                            let secondDeleted = Util.shared.deleteImageFromDatabase(fileName: diagnosisData[selectedIndex - 1].originalPath)
                            
                            if secondDeleted {
                                
                                diagnosisData.remove(at: selectedIndex - 1)
                            }
                        }
                    }
                    
                } else {
                    
                    let deleted = Util.shared.deleteImageFromDatabase(fileName: diag.originalPath)
                    if deleted {
                        
                        diagnosisData.removeAll(where: { $0.isSelected } )
                    }
                }
                
                if(self.shouldEnableAnalyzeButton(diagImages: diagnosisData)) {
                    
                    diagnosisData[diagnosisData.count - 1].isSelected = true
                    self.professionalCameraImageView.image = Util.shared.getImageFromDatabase(fileName: diagnosisData[diagnosisData.count - 1].originalPath)
                    
                } else {
                    
                    if self.cameraView.getState() != kCWVideoPlayerState_Play {
                        
                        if self.cameraView.getMode() == kCWModeSkinPores && self.currentMode == .blackhead {
                            
                            self.setMode(mode:kCWModeSkinAcne)
                        }
                        
                        self.cameraView.play()
                    }
                    
                    self.professionalCameraImageView.isHidden = true
                    self.expertCameraImageView.isHidden = true
                }
                
            } else {
                
                index += 1
            }
        }
    }
    
    @IBAction func skinToneForeheadButtonPressed(_ sender: UIButton) {
        
        self.skinToneForeheadButton.isSelected = true
        self.skinToneMode = .forehead
        
        let connect = self.connectToDevice()
        
        if connect == false {
            
            return
        }
        
        //MARK: - WE NEED SKIN TONE MODE
        self.setMode(mode: kCWModeSkinPores)
    }
    
    @IBAction func skinToneCheekButtonPressed(_ sender: UIButton) {
        
        self.skinToneCheekButton.isSelected = true
        self.skinToneMode = .cheek
        
        let connect = self.connectToDevice()
        
        if connect == false {
            
            return
        }
        
        //MARK: - WE NEED SKIN TONE MODE
        self.setMode(mode: kCWModeSkinPores)
    }
    
    @IBAction func skinToneChinButtonPressed(_ sender: UIButton) {
        
        self.skinToneChinButton.isSelected = true
        self.skinToneMode = .chin
        
        let connect = self.connectToDevice()
        
        if connect == false {
            
            return
        }
        
        //MARK: - WE NEED SKIN TONE MODE
        self.setMode(mode: kCWModeSkinPores)
    }
    
    @IBAction func skinToneForeheadDetailButtonPressed(_ sender: UIButton) {
        
        ModalController.shared.presentSkinToneImagePreviewViewController(presentingViewController: self, skinToneMode: .forehead)
    }
    
    @IBAction func skinToneCheekDetailButtonPressed(_ sender: UIButton) {
        
        ModalController.shared.presentSkinToneImagePreviewViewController(presentingViewController: self, skinToneMode: .cheek)
    }
    
    @IBAction func skinToneChinDetailButtonPressed(_ sender: UIButton) {
        
        ModalController.shared.presentSkinToneImagePreviewViewController(presentingViewController: self, skinToneMode: .chin)
    }
    
    @IBAction func skinToneColorMatchedButtonPressed(_ sender: Any) {
        
        ModalController.shared.presentOverallMatchedViewController(presentingViewController: self)
    }
    
    @IBAction func skinToneDoneButtonPressed(_ sender: Any) {
        
        self.setMode(mode: kCWModeSkinMoisture)
        self.skinToneContentHolderView.isHidden = true
        self.skinToneSkinColorHolderView.isHidden = false
        
        if DiagnosisInformation.shared.skinToneCheeckImage.originalPath.count > 0 {
            
            self.cheekSkinColorView.isHidden = false
            self.cheekSkinColorLineView.isHidden = false
        }
        
        if DiagnosisInformation.shared.skinToneForeheadImage.originalPath.count > 0 {
            
            self.foreheadSkinColorView.isHidden = false
            self.foreheadSkinColorLineView.isHidden = false
        }
        
        if DiagnosisInformation.shared.skinToneChinImage.originalPath.count > 0 {
            
            self.chinSkinColorView.isHidden = false
            self.chinSkinColorLineView.isHidden = false
        }
    }
    
    @IBAction func skinToneRetakeButtonPressed(_ sender: Any) {
        
        self.skinToneImageView.isHidden = true
        if self.cameraView.getState() != kCWVideoPlayerState_Play {
            
            self.cameraView.play()
        }
    }
    
    @IBAction func wifiButtonPressed(_ sender: UIButton) {
        twoButtonIndicator = 0
        ModalController.shared.presentTwoButtonMessagePopupViewController(
            withTitle: "NOTICE!".localized,
            message: "You are not connected to the device. Please connect to your device to continue analysis".localized,
            leftButtonText: "OK".localized,
            rightButtonText: "Cancel".localized,
            presentingViewController: self,
            delegate: self)
    }
    
    @IBAction func modeButtonPressed(_ sender: UIButton) {
        
        if sender.isSelected {
            
            return
        }
        
        for button: UIButton? in [
            //self.skinConcernButton,
            self.skinConditionsButton,
            self.poresButton,
            self.spotsButton,
            self.wrinklesButton,
            self.impuritiesButton,
            self.keratinButton,
            self.skinSensitivityButton,
            self.skinToneButton,
            self.blackheadButton] {
            
            button?.isSelected = false
            button?.backgroundColor = defaultButtonColor
            
        }
        
        if DiagnosisInformation.shared.skinConditionsSebumUZoneScore != -1 && DiagnosisInformation.shared.skinConditionsMoistureTZoneScore != -1 && DiagnosisInformation.shared.skinConditionsSebumTZoneScore != -1 && DiagnosisInformation.shared.skinConditionsMoistureUZoneScore != -1 {
            
            self.skinConditionsButton.backgroundColor = self.analyzedButtonColor
        }
        
        if DiagnosisInformation.shared.poresImages.count > 0 {
            
            self.poresButton.backgroundColor = self.analyzedButtonColor
        }
        
        if DiagnosisInformation.shared.spotsImages.count > 0 {
            
            self.spotsButton.backgroundColor = self.analyzedButtonColor
        }
        
        if DiagnosisInformation.shared.wrinklesImages.count > 0 {
            
            self.wrinklesButton.backgroundColor = self.analyzedButtonColor
        }
        
        if DiagnosisInformation.shared.impuritiesImages.count > 0 {
            
            self.impuritiesButton.backgroundColor = self.analyzedButtonColor
        }
        
        if DiagnosisInformation.shared.keratinImages.count > 0 {
            
            self.keratinButton.backgroundColor = self.analyzedButtonColor
        }
        
        if DiagnosisInformation.shared.skinSensitivityImages.count > 0  {
            
            self.skinSensitivityButton.backgroundColor = self.analyzedButtonColor
        }
        
        if DiagnosisInformation.shared.skinToneScore != -1 {
            
            self.skinToneButton.backgroundColor = self.analyzedButtonColor
        }
        
        if DiagnosisInformation.shared.blackheadImages.count > 0 {
            
            self.blackheadButton.backgroundColor = self.analyzedButtonColor
        }
        
        sender.isSelected = false
        sender.backgroundColor = selectedButtonColor
    }
    
    @IBAction func analyzeButtonPressed(_ sender: Any) {
        twoButtonIndicator = 1
        ModalController.shared.presentTwoButtonMessagePopupViewController(
            withTitle: "NOTICE!".localized,
            message: "Do you want to analyze the taken measurement?".localized,
            leftButtonText: "Analyze All".localized,
            rightButtonText: "Cancel".localized,
            presentingViewController: self,
            delegate: self)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        if self.currentMode == .pores {
            
            self.deleteDiagnosisDataFromArray(diagnosisData: &DiagnosisInformation.shared.poresImages)
            
        } else if self.currentMode == .wrinkles {
            
            self.deleteDiagnosisDataFromArray(diagnosisData: &DiagnosisInformation.shared.wrinklesImages)
            
        } else if self.currentMode == .spots {
            
            self.deleteDiagnosisDataFromArray(diagnosisData: &DiagnosisInformation.shared.spotsImages)
            
        } else if self.currentMode == .impurities {
            
            self.deleteDiagnosisDataFromArray(diagnosisData: &DiagnosisInformation.shared.impuritiesImages)
            
        } else if self.currentMode == .keratin {
            
            self.deleteDiagnosisDataFromArray(diagnosisData: &DiagnosisInformation.shared.keratinImages)
            
        } else if self.currentMode == .skinSensitivity {
            
            self.deleteDiagnosisDataFromArray(diagnosisData: &DiagnosisInformation.shared.skinSensitivityImages)
            
        } else if self.currentMode == .blackhead {
            
            self.deleteDiagnosisDataFromArray(diagnosisData: &DiagnosisInformation.shared.blackheadImages)
        }
        
        self.professionalCapturedImagesCollectionView.reloadData()
        self.expertCapturedImageCollectionView.reloadData()
    }
    
    func setMode(mode: CWMode) {
        
        if mode != kCWModeNone {
            self.captureSession?.stopRunning()
        }
        
        self.skinToneImageView.isHidden = true
        self.professionalCameraImageView.isHidden = true
        self.expertCameraImageView.isHidden = true
        self.showActivityIndicator()
        
        let setModeResult: CWResult = self.cameraView.setMode(mode, skinScalpColorType: DiagnosisInformation.shared.customerSkinScalColorType, ethnicity:DiagnosisInformation.shared.customerEthnicity)
        
        if setModeResult == kCWResult_Fail {
            
            self.hideActivityIndicator()
            self.showToastMessageWith(text: "Failed to set mode")
            
        } else {
            
            if mode == kCWModeNone {
                
                self.hideActivityIndicator()
                return
            }
            
            if CWConnectManager.shared().isConnected() == false  {
                
                self.hideActivityIndicator()
                self.showToastMessageWith(text: "There is no handset connected")
                return
            }
            
            if self.cameraView.getState() == kCWVideoPlayerState_Play {
                
                if mode == kCWModeSkinPores && self.currentMode == .blackhead {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        
                        self.cameraView.getCapture()
                    }
                    
                } else {
                    
                    self.hideActivityIndicator()
                }
                
                return
            }
            
            let playResult:CWResult = self.cameraView.play()
            
            if playResult == kCWResult_Ok {
                
                if mode == kCWModeSkinPores && self.currentMode == .blackhead {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        
                        self.cameraView.getCapture()
                    }
                    
                } else {
                    
                    self.hideActivityIndicator()
                }
                
            } else if playResult == kCWResult_Fail {
                
                self.hideActivityIndicator()
                self.showToastMessageWith(text: "Failed to play the video player.")
            }
        }
    }
    
    func shouldEnableAnalyzeButton(diagImages:[DiagData]) -> Bool {
        
        if diagImages.count > 0 {
            
            for index in 0...diagImages.count - 1 {
                
                diagImages[index].isSelected = false
            }
            
            self.analyzeButton.isEnabled = true
            self.deleteButton.isEnabled = true
            diagImages[diagImages.count - 1].isSelected = true
            
            return true
            
        } else {
            
            self.analyzeButton.isEnabled = false
            self.deleteButton.isEnabled = false
            
            return false
        }
    }
    
    func shouldEnableExpertAnalyzeButton(diagImages:[DiagData]) -> Bool {
        
        if diagImages.count > 0 {
            
            for index in 0...diagImages.count - 1 {
                
                diagImages[index].isSelected = false
            }
            
            self.expertAnalyzeButton.isEnabled = true
            self.expertDeleteButton.isEnabled = true
            diagImages[diagImages.count - 1].isSelected = true
            
            return true
            
        } else {
            
            self.expertAnalyzeButton.isEnabled = false
            self.expertDeleteButton.isEnabled = false
            
            return false
        }
    }
    
    func setProfessionalModeView(button: UIButton) {
        
        self.showActivityIndicator()
        self.addSubViewToContentView(subview: self.professionalContentHolderView, contentHolderView: self.contentView)
        self.modeButtonPressed(button)
        self.addSubViewToContentView(subview: self.cameraHolderView, contentHolderView: self.professionalCameraHolderView)
        self.analysisTtitleLabel.text = button.titleLabel?.text ?? "ANALYSIS".localized
    }
    
    fileprivate func skinToneViewWith(usingMakeUp: Bool) {
        
        
        self.addSubViewToContentView(subview: self.skinToneView, contentHolderView: self.contentView)
        self.addSubViewToContentView(subview: self.cameraHolderView, contentHolderView: self.skinToneCameraHolderView)
        self.modeButtonPressed(self.skinToneButton)
        self.currentMode = DiagnosisMode.skinTone
        self.analysisTtitleLabel.text = "Skin Tone".localized
        
        self.skinToneContentHolderView.isHidden = false
        self.skinToneSkinColorHolderView.isHidden = true
        self.cheekSkinColorView.isHidden = true
        self.cheekSkinColorLineView.isHidden = true
        self.foreheadSkinColorView.isHidden = true
        self.foreheadSkinColorLineView.isHidden = true
        self.chinSkinColorView.isHidden = true
        self.chinSkinColorLineView.isHidden = true
        
        if usingMakeUp {
            
            self.skinToneForeheadButton.isHidden = true
            self.noMackupButton.setTitle("With Makup".localized, for: .normal)
            
        } else {
            
            self.skinToneForeheadButton.isHidden = false
            self.noMackupButton.setTitle("Without Makup".localized, for: .normal)
        }
        
        let connect = self.connectToDevice()
        
        if connect == false {
            
            return
        }
        
        self.setMode(mode: kCWModeSkinMoisture)
    }
    
//    @IBAction func skinConcernButtonPressed(_ sender: UIButton) {
//
//        self.cameraView.setMode(kCWModeSkinMoisture, skinScalpColorType: DiagnosisInformation.shared.customerSkinScalColorType, ethnicity:DiagnosisInformation.shared.customerEthnicity)
//
//        self.startCamera()
//        self.currentMode = DiagnosisMode.skinConcern
//        self.setMode(mode: kCWModeNone)
//        self.modeButtonPressed(self.skinConcernButton)
//        self.addSubViewToContentView(subview: self.faceCameraView, contentHolderView: self.contentView)
//        self.analysisTtitleLabel.text = sender.titleLabel?.text ?? "ANALYSIS".localized
//    }
    
    @IBAction func skinConditionsButtonPressed(_ sender: UIButton) {
        
        let connected = self.connectToDevice()
        
        if connected == false {
            
            self.hideActivityIndicator()
            return
        }
        
        self.setMode(mode: kCWModeSkinMoisture)
        
        self.modeButtonPressed(self.skinConditionsButton)
        self.addSubViewToContentView(subview: self.skinConditionView, contentHolderView: self.contentView)
        self.addSubViewToContentView(subview: self.moistureGraphView, contentHolderView: self.moistureContentView)
        self.currentMode = DiagnosisMode.beginSkinConditions
        
        if DiagnosisInformation.shared.skinConditionsSebumUZoneScore != -1 && DiagnosisInformation.shared.skinConditionsMoistureTZoneScore != -1 && DiagnosisInformation.shared.skinConditionsSebumTZoneScore != -1 && DiagnosisInformation.shared.skinConditionsMoistureUZoneScore != -1 {
            
            self.skinConditionsAnalyzeButton.isEnabled = true
            
        } else {
            
            self.skinConditionsAnalyzeButton.isEnabled = false
        }
        
        self.skinConditionsWomanFaceOButton.isSelected = false
        self.skinConditionsWomanFaceMButton.isSelected = true
        self.skinConditionsMButton.isSelected = true
        self.skinConditionsOButton.isSelected = false
        self.professionalCapturedImagesCollectionView.reloadData()
        
        self.analysisTtitleLabel.text = sender.titleLabel?.text ?? "ANALYSIS".localized
        
//        let shouldShowMoistureGuide = defaults.value(forKey: SHOULD_SHOW_MOISTURE_GUIDE) as? Bool ?? true
//        if shouldShowMoistureGuide {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isMoisture: true)
//        }
    }
    
    @IBAction func poresButtonPressed(_ sender: UIButton) {
        
       // let shouldShowPoresGuide = defaults.value(forKey: SHOULD_SHOW_PORES_GUIDE) as? Bool ?? true
//        if shouldShowPoresGuide {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isPores: true)
//        }
        
        self.setProfessionalModeView(button: sender)
        self.currentMode = DiagnosisMode.pores
        
        _ = self.shouldEnableAnalyzeButton(diagImages: DiagnosisInformation.shared.poresImages)
        self.professionalCapturedImagesCollectionView.reloadData()
        
        let connected = self.connectToDevice()
        
        if connected == true {
            
            self.hideActivityIndicator()
            self.setMode(mode: kCWModeSkinPores)
        }
    }
    
    @IBAction func spotsButtonPressed(_ sender: UIButton) {
        
//        let shouldShowSpotsGuide = defaults.value(forKey: SHOULD_SHOW_SPOTS_GUIDE) as? Bool ?? true
//        if shouldShowSpotsGuide {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isSpots: true)
//        }
        self.setProfessionalModeView(button: sender)
        self.currentMode = DiagnosisMode.spots
        
        _ = self.shouldEnableAnalyzeButton(diagImages: DiagnosisInformation.shared.spotsImages)
        self.professionalCapturedImagesCollectionView.reloadData()
        
        let connected = self.connectToDevice()
        
        if connected == false {
            
            self.hideActivityIndicator()
            return
        }
        
        self.setMode(mode: kCWModeSkinSpots)
    }
    
    @IBAction func impuritiesButtonPressed(_ sender: UIButton) {
        
//        let shouldShowImpuritiesGuide = defaults.value(forKey: SHOULD_SHOW_IMPURITIES_GUIDE) as? Bool ?? true
//        if shouldShowImpuritiesGuide {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isImpurities: true)
//        }
        
        self.setProfessionalModeView(button: sender)
        self.currentMode = DiagnosisMode.impurities
        
        _ = self.shouldEnableAnalyzeButton(diagImages: DiagnosisInformation.shared.impuritiesImages)
        self.professionalCapturedImagesCollectionView.reloadData()
        
        let connected = self.connectToDevice()
        
        if connected == false {
            
            self.hideActivityIndicator()
            return
        }
        
        self.setMode(mode: kCWModeSkinAcne)
    }
    
    @IBAction func wrinklesButtonPressed(_ sender: UIButton) {
        
//        let shouldShowWrinklesGuide = defaults.value(forKey: SHOULD_SHOW_WRINKLES_GUIDE) as? Bool ?? true
//        if shouldShowWrinklesGuide {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isWrinkles: true)
//        }
        
        self.setProfessionalModeView(button: sender)
        self.currentMode = DiagnosisMode.wrinkles
        
        _ = self.shouldEnableAnalyzeButton(diagImages: DiagnosisInformation.shared.wrinklesImages)
        self.professionalCapturedImagesCollectionView.reloadData()
        
        let connected = self.connectToDevice()
        
        if connected == false {
            
            self.hideActivityIndicator()
            return
        }
        
        self.setMode(mode: kCWModeSkinWrinkles)
    }
    
    @IBAction func keratinButtonPressed(_ sender: UIButton) {
        
//        let shouldShowKeratinGuide = defaults.value(forKey: SHOULD_SHOW_KERATIN_GUIDE) as? Bool ?? true
//        if shouldShowKeratinGuide {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isKeratin: true)
//        }
        
        self.setProfessionalModeView(button: sender)
        self.currentMode = DiagnosisMode.keratin
        
        _ = self.shouldEnableAnalyzeButton(diagImages: DiagnosisInformation.shared.keratinImages)
        self.professionalCapturedImagesCollectionView.reloadData()
        
        let connected = self.connectToDevice()
        
        if connected == false {
            
            self.hideActivityIndicator()
            return
        }
        
        self.setMode(mode: kCWModeSkinKeratin)
    }
    
    @IBAction func skinSensitivityButtonPressed(_ sender: UIButton) {
        
        self.addSubViewToContentView(subview: self.expertContentHolderView, contentHolderView: self.contentView)
        self.addSubViewToContentView(subview: self.cameraHolderView, contentHolderView: self.expertCameraHolderView)
        self.modeButtonPressed(self.skinSensitivityButton)
        self.currentMode = DiagnosisMode.skinSensitivity
        _ = self.shouldEnableExpertAnalyzeButton(diagImages: DiagnosisInformation.shared.skinSensitivityImages)
        self.expertCapturedImageCollectionView.reloadData()
        self.analysisTtitleLabel.text = sender.titleLabel?.text ?? "ANALYSIS".localized
        
        let connect = self.connectToDevice()
        
        if connect == false {
            
            return
        }
        
        self.setMode(mode: kCWModeSkinSpots)
    }
    
    @IBAction func skinToneButtonPressed(_ sender: UIButton) {
        
        ModalController.shared.presentSkinToneQuestionnaireViewController(presentingViewController: self, delegate: self)
    }
    
    @IBAction func blackheadButtonPressed(_ sender: UIButton) {
        
        self.addSubViewToContentView(subview: self.expertContentHolderView, contentHolderView: self.contentView)
        self.addSubViewToContentView(subview: self.cameraHolderView, contentHolderView: self.expertCameraHolderView)
        self.modeButtonPressed(self.blackheadButton)
        self.currentMode = DiagnosisMode.blackhead
        _ = self.shouldEnableExpertAnalyzeButton(diagImages: DiagnosisInformation.shared.blackheadImages)
        self.expertCapturedImageCollectionView.reloadData()
        self.analysisTtitleLabel.text = sender.titleLabel?.text ?? "ANALYSIS".localized
        
        let connect = self.connectToDevice()
        
        if connect == false {
            
            return
        }
        
        self.setMode(mode: kCWModeSkinAcne)
    }
    
    @IBAction func womanFaceMButtonPressed(_ sender: UIButton) {
        
        self.skinConditionsWomanFaceOButton.isSelected = true
        self.skinConditionsWomanFaceMButton.isSelected = false
        
        if self.skinConditionsOButton.isSelected {
            
            self.addSubViewToContentView(subview: self.cameraHolderView, contentHolderView: self.moistureContentView)
            self.setMode(mode: kCWModeSkinSebum)
        }
    }
    
    @IBAction func womanFaceOButtonPressed(_ sender: Any) {
        
        self.skinConditionsWomanFaceOButton.isSelected = false
        self.skinConditionsWomanFaceMButton.isSelected = true
        
        if self.skinConditionsOButton.isSelected {
            
            self.addSubViewToContentView(subview: self.cameraHolderView, contentHolderView: self.moistureContentView)
            self.setMode(mode: kCWModeSkinSebum)
        }
    }
    
    @IBAction func skinConditionsMButtonPressed(_ sender: Any) {
        
//        let shouldShowMoistureGuide = defaults.value(forKey: SHOULD_SHOW_MOISTURE_GUIDE) as? Bool ?? true
//        if shouldShowMoistureGuide {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isMoisture: true)
//        }
        
        self.skinConditionsWomanFaceOButton.isSelected = false
        self.skinConditionsWomanFaceMButton.isSelected = true
        self.skinConditionsMButton.isSelected = true
        self.skinConditionsOButton.isSelected = false
        
        self.addSubViewToContentView(subview: self.moistureGraphView, contentHolderView: self.moistureContentView)
    }
    
    @IBAction func skinConditionsOButtonPressed(_ sender: Any) {
        
//        let shouldShowSebumGuide = defaults.value(forKey: SHOULD_SHOW_SEBUM_GUIDE) as? Bool ?? true
//        if shouldShowSebumGuide {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isSebum: true)
//        }
        
        self.skinConditionsWomanFaceOButton.isSelected = false
        self.skinConditionsWomanFaceMButton.isSelected = true
        self.skinConditionsMButton.isSelected = false
        self.skinConditionsOButton.isSelected = true
        
        self.addSubViewToContentView(subview: self.cameraHolderView, contentHolderView: self.moistureContentView)
        self.setMode(mode: kCWModeSkinSebum)
    }
    
    @IBAction func expertAnalysisDownButtonPressed(_ sender: Any) {
        
        self.menuScrollView.scrollRectToVisible(self.expertMenuView.frame, animated: true)
    }
    
    @IBAction func professionalDiagnosisUpButtonPressed(_ sender: Any) {
        
        self.menuScrollView.scrollRectToVisible(self.professionalMenuView.frame, animated: true)
    }
    
    @IBAction func showSebumGuideButtonPressed(_ sender: Any) {
        
        if self.skinConditionsOButton.isSelected {
            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isSebum: true)
        } else if self.skinConditionsMButton.isSelected {
            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isMoisture: true)
        }
    }
    
//    @IBAction func otherGuideButtonPressed(_ sender: Any) {
//
//        if self.currentMode == DiagnosisMode.pores {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isPores: true)
//        } else if self.currentMode == DiagnosisMode.spots {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isSpots: true)
//        } else if self.currentMode == DiagnosisMode.wrinkles {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isWrinkles: true)
//        } else if self.currentMode == DiagnosisMode.impurities {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isImpurities: true)
//        } else if self.currentMode == DiagnosisMode.keratin {
//            ModalController.shared.presentSebumGuideVC(presentingViewController: self, isKeratin: true)
//        }
//    }
}

extension DiagnosisViewController {
    func changeGradientColor(colours: [UIColor]) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.masksToBounds = false
//        self.clipsToBounds = true
        
        return gradient
    }
}

extension DiagnosisViewController: TwoButtonMessagePopupViewControllerDelegate {
    
    func didSelectTwoButtonMessagePopupViewControllerLeftButtonPressed() {
        if twoButtonIndicator == 0 {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else
            {  return }
            if UIApplication.shared.canOpenURL(settingsUrl) { UIApplication.shared.open(settingsUrl, completionHandler: { (_) in
                })
            }
        } else {
            self.performSegue(withIdentifier: "GoToAnalysisVC", sender: self)
        }
    }
    
    func didSelectTwoButtonMessagePopupViewControllerRightButtonPressed() {
        
    }
}

extension DiagnosisViewController: SkinToneQuestionnaireViewControllerDelegate {
    
    func didSelectSkinToneQuestionnaireViewControllerYesButtonPressed() {
        
        self.skinToneViewWith(usingMakeUp: true)
    }
    
    func didSelectSkinToneQuestionnaireViewControllerNoButtonPressed() {
        
        self.skinToneViewWith(usingMakeUp: false)
    }
}

extension DiagnosisViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.professionalCapturedImagesCollectionView {
            
            if self.currentMode == DiagnosisMode.pores {
                
                return DiagnosisInformation.shared.poresImages.count
                
            } else if self.currentMode == DiagnosisMode.spots {
                
                return DiagnosisInformation.shared.spotsImages.count
                
            } else if self.currentMode == DiagnosisMode.wrinkles {
                
                return DiagnosisInformation.shared.wrinklesImages.count
                
            } else if self.currentMode == DiagnosisMode.impurities {
                
                return DiagnosisInformation.shared.impuritiesImages.count
                
            } else if self.currentMode == DiagnosisMode.keratin {
                
                return DiagnosisInformation.shared.keratinImages.count
                
            } else {
                
                return 0
            }
            
        } else if collectionView == self.expertCapturedImageCollectionView {
            
            if self.currentMode == .skinSensitivity {
                
                return DiagnosisInformation.shared.skinSensitivityImages.count
                
            } else if self.currentMode == .blackhead {
                
                return DiagnosisInformation.shared.blackheadImages.count
                
            } else {
                
                return 0
            }
            
        } else {
            
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CapturedImagesCollectionViewCell", for: indexPath) as? CapturedImagesCollectionViewCell {
            
            if collectionView == self.professionalCapturedImagesCollectionView {
                
                var diag = DiagData()
                
                if currentMode == DiagnosisMode.pores {
                    
                    diag = DiagnosisInformation.shared.poresImages[indexPath.item]
                    
                } else if currentMode == DiagnosisMode.spots {
                    
                    diag = DiagnosisInformation.shared.spotsImages[indexPath.item]
                    
                } else if currentMode == DiagnosisMode.wrinkles {
                    
                    diag = DiagnosisInformation.shared.wrinklesImages[indexPath.item]
                    
                } else if currentMode == DiagnosisMode.impurities {
                    
                    diag = DiagnosisInformation.shared.impuritiesImages[indexPath.item]
                    
                } else if currentMode == DiagnosisMode.keratin {
                    
                    diag = DiagnosisInformation.shared.keratinImages[indexPath.item]
                }
                
                let image = Util.shared.getImageFromDatabase(fileName: diag.originalPath)
                
                cell.capturedImageView.image = image
                
                if diag.isSelected {
                    
                    cell.capturedImageView.layer.borderWidth = 2
                    //cell.capturedImageView.layer.borderColor = selectedButtonColor.cgColor
                    
                } else {
                    
                    cell.capturedImageView.layer.borderWidth = 0
                    cell.capturedImageView.layer.borderColor = UIColor.clear.cgColor
                }
                
                return cell
                
            } else if collectionView == self.expertCapturedImageCollectionView {
                
                if self.currentMode == .skinSensitivity {
                    
                    let diag = DiagnosisInformation.shared.skinSensitivityImages[indexPath.item]
                    
                    let image = Util.shared.getImageFromDatabase(fileName: diag.originalPath)
                    cell.capturedImageView.image = image
                    
                    if diag.isSelected {
                        
                        cell.capturedImageView.layer.borderWidth = 2
                     //   cell.capturedImageView.layer.borderColor = selectedButtonColor.cgColor
                        
                    } else {
                        
                        cell.capturedImageView.layer.borderWidth = 0
                        cell.capturedImageView.layer.borderColor = UIColor.clear.cgColor
                    }
                    
                } else if self.currentMode == .blackhead {
                    
                    let diag = DiagnosisInformation.shared.blackheadImages[indexPath.item]
                    
                    let image = Util.shared.getImageFromDatabase(fileName: diag.originalPath)
                    cell.capturedImageView.image = image
                    
                    if diag.isSelected {
                        
                        cell.capturedImageView.layer.borderWidth = 2
                        cell.capturedImageView.layer.borderColor = selectedButtonColor.cgColor
                        
                    } else {
                        
                        cell.capturedImageView.layer.borderWidth = 0
                        cell.capturedImageView.layer.borderColor = UIColor.clear.cgColor
                    }
                }
                
                return cell
                
            } else {
                
                return CapturedImagesCollectionViewCell()
            }
            
        } else {
            
            return CapturedImagesCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.professionalCapturedImagesCollectionView {
            
            if currentMode == .pores {
                
                for index in 0...DiagnosisInformation.shared.poresImages.count - 1 {
                    
                    DiagnosisInformation.shared.poresImages[index].isSelected = false
                }
                
                DiagnosisInformation.shared.poresImages[indexPath.item].isSelected = true
                self.professionalCameraImageView.image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.poresImages[indexPath.item].originalPath)
                self.cameraView.pause()
                self.professionalCameraImageView.isHidden = false
                
            } else if currentMode == .spots {
                
                for index in 0...DiagnosisInformation.shared.spotsImages.count - 1 {
                    
                    DiagnosisInformation.shared.spotsImages[index].isSelected = false
                }
                
                DiagnosisInformation.shared.spotsImages[indexPath.item].isSelected = true
                self.professionalCameraImageView.image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.spotsImages[indexPath.item].originalPath)
                self.cameraView.pause()
                self.professionalCameraImageView.isHidden = false
                
            } else if currentMode == .wrinkles {
                
                for index in 0...DiagnosisInformation.shared.wrinklesImages.count - 1 {
                    
                    DiagnosisInformation.shared.wrinklesImages[index].isSelected = false
                }
                
                DiagnosisInformation.shared.wrinklesImages[indexPath.item].isSelected = true
                self.professionalCameraImageView.image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.wrinklesImages[indexPath.item].originalPath)
                self.cameraView.pause()
                self.professionalCameraImageView.isHidden = false
                
            } else if currentMode == .impurities {
                
                for index in 0...DiagnosisInformation.shared.impuritiesImages.count - 1 {
                    
                    DiagnosisInformation.shared.impuritiesImages[index].isSelected = false
                }
                
                DiagnosisInformation.shared.impuritiesImages[indexPath.item].isSelected = true
                self.professionalCameraImageView.image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.impuritiesImages[indexPath.item].originalPath)
                self.cameraView.pause()
                self.professionalCameraImageView.isHidden = false
                
            } else if currentMode == .keratin {
                
                for index in 0...DiagnosisInformation.shared.keratinImages.count - 1 {
                    
                    DiagnosisInformation.shared.keratinImages[index].isSelected = false
                }
                
                DiagnosisInformation.shared.keratinImages[indexPath.item].isSelected = true
                self.professionalCameraImageView.image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.keratinImages[indexPath.item].originalPath)
                self.cameraView.pause()
                self.professionalCameraImageView.isHidden = false
            }
            
            self.professionalCapturedImagesCollectionView.reloadData()
            
        } else if collectionView == self.expertCapturedImageCollectionView {
            
            if self.currentMode == .skinSensitivity {
                
                for index in 0...DiagnosisInformation.shared.skinSensitivityImages.count - 1 {
                    
                    DiagnosisInformation.shared.skinSensitivityImages[index].isSelected = false
                }
                
                DiagnosisInformation.shared.skinSensitivityImages[indexPath.item].isSelected = true
                self.expertCameraImageView.image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.skinSensitivityImages[indexPath.item].originalPath)
                self.cameraView.pause()
                self.expertCameraImageView.isHidden = false
                
            } else if self.currentMode == .blackhead {
                
                for index in 0...DiagnosisInformation.shared.blackheadImages.count - 1 {
                    
                    DiagnosisInformation.shared.blackheadImages[index].isSelected = false
                }
                
                DiagnosisInformation.shared.blackheadImages[indexPath.item].isSelected = true
                self.expertCameraImageView.image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.blackheadImages[indexPath.item].originalPath)
                self.cameraView.pause()
                self.expertCameraImageView.isHidden = false
            }
            
            self.expertCapturedImageCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.frame.height * 640 / 480, height: collectionView.frame.height)
    }
}

extension DiagnosisViewController: CWVideoPlayerDelegate {
    
    //MARK: - CWVideoPlayerDelegate
    func cwVideoPlayer(_ videoPlayer: CWVideoPlayer, didSuccessSetMode mode: CWMode, skinScalpColorType: CWSkinScalpColorType, ethnicity: CWEthnicity) {
        
    }
    
    func cwVideoPlayer(_ videoPlayer: CWVideoPlayer, didFailSetMode mode: CWMode, skinScalpColorType: CWSkinScalpColorType, ethnicity: CWEthnicity) {
        
        self.hideActivityIndicator()
    }
    
    func cwVideoPlayerDidSuccessSingleServoFocus(_ videoPlayer: CWVideoPlayer) {
        
    }
    
    func cwVideoPlayerDidFailSingleServoFocus(_ videoPlayer: CWVideoPlayer) {
        
    }
    
    func cwVideoPlayer(_ videoPlayer: CWVideoPlayer, didSuccessContinuousServoFocus bOn: Bool) {
        
        self.hideActivityIndicator()
    }
    
    func cwVideoPlayer(_ videoPlayer: CWVideoPlayer, didFailContinuousServoFocus bOn: Bool) {
        
        self.hideActivityIndicator()
    }
    
    func cwVideoPlayer(_ videoPlayer: CWVideoPlayer, didSuccessReceiveMoistureValue value: Int) {
        
        if currentMode != .skinConditions {
            
            if currentMode == .beginSkinConditions {
                
                currentMode = .skinConditions
            }
            
            return
        }
        
        
        if self.skinConditionsMButton.isSelected {
            
            if skinConditionsWomanFaceOButton.isSelected {
                
                DispatchQueue.main.async {
                    //DiagnosisInformation.shared.skinConditionsOZone.append(image)
                    DiagnosisInformation.shared.skinConditionsMoistureUZoneScores.append(value)
                    
                    var total = 0
                    for value in DiagnosisInformation.shared.skinConditionsMoistureUZoneScores {
                        
                        total += value
                    }
                    
                    DiagnosisInformation.shared.skinConditionsMoistureUZoneScore = total / DiagnosisInformation.shared.skinConditionsMoistureUZoneScores.count
                    
                    self.uZoneLeadingConstraint.constant = self.moistureGraphImageView.frame.size.width / 100 * CGFloat(DiagnosisInformation.shared.skinConditionsMoistureUZoneScore) - 10
                    self.uZoneImageView.isHidden = false
                    
                    self.skinConditionsUZoneResultLabel.text = Util.shared.getDescriptionShineMoistureValue(moistureValue: DiagnosisInformation.shared.skinConditionsMoistureUZoneScore, oilValue: DiagnosisInformation.shared.skinConditionsSebumUZoneScore)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    
                    DiagnosisInformation.shared.skinConditionsMoistureTZoneScores.append(value)
                    
                    var total = 0
                    for value in DiagnosisInformation.shared.skinConditionsMoistureTZoneScores {
                        
                        total += value
                    }
                    
                    DiagnosisInformation.shared.skinConditionsMoistureTZoneScore = total / DiagnosisInformation.shared.skinConditionsMoistureTZoneScores.count
                    
                    self.tZoneLeadingConstraint.constant = self.moistureGraphImageView.frame.size.width / 100 * CGFloat(DiagnosisInformation.shared.skinConditionsMoistureTZoneScore) - 10
                    self.tZoneImageView.isHidden = false
                    
                    self.skinConditionsTZoneResultLabel.text = Util.shared.getDescriptionShineMoistureValue(moistureValue: DiagnosisInformation.shared.skinConditionsMoistureTZoneScore, oilValue: DiagnosisInformation.shared.skinConditionsSebumTZoneScore)
                }
            }
        }
    }
    
    func cwVideoPlayerDidFailReceiveMoisture(_ videoPlayer: CWVideoPlayer) {
        
        self.hideActivityIndicator()
    }
    
    func cwVideoPlayer(_ videoPlayer: CWVideoPlayer, didSuccessReceiveSnapShot image: UIImage) {
        
        self.hideActivityIndicator()
        
        if(self.cameraView.getState() == kCWVideoPlayerState_Play) {
            
            self.cameraView.pause()
        }
        
        if self.currentMode == .skinTone {
            
            self.skinToneImageView.image = image
            self.skinToneImageView.isHidden = false
            
        } else if currentMode == .skinSensitivity || currentMode == .blackhead {
            
            self.expertCameraImageView.image = image
            self.expertCameraImageView.isHidden = false
            
        } else {
            
            self.professionalCameraImageView.image = image
            self.professionalCameraImageView.isHidden = false
        }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        let dateString = dateFormatterGet.string(from: Date())
        let baseName = String(format: "%@_%d_%d_%@", currentMode.rawValue, DiagnosisInformation.shared.customerEthnicity.rawValue, DiagnosisInformation.shared.customerSkinScalColorType.rawValue, dateString)
//
        let fileName = "\(baseName).jpg"
        let analyzedFileName = "\(baseName)_ANALYZED.jpg"
        let threeDFileName = "\(baseName)_3D.jpg"
        let wrinkleUltraImageFile = "\(baseName)_WRINKLE_ULTRA_IMAGE_FILE.jpg"
        let wrinkleFineImageFile = "\(baseName)_WRINKLE_FINE_IMAGE_FILE.jpg"
        let wrinkleDeepImageFile = "\(baseName)_WRINKLE_DEEP_IMAGE_FILE.jpg"
        let wrinkleVeryDeepImageFile = "\(baseName)_WRINKLE_VERY_DEEP_IMAGE_FILE.jpg"
        
//        let fileName = "\(String(describing: currentMode))_\(DiagnosisInformation.shared.customerEthnicity)_\(DiagnosisInformation.shared.customerSkinScalColorType)_\(Date()).jpg"
//        let analyzedFileName = "\(String(describing: currentMode))_\(DiagnosisInformation.shared.customerEthnicity)_\(DiagnosisInformation.shared.customerSkinScalColorType)_\(Date())_ANALYZED.jpg"
//        let threeDFileName = "\(String(describing: currentMode))_\(DiagnosisInformation.shared.customerEthnicity)_\(DiagnosisInformation.shared.customerSkinScalColorType)_\(Date())_3D.jpg"
//
//        let wrinkleUltraImageFile = "\(String(describing: currentMode))_\(DiagnosisInformation.shared.customerEthnicity)_\(DiagnosisInformation.shared.customerSkinScalColorType)_\(Date())_WRINKLE_ULTRA_IMAGE_FILE.jpg"
//
//        let wrinkleFineImageFile = "\(String(describing: currentMode))_\(DiagnosisInformation.shared.customerEthnicity)_\(DiagnosisInformation.shared.customerSkinScalColorType)_\(Date())_WRINKLE_FINE_IMAGE_FILE.jpg"
//
//        let wrinkleDeepImageFile = "\(String(describing: currentMode))_\(DiagnosisInformation.shared.customerEthnicity)_\(DiagnosisInformation.shared.customerSkinScalColorType)_\(Date())_WRINKLE_DEEP_IMAGE_FILE.jpg"
//
//        let wrinkleVeryDeepImageFile = "\(String(describing: currentMode))_\(DiagnosisInformation.shared.customerEthnicity)_\(DiagnosisInformation.shared.customerSkinScalColorType)_\(Date())_WRINKLE_VERY_DEEP_IMAGE_FILE.jpg"
//
        
        let savedImage = Util.shared.saveImageToDatabase(image: image, fileName: fileName)
        let diag = DiagData()
        
        if savedImage {
            
            diag.originalPath = fileName
            diag.analyzedPath = analyzedFileName
            diag.threeDPath = threeDFileName
            diag.currentPath = analyzedFileName
            diag.wrinkleUltraImageFile = wrinkleUltraImageFile
            diag.wrinkleFineImageFile = wrinkleFineImageFile
            diag.wrinkleDeepImageFile = wrinkleDeepImageFile
            diag.wrinkleVeryDeepImageFile = wrinkleVeryDeepImageFile
        }
        
        if currentMode == .pores {
            if DiagnosisInformation.shared.poresImages.count < 5 {
                DiagnosisInformation.shared.poresImages.append(diag)
                
                for index in 0...DiagnosisInformation.shared.poresImages.count - 1 {
                    
                    DiagnosisInformation.shared.poresImages[index].isSelected = false
                }
                
                DiagnosisInformation.shared.poresImages[DiagnosisInformation.shared.poresImages.count - 1].isSelected = true
            }
            
        } else if currentMode == .spots {
            if DiagnosisInformation.shared.spotsImages.count < 5 {
            DiagnosisInformation.shared.spotsImages.append(diag)
            
            for index in 0...DiagnosisInformation.shared.spotsImages.count - 1 {
                
                DiagnosisInformation.shared.spotsImages[index].isSelected = false
            }
            
            DiagnosisInformation.shared.spotsImages[DiagnosisInformation.shared.spotsImages.count - 1].isSelected = true
            }
        } else if currentMode == .wrinkles {
            if DiagnosisInformation.shared.wrinklesImages.count < 5 {
            DiagnosisInformation.shared.wrinklesImages.append(diag)
            
            for index in 0...DiagnosisInformation.shared.wrinklesImages.count - 1 {
                
                DiagnosisInformation.shared.wrinklesImages[index].isSelected = false
            }
            
            DiagnosisInformation.shared.wrinklesImages[DiagnosisInformation.shared.wrinklesImages.count - 1].isSelected = true
            }
        } else if currentMode == .impurities {
            if DiagnosisInformation.shared.impuritiesImages.count < 5 {
            DiagnosisInformation.shared.impuritiesImages.append(diag)
            
            for index in 0...DiagnosisInformation.shared.impuritiesImages.count - 1 {
                
                DiagnosisInformation.shared.impuritiesImages[index].isSelected = false
            }
            
            DiagnosisInformation.shared.impuritiesImages[DiagnosisInformation.shared.impuritiesImages.count - 1].isSelected = true
            }
        } else if currentMode == .keratin {
            if DiagnosisInformation.shared.keratinImages.count < 5 {
            DiagnosisInformation.shared.keratinImages.append(diag)
            
            for index in 0...DiagnosisInformation.shared.keratinImages.count - 1 {
                
                DiagnosisInformation.shared.keratinImages[index].isSelected = false
            }
            
            DiagnosisInformation.shared.keratinImages[DiagnosisInformation.shared.keratinImages.count - 1].isSelected = true
            }
        } else if currentMode == .skinConditions {
            
            let analysisResult: CWAnalysisResult = CWImageAnalysis.shared().skinSebum(withInputImage: image)
            
            if self.cameraView.getState() == kCWVideoPlayerState_Play {
                
                self.cameraView.pause()
            }
            
            self.addSubViewToContentView(subview: self.moistureGraphView, contentHolderView: self.moistureContentView)
            
            if self.skinConditionsOButton.isSelected {
                
                let value = analysisResult.m_AnalyzedNormalizedValue
                
                if skinConditionsWomanFaceOButton.isSelected {
                    DiagnosisInformation.shared.sebumUZoneimages.append(diag)
                    DiagnosisInformation.shared.skinConditionsSebumUZoneScores.append(value)
                    
                    var total = 0
                    for value in DiagnosisInformation.shared.skinConditionsSebumUZoneScores {
                        
                        total += value
                    }
                    
                    DiagnosisInformation.shared.skinConditionsSebumUZoneScore = total / DiagnosisInformation.shared.skinConditionsSebumUZoneScores.count
                    
                    self.uZoneBottomConstraint.constant = -self.moistureGraphImageView.frame.size.height / 100 * CGFloat(DiagnosisInformation.shared.skinConditionsSebumUZoneScore) + 10
                    self.uZoneImageView.isHidden = false
                    
                    self.skinConditionsUZoneResultLabel.text = Util.shared.getDescriptionShineMoistureValue(moistureValue: DiagnosisInformation.shared.skinConditionsMoistureUZoneScore, oilValue: DiagnosisInformation.shared.skinConditionsSebumUZoneScore)
                    
                } else {
                    DiagnosisInformation.shared.sebumTZoneImages.append(diag)
                    DiagnosisInformation.shared.skinConditionsSebumTZoneScores.append(value)
                    
                    var total = 0
                    for value in DiagnosisInformation.shared.skinConditionsSebumTZoneScores {
                        
                        total += value
                    }
                    
                    DiagnosisInformation.shared.skinConditionsSebumTZoneScore = total / DiagnosisInformation.shared.skinConditionsSebumTZoneScores.count
                    
                    self.tZoneBottomConstraint.constant = -self.moistureGraphImageView.frame.size.height / 100 * CGFloat(DiagnosisInformation.shared.skinConditionsSebumTZoneScore) + 10
                    self.tZoneImageView.isHidden = false
                    
                    self.skinConditionsTZoneResultLabel.text = Util.shared.getDescriptionShineMoistureValue(moistureValue: DiagnosisInformation.shared.skinConditionsMoistureTZoneScore, oilValue: DiagnosisInformation.shared.skinConditionsSebumTZoneScore)
                }
                
                if DiagnosisInformation.shared.skinConditionsSebumTZoneScore >= 0 && DiagnosisInformation.shared.skinConditionsSebumUZoneScore >= 0 {
                    
                    self.skinConditionsResultLabel.isHidden = false
                    self.skinConditionsResultLabel.text = Util.shared.calcSkinTypeWithValueT(valueT: DiagnosisInformation.shared.skinConditionsSebumTZoneScore, U: DiagnosisInformation.shared.skinConditionsSebumUZoneScore)
                }
            }
            
        } else if currentMode == .skinSensitivity {
            if DiagnosisInformation.shared.skinSensitivityImages.count < 5 {
                DiagnosisInformation.shared.skinSensitivityImages.append(diag)
                
                for index in 0...DiagnosisInformation.shared.skinSensitivityImages.count - 1 {
                    
                    DiagnosisInformation.shared.skinSensitivityImages[index].isSelected = false
                }
                
                DiagnosisInformation.shared.skinSensitivityImages[DiagnosisInformation.shared.skinSensitivityImages.count - 1].isSelected = true
                
            }
           
        } else if currentMode == .skinTone {
            
            if self.skinToneMode == .chin {
                
                DiagnosisInformation.shared.skinToneChinImage = diag
            }
            
            if self.skinToneMode == .cheek {
                
                DiagnosisInformation.shared.skinToneCheeckImage = diag
            }
            
            if self.skinToneMode == .forehead {
                
                DiagnosisInformation.shared.skinToneForeheadImage = diag
            }
            
            //MARK: - NEED TO APPLY SKIN TONE ANALYSIS
            let analyzeSkinTone = "SKIN TONE NOT ANALYZED"
            
        } else if currentMode == .blackhead {
            
            DiagnosisInformation.shared.blackheadImages.append(diag)
            
            for index in 0...DiagnosisInformation.shared.blackheadImages.count - 1 {
                
                DiagnosisInformation.shared.blackheadImages[index].isSelected = false
            }
            
            DiagnosisInformation.shared.blackheadImages[DiagnosisInformation.shared.blackheadImages.count - 1].isSelected = true
            
            let mode: CWMode = self.cameraView.getMode()
            
            if mode == kCWModeSkinAcne {
                
                let connect = self.connectToDevice()
                
                if connect == false {
                    
                    return
                }
                
                self.setMode(mode: kCWModeSkinPores)
            }
        }
        
        self.analyzeButton.isEnabled = true
        self.deleteButton.isEnabled = true
        
        self.professionalCapturedImagesCollectionView.reloadData()
        
        self.expertAnalyzeButton.isEnabled = true
        self.expertDeleteButton.isEnabled = true
        
        self.expertCapturedImageCollectionView.reloadData()
    }
    
    func cwVideoPlayerDidFailReceiveSnapShot(_ videoPlayer: CWVideoPlayer) {
        
        self.hideActivityIndicator()
    }
    
    func cwVideoPlayerDidSuccessSetCustomParameters(_ videoPlayer: CWVideoPlayer) {
        
    }
    
    func cwVideoPlayerDidFailSetCustomParameters(_ videoPlayer: CWVideoPlayer) {
        
    }
    
    func cwVideoPlayerDidStartFailed(_ videoPlayer: CWVideoPlayer) {
        
        self.hideActivityIndicator()
    }
    
    func cwVideoPlayerDidStop(_ videoPlayer: CWVideoPlayer) {
        
        self.hideActivityIndicator()
    }
}

extension DiagnosisViewController: CWHandSetDelegate {
    
    func cwHandSetDidSuccessSetOpticNumber(_ withOpticNumber: String) {
        
        if self.isCameraConfigurationDone == false {
            
            self.hideActivityIndicator()
            self.showToastMessageWith(text: "First load configuration files")
            return
        }
        
        _ = self.connectToDevice()
    }
    
    func cwHandSetDidReceiveMoisture(_ moisture: Int) {
        
    }
    
    func cwHandSetDidFailRequestMoisture() {
        
    }
}

extension DiagnosisViewController: CWConnectManagerDelegate {
    
    func cwConnectManagerDidComplete() {
        
        if CWConnectManager.shared().isConnected() {
            
            self.hideActivityIndicator()
        }
    }
    
    func cwConnectManagerDidFailedToComplete() {
        
        self.hideActivityIndicator()
    }
    
    func cwConnectManagerDidFailConnectHandSet() {
        
        self.hideActivityIndicator()
    }
    
    func cwConnectManagerDidSuccessConnectHandSet() {
        
    }
}

extension DiagnosisViewController: AVCapturePhotoCaptureDelegate {
    
    // MARK: - AVCapturePhotoCaptureDelegate
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard error == nil else {
            
            self.enableScreenTab()
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            
            self.enableScreenTab()
            return
        }
        
        guard var image: UIImage = UIImage(data:imageData) else { return }
        let width = image.size.height
        let height = image.size.height * self.capturedImageView.frame.size.height / self.capturedImageView.frame.size.width
        
        let rect = CGRect(x: 0, y: image.size.width / 2 - height / 2, width: width, height: height)
        
        image = self.cropImage(image: image, toRect: rect) ?? image
        
        self.capturedImageView.image = self.flipImageLeftRight(image) ?? image
        
//        if self.captureCount == 0 {
//            DiagnosisInformation.shared.ffaFrontImage = self.capturedImageView.image
//        } else if self.captureCount == 1 {
//            DiagnosisInformation.shared.ffaRightImage = self.capturedImageView.image
//        } else if captureCount == 2 {
//            DiagnosisInformation.shared.ffaLeftImage = self.capturedImageView.image
//        }
        
        self.captureCount += 1
        
        DispatchQueue.main.async {
            
            self.previewView.isHidden = true
            self.guideFaceImageView.image = self.setupGuideLineArea()
        }
        
        if self.captureCount <= 2 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                self.previewView.isHidden = false
            }
            
        } else {
            
            self.captureSession?.stopRunning()
        }
        
        guard let _ = capturedImageView.image else {
            self.enableScreenTab()
            return
        }
    }
    
    func flipImageLeftRight(_ image: UIImage) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: image.size.width, y: image.size.height)
        context?.scaleBy(x: -image.scale, y: -image.scale)
        
        if let cgImage = image.cgImage {
            context?.draw(cgImage, in: CGRect(origin:CGPoint.zero, size: image.size))
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    fileprivate func cropImage(image: UIImage, toRect: CGRect) -> UIImage? {
        
        guard let cgImage: CGImage = image.cgImage else { return image }
        guard let croppedCGImage: CGImage = cgImage.cropping(to: toRect) else { return image }
        return UIImage(cgImage: croppedCGImage)
    }
}

extension DiagnosisViewController {
    
    func updateARData() {
        
        var isLookingStraight = false
        
        switch self.captureCount {
        case 0: isLookingStraight = self.isFaceLookingFront
        case 1: isLookingStraight = self.isFaceRightSide
        case 2: isLookingStraight = self.isFaceLeftSide
        default: isLookingStraight = self.isFaceLookingFront
        }
        
        DispatchQueue.main.async { [self] in
            self.lightingButton.isSelected = self.isLightingGood
            self.lookStraightButton.isSelected = isLookingStraight
            self.facePositionButton.isSelected = self.isFacePositionGood
        }
        
        if self.isLightingGood && isLookingStraight && self.isFacePositionGood {
            guard countDownTimer == nil && seconds == captureTime else { return }
            self.runTimer()
        } else {
            self.stopTimer()
        }
    }
    
    func runTimer() {
        
        self.countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        DispatchQueue.main.async { [self] in
            seconds -= 1
            self.lblCountDown.text = "\(seconds)"
            if self.seconds == 0 && self.countDownTimer != nil {
                self.stopTimer()
                self.autoTakePhoto()
            }
        }
    }
    
    func stopTimer() {
        self.countDownTimer?.invalidate()
        self.countDownTimer = nil
        self.seconds = captureTime
        DispatchQueue.main.async {
            self.lblCountDown.text = ""
        }
    }
    
    func autoTakePhoto() {
        DispatchQueue.main.async { [self] in
            guard isARSceneRunning else { return }
            arScene.session.pause()
            isARSceneRunning = false
            showScreenshotEffect()
            _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false, block: { timer in
                timer.invalidate()
                let photoTaken = arScene.snapshot()
                savePhoto(photoTaken, isAuto: true)
            })
        }
    }
    
    func showScreenshotEffect() {
        let snapshotView = UIView()
        snapshotView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(snapshotView)
        // Activate full screen constraints
        let constraints:[NSLayoutConstraint] = [
            snapshotView.topAnchor.constraint(equalTo: view.topAnchor),
            snapshotView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            snapshotView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            snapshotView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        // White because it's the brightest color
        snapshotView.backgroundColor = UIColor.white
        // Animate the alpha to 0 to simulate flash
        UIView.animate(withDuration: 0.2, animations: {
            snapshotView.alpha = 0
        }) { _ in
            // Once animation completed, remove it from view.
            snapshotView.removeFromSuperview()
        }
    }
    
    func imageOutput(_ output: String?) {
        if let imagePath = output {
            self.ffaRequest.pictureFilepaths?.append(imagePath)
        }
    }
    
    func savePhoto(_ image: UIImage, isAuto: Bool = false) {
        
        self.capturedImageView.image = image
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        let inputImageName = Util.shared.savephototodocumentdirectory(imagedata: imageData)
        let inputFilePath = Util.shared.getFilePath(inputImageName)
        
        CWImageAnalysis.shared().getFFACroppedImage(Util.shared.formatToCWString(inputFilePath), outputFilePath: Util.shared.formatToCWString(inputFilePath))
        
        if self.captureCount == 0 {
            DiagnosisInformation.shared.ffaFrontImageName = inputImageName
        } else if self.captureCount == 1 {
            DiagnosisInformation.shared.ffaRightImageName = inputImageName
        } else if captureCount == 2 {
            DiagnosisInformation.shared.ffaLeftImageName = inputImageName
        }
        
        self.captureCount += 1
        DispatchQueue.main.async {
            self.previewView.isHidden = true
            self.guideFaceImageView.image = self.setupGuideLineArea()
        }
        
        if self.captureCount <= 2 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                self.previewView.isHidden = false
            }
            
        } else {
            
            self.captureSession?.stopRunning()
        }
        
        guard !isAuto else {
            self.disableScreenTab()
            self.arScene.session.run(self.configuration, options: [.resetTracking, .removeExistingAnchors])
            self.isARSceneRunning = true
            return
        }
        self.captureSession?.startRunning()
        self.enableScreenTab()
    }
    
    func setupGuideLineArea() -> UIImage? {
        
        var resizableImage: UIImage?
        switch self.captureCount {
        case 0:
            resizableImage = UIImage(named: "guide_front")
            centerXAllowance = 30
            centerYAllowance = 30
            captureTime = 2
            faceDistanceRangeInCm = 20...40
            break
        case 1:
            resizableImage = UIImage(named: "guide_right")
            centerXAllowance = 200
            centerYAllowance = 200
            captureTime = 1
            faceDistanceRangeInCm = 19...24
            break
        case 2:
            resizableImage = UIImage(named: "guide_left")
            centerXAllowance = 200
            centerYAllowance = 200
            captureTime = 1
            faceDistanceRangeInCm = 19...24
            break
        default:
            resizableImage = UIImage(named: "guide_front")
            break
        }
        self.resetARUI()
        return resizableImage
    }
}

extension DiagnosisViewController: ARSCNViewDelegate {
    
    func setupAutoCaptureSession(_ isAuto: Bool = false) {
        
        if isAuto {
            
            guard let isRunning = self.captureSession?.isRunning else { return }
            
            if isRunning {
                
                self.captureSession?.stopRunning()
                self.captureSession?.removeOutput(stillImageOutput)
                guard let inputs = self.captureSession?.inputs else { return }
                for input in inputs {
                    self.captureSession?.removeInput(input)
                }
                self.videoPreviewLayer.removeFromSuperlayer()
            }
            self.disableScreenTab()
            self.autoPhotoMode()
        } else {
            if self.isARCapable {
                self.arScene.session.pause()
                self.isARSceneRunning = false
                self.arScene.removeFromSuperview()
            }
            DispatchQueue.main.async { [unowned self] in
                self.startCamera()
                self.enableScreenTab()
            }
        }
    }
    
    func autoPhotoMode() {
        
        self.arScene = ARSCNView()
        self.configuration.isLightEstimationEnabled = true
        self.arScene.delegate = self
        self.arScene.showsStatistics = false
        self.setupEyeNode()
        self.previewView.addSubview(arScene)
        self.previewView.addSubview(imageView)
        self.arScene.translatesAutoresizingMaskIntoConstraints = false
        self.arScene.topAnchor.constraint(equalTo: previewView.topAnchor).isActive = true
        self.arScene.bottomAnchor.constraint(equalTo: previewView.bottomAnchor).isActive = true
        self.arScene.leadingAnchor.constraint(equalTo: previewView.leadingAnchor).isActive = true
        self.arScene.trailingAnchor.constraint(equalTo: previewView.trailingAnchor).isActive = true
        self.cropImageRect = imageView.frame
        DispatchQueue.global(qos: .userInitiated).async {
            self.arScene.session.run(self.configuration, options: [.resetTracking, .removeExistingAnchors])
            self.isARSceneRunning = true
            DispatchQueue.main.async {
                self.centerX = self.previewView.bounds.maxX / 2
                self.centerY = self.previewView.bounds.maxY / 2
            }
        }
    }
    
    private func setupEyeNode() {
        
        let eyeGeometry = SCNSphere(radius: 0.005)
        eyeGeometry.materials.first?.diffuse.contents = UIColor.clear
        eyeGeometry.materials.first?.transparency = 1
        
        let node = SCNNode()
        node.geometry = eyeGeometry
        node.eulerAngles.x = -.pi/2
        node.position.z = 0.1
        
        self.leftEye = node.clone()
        self.rightEye = node.clone()
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let faceMesh = ARSCNFaceGeometry(device: arScene.device!)
        let node = SCNNode(geometry: faceMesh)
        node.geometry?.firstMaterial?.fillMode = .lines
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.clear
        return node
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        self.faceNode = node
        self.faceNode.addChildNode(leftEye)
        self.faceNode.addChildNode(rightEye)
        self.faceNode.transform = node.transform
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry else { return }
        faceGeometry.update(from: faceAnchor.geometry)
        self.leftEye.simdTransform = faceAnchor.leftEyeTransform
        self.rightEye.simdTransform = faceAnchor.rightEyeTransform
        self.checkFace(renderer, anchor: faceAnchor)
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
        self.resetARUI()
    }
    
    func resetARUI() {
        
        self.isFacePositionGood = false
        self.isFaceLeftSide = false
        self.isFaceRightSide = false
        self.isFaceLookingFront = false
        self.updateARData()
    }
    
    func checkFace(_ renderer: SCNSceneRenderer, anchor: ARFaceAnchor) {
        let leftSide = anchor.blendShapes[.jawLeft]
        let rightSide = anchor.blendShapes[.jawRight]
        let eyeLookInRight = anchor.blendShapes[.eyeLookInRight]
        let eyeLookInLeft = anchor.blendShapes[.eyeLookInLeft]
        let eyeLookUp = anchor.blendShapes[.eyeLookUpLeft]
        let eyeLookDown = anchor.blendShapes[.eyeLookDownLeft]
        
        let lookCenterX = (eyeLookInLeft?.decimalValue ?? 0.0) + (eyeLookInRight?.decimalValue ?? 0.0) < 0.3
        let lookCenterY = (eyeLookUp?.decimalValue ?? 0.0) + (eyeLookDown?.decimalValue ?? 0.0) < 0.3
        let nodeWorldPosition = faceNode.position
        let nodePositionOnScreen = renderer.projectPoint(nodeWorldPosition)
        let faceX = nodePositionOnScreen.x
        let faceY = nodePositionOnScreen.y
        self.isFacePositionGood = centerX - centerXAllowance...centerX + centerXAllowance ~= CGFloat(faceX) && centerY - centerYAllowance...centerY + centerYAllowance ~= CGFloat(faceY) && faceDistanceRangeInCm ~= trackDistance()
        self.isFaceLeftSide = (eyeLookInLeft?.decimalValue ?? 0.0) > 0.5 && (rightSide?.decimalValue ?? 0.0) > 0.02
        self.isFaceRightSide = (eyeLookInRight?.decimalValue ?? 0.0) > 0.5 && (leftSide?.decimalValue ?? 0.0) > 0.02
        self.isFaceLookingFront = lookCenterX && lookCenterY
        self.isLightingGood = getLightEstimate() > 100
        self.updateARData()
    }
    
    func trackDistance() -> Int {
        
        let leftEyeDistanceFromCamera = self.leftEye.worldPosition - SCNVector3Zero
        let rightEyeDistanceFromCamera = self.rightEye.worldPosition - SCNVector3Zero
        let averageDistance = (leftEyeDistanceFromCamera.length() + rightEyeDistanceFromCamera.length()) / 2
        let averageDistanceCM = (Int(round(averageDistance * 100)))
        print("Distance \(averageDistanceCM)")
        return averageDistanceCM
    }
    
    func getLightEstimate() -> Int {
        guard let lightEstimate = self.arScene.session.currentFrame?.lightEstimate else { return 0 }
        let ambientLightEstimate = lightEstimate.ambientIntensity
        return Int(ambientLightEstimate)
    }
}

extension SCNVector3 {
    func length() -> Float {
        return sqrt(x * x + y * y + z * z)
    }
    
    static func - (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(l.x - r.x, l.y - r.y, l.z - r.z)
    }
}

