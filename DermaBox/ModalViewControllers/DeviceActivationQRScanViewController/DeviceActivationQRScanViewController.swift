//
//  DeviceActivationQRScanViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/07/12.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import AVFoundation

protocol DeviceActivationQRScanViewControllerDelegate: class {
    
    func didSelectDeviceActivationQRScanViewControllerManualInputButtonPressed()
    func didSelectDeviceActivationQRScanViewControllerCancelButtonPressed()
    func didSelectQRCodeDetectedWithSerialNumber(serialNumber: String)
}

class DeviceActivationQRScanViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet var topFrameView: UIView!
    @IBOutlet var scanCodeLabel: UILabel!
    @IBOutlet var manualInputButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var previewView: UIView!
    @IBOutlet var activationLabel : UILabel!
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    weak var delegate: DeviceActivationQRScanViewControllerDelegate?
    var qrTitleText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLocalization()
        self.captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            let metadataOutput = AVCaptureMetadataOutput()
            
            if self.captureSession.canAddInput(videoInput) && self.captureSession.canAddOutput(metadataOutput) {
                
                self.captureSession.addInput(videoInput)
                self.captureSession.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr]
                
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                self.previewLayer.videoGravity = .resizeAspectFill
                self.previewView.layer.addSublayer(previewLayer)
                
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    self.captureSession.startRunning()
                    
                    DispatchQueue.main.async {
                        
                        self.previewLayer.frame = self.view.layer.bounds
                    }
                }
                
                self.previewView.bringSubviewToFront(self.topFrameView)
                
                DispatchQueue.main.async {
                    
                    var initialVideoOrientation: AVCaptureVideoOrientation = .landscapeLeft
                    if UIApplication.shared.statusBarOrientation != .landscapeLeft {
                        initialVideoOrientation = .landscapeRight
                    }
                    
                    self.previewLayer.connection?.videoOrientation = initialVideoOrientation
                }
                
            } else {
                
                self.failed()
                return
            }
        
        } catch {
         
            self.failed()
            return
        }
        
    }
    
    func setLocalization() {
        self.scanCodeLabel.text = "Scan QR Code".localized
        self.activationLabel.text = "Initial Device Activation".localized
        self.manualInputButton.setTitle("Manual Input".localized, for: .normal)
        self.cancelButton.setTitle("Cancel".localized, for: .normal)
    }
    
    var windowOrientation: UIInterfaceOrientation {
        if #available(iOS 13.0, *) {
            return view.window?.windowScene?.interfaceOrientation ?? .unknown
        } else {
            return .unknown
        }
    }
    
    override var shouldAutorotate: Bool {
        
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if let videoPreviewLayerConnection = previewLayer.connection {
            let deviceOrientation = UIDevice.current.orientation
            guard let newVideoOrientation = AVCaptureVideoOrientation(deviceOrientation: deviceOrientation), deviceOrientation.isLandscape else {
                return
            }
            
            videoPreviewLayerConnection.videoOrientation = newVideoOrientation
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.cancelButton.layer.borderColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        self.cancelButton.layer.borderWidth = 1.0
        
        self.manualInputButton.layer.cornerRadius = self.manualInputButton.frame.size.height / 2
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
        self.manualInputButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.manualInputButton.frame.size.height / 2)
    }

    func failed() {
        
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        self.captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.captureSession?.isRunning == false {
            
            self.captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.captureSession?.isRunning == true {
            
            self.captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
       
        self.captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            self.dismiss(animated: true) {
             
                self.delegate?.didSelectQRCodeDetectedWithSerialNumber(serialNumber: stringValue)
                defaults.setValue(stringValue, forKey: SERIAL_NUMBER)
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func manualInputButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectDeviceActivationQRScanViewControllerManualInputButtonPressed()
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            self.delegate?.didSelectDeviceActivationQRScanViewControllerCancelButtonPressed()
        }
    }
}
