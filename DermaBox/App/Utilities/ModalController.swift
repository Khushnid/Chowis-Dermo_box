//
//  ModalController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/12.
//  Copyright © 2020 Bekzod Rakhmatov. All rights reserved.
//

import UIKit

class ModalController {

    static let shared = ModalController()
    
    func presentDeviceActivationAgreementViewController(
        with presentingViewController: UIViewController,
        delegate: DeviceActivationAgreementViewControllerDelegate) {
        
        let vc = DeviceActivationAgreementViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
        
    }
    
    func presentDeviceActivationQRScanViewController(
        with presentingViewController: UIViewController,
        delegate: DeviceActivationQRScanViewControllerDelegate) {
        
        let vc = DeviceActivationQRScanViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentDeviceActivationInputViewController(
        with serialNumber:String?,
        presentingViewController: UIViewController,
        delegate: DeviceActivationInputViewControllerDelegate) {
        
        let vc = DeviceActivationInputViewController()
        vc.serialNumber = serialNumber
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentPhoneNumberInputViewController(
        presentingViewController: UIViewController,
        delegate: PhoneNumberInputViewControllerDelegate) {
        let vc = PhoneNumberInputViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentCustomerInfoViewController(
        presentingViewController: UIViewController,
        delegate: CustomerInfoViewControllerDelegate) {
        let vc = CustomerInfoViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentConnectionTypeViewController(
        presentingViewController: UIViewController,
        delegate: ConnectionTypeDelegate) {
        let vc = ConnectionTypePopupViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentBirthDayViewController(
        with defaultDate: String,
        presentingViewController: UIViewController,
        delegate: BirthDayViewControllerDelegate) {
        
        let vc = BirthDayViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.customerDate = defaultDate
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentEthnicityViewController(
        presentingViewController: UIViewController,
        delegate: EthnicityViewControllerDelegate) {
        
        let vc = EthnicityViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentSkinColorGroupViewController(
        presentingViewController: UIViewController,
        delegate: SkinColorGroupViewControllerDelegate) {
        
        let vc = SkinColorGroupViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentDeviceInitViewController(
        presentingViewController: UIViewController) {
        
        let vc = DeviceInitViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentPDFResultPopupViewController(
        with data: Data?,
        delegate: PDFResultPopupViewControllerDelegate,
        presentingViewController: UIViewController) {
        
        let vc = PDFResultVC()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        vc.documentData = data
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentTwoButtonMessagePopupViewController(
        withTitle title: String,
        message: String,
        leftButtonText: String,
        rightButtonText: String,
        presentingViewController: UIViewController,
        delegate: TwoButtonMessagePopupViewControllerDelegate) {
        
        let vc = TwoButtonMessagePopupViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.titleText = title
        vc.messageText = message
        vc.leftButtonText = leftButtonText
        vc.rightButtonText = rightButtonText
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentSkinToneQuestionnaireViewController(
        presentingViewController: UIViewController,
        delegate: SkinToneQuestionnaireViewControllerDelegate) {
        
        let vc = SkinToneQuestionnaireViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = delegate
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentSkinToneImagePreviewViewController(
        presentingViewController: UIViewController,
        skinToneMode: SkinToneMode) {
        
        let vc = SkinToneImagePreviewViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.skinToneMode = skinToneMode
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentGenderChoosingViewController(
        presentingViewController: UIViewController,
        delegate: GenderViewControllerDelegate) {
        
        let vc = GenderVC()
        vc.delegate = delegate
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentOverallMatchedViewController(
        presentingViewController: UIViewController) {
        
        let vc = OverallMatchedViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentDeviceParingPopupViewController(
        presentingViewController: UIViewController,
        delegate: ConnectionTypeDelegate?) {
        
        let vc = ConnectionTypePopupViewController()
        vc.delegate = delegate
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentOneButtonMessagePopupViewController(
        presentingViewController: UIViewController,
        titleText: String?,
        messageText: String?,
        buttonText: String?,
        icon: UIImage? = nil, delegate: OneButtonMessagePopupViewControllerDelegate? = nil) {
        let vc = OneButtonMessagePopupViewController()
        vc.delegate = delegate
        vc.titleText = titleText
        vc.messageText = messageText
        vc.saveButtonText = buttonText
        vc.iconImage = icon
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    var loadingPopupViewController = LoadingPopupViewController()
    
    func presentLoadingPopupViewController(
        presentingViewController: UIViewController,
        delegate:LoadingPopupViewControllerDelegate,
        titleText:String?,
        messageText:String?,
        buttonText:String?) {
        
        self.loadingPopupViewController = LoadingPopupViewController()
        self.loadingPopupViewController.titleText = titleText
        self.loadingPopupViewController.messageText = messageText
        self.loadingPopupViewController.buttonText = buttonText
        self.loadingPopupViewController.delegate = delegate
        self.loadingPopupViewController.modalPresentationStyle = .custom
        self.loadingPopupViewController.modalTransitionStyle = .crossDissolve
        presentingViewController.present(self.loadingPopupViewController, animated: true, completion: nil)
    }
    
    func dismissLoadingPopupViewController() {
        
        self.loadingPopupViewController.dismiss(animated: true, completion: nil)
    }
    
    func presentAPSettingViewController(
        presentingViewController: UIViewController,
        delegate: APSettingViewControllerDelegate) {
        
        let vc = APSettingViewController()
        vc.delegate = delegate
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentFullWrinkleAnalysisViewController(
        presentingViewController: UIViewController,
        wrinkleData: DiagData) {
        
        let vc = FullWrinkleAnalysisViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc.wrinkleData = wrinkleData
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentConnectDirectionVC(
        presentingViewController: UIViewController,
        isApMode: Bool,
        delegate: ConnectDirectionVCDelegate) {
        
        let vc = ConnectDirectionVC()
        vc.isApMode = isApMode
        vc.delagte = delegate
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        presentingViewController.present(vc, animated: true, completion: nil)
    }
    
    func presentSebumGuideVC(
        presentingViewController: UIViewController,
        isSebum: Bool? = nil,
        isMoisture: Bool? = nil,
        isPores: Bool? = nil,
        isSpots: Bool? = nil,
        isWrinkles: Bool? = nil,
        isImpurities: Bool? = nil,
        isKeratin: Bool? = nil) {

        let vc = SebumGuideVC()
        vc.isSebum = isSebum
        vc.isMoisture = isMoisture
        vc.isPores = isPores
        vc.isSpots = isSpots
        vc.isWrinkles = isWrinkles
        vc.isImpurities = isImpurities
        vc.isKeratin = isKeratin
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        presentingViewController.present(vc, animated: true, completion: nil)
    }
}
