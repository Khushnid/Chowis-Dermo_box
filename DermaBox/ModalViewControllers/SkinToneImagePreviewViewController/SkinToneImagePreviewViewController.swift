//
//  SkinToneImagePreviewViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/09/30.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

class SkinToneImagePreviewViewController: BaseViewController {

    @IBOutlet var imageDescriptionLabel: UILabel!
    @IBOutlet var colorCodeLabel: UILabel!
    @IBOutlet var colorView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var rgbImageView: UIImageView!
    @IBOutlet var hsvImageView: UIImageView!
    @IBOutlet var labImageView: UIImageView!
    @IBOutlet var rgbView: UIView!
    @IBOutlet var hsvView: UIView!
    @IBOutlet var labView: UIView!
    
    var skinToneMode:SkinToneMode?
    var colorCodeString:String?
    var imageDescriptionString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rgbView.isHidden = true
        self.hsvView.isHidden = true
        self.labView.isHidden = true
        
        self.imageView.image = UIImage()
        
        if let color = self.colorCodeString {
            
            self.colorCodeLabel.text = "HEX: #\(color)"
        }
        
        if let imageDescription = self.imageDescriptionString {
            
            self.imageDescriptionLabel.text = imageDescription
        }
        
        if let skinToneMode = skinToneMode {
            
            if skinToneMode == .cheek {
                
                if let image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.skinToneCheeckImage.originalPath) {
                    
                    self.imageView.image = image
                }
                
            } else if skinToneMode == .chin {
                
                if let image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.skinToneChinImage.originalPath) {
                    
                    self.imageView.image = image
                }
                
            } else {
                
                
                if let image = Util.shared.getImageFromDatabase(fileName: DiagnosisInformation.shared.skinToneForeheadImage.originalPath) {
                    
                    self.imageView.image = image
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.colorView.layer.borderWidth = 1
        self.colorView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func rgbButtonPressed(_ sender: Any) {
        
        self.rgbView.isHidden = !self.rgbView.isHidden
    }
    
    @IBAction func hsvButtonPressed(_ sender: Any) {
        
        self.hsvView.isHidden = !self.hsvView.isHidden
    }
    
    @IBAction func labButtonPressed(_ sender: Any) {
        
        self.labView.isHidden = !self.labView.isHidden
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
}
