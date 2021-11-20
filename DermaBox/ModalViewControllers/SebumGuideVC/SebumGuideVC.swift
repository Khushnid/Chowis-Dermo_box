//
//  SebumGuideVC.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/11/15.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

class SebumGuideVC: BaseViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var desxriptionLabel: UILabel!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var viewOne: UIStackView!
    @IBOutlet var viewTwo: UIStackView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var yesNoStackView: UIStackView!
    @IBOutlet var viewThree: UIImageView!
    @IBOutlet var viewFour: UIImageView!
    @IBOutlet var viewFive: UIImageView!
    @IBOutlet var viewSix: UIImageView!
    @IBOutlet var viewSeven: UIImageView!
    @IBOutlet weak var switchView: UISwitch!
    
    var isSebum: Bool?
    var isMoisture: Bool?
    var isPores: Bool?
    var isSpots: Bool?
    var isWrinkles: Bool?
    var isImpurities: Bool?
    var isKeratin: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yesNoStackView.isHidden = true
        self.previousButton.isHidden = true
        self.nextButton.isHidden = true
        self.pageControl.isHidden = true
        self.previousButtonPressed(self.previousButton)
        self.scrollView.isHidden = true
        
        if self.isSebum == true {
            
            self.titleLabel.text = "Sebum".localized
            self.desxriptionLabel.addAttribute(fullText: "Step 1: Put the pink side of sebum paper on cheeks for 3 seconds.".localized, attributedText: "Step 1:".localized, attributedFont: UIFont.systemFont(ofSize: self.desxriptionLabel.font.pointSize, weight: .semibold))
            let isOn = defaults.value(forKey: SHOULD_SHOW_SEBUM_GUIDE) as? Bool ?? true
            self.switchView.isOn = isOn
        }
        
        if self.isMoisture == true {
            
            self.titleLabel.text = "T Zone Moisture".localized
            self.desxriptionLabel.addAttribute(fullText: "Step 1: Place Moisture Sensor on the forehead and press capture button on the camera device.".localized, attributedText: "Step 1:", attributedFont: UIFont.systemFont(ofSize: self.desxriptionLabel.font.pointSize, weight: .semibold))
            let isOn = defaults.value(forKey: SHOULD_SHOW_MOISTURE_GUIDE) as? Bool ?? true
            self.switchView.isOn = isOn
        }
        
        if self.isPores == true {
            
            let isOn = defaults.value(forKey: SHOULD_SHOW_PORES_GUIDE) as? Bool ?? true
            self.switchView.isOn = isOn
            self.scrollView.scrollRectToVisible(self.viewFour.frame, animated: false)
            self.titleLabel.text = "Pores".localized
            self.desxriptionLabel.text = "Position camera on cheeks and press capture button on the camera device. Ensure that camera is fully and lightly touches the skin".localized
        }
        
        if self.isSpots == true {
            
            let isOn = defaults.value(forKey: SHOULD_SHOW_SPOTS_GUIDE) as? Bool ?? true
            self.switchView.isOn = isOn
            self.scrollView.scrollRectToVisible(self.viewFour.frame, animated: false)
            self.titleLabel.text = "Spots".localized
            self.desxriptionLabel.text = "Position camera on cheeks and press capture button on the camera device. Ensure that camera is fully and lightly touches the skin".localized
        }
        
        if self.isWrinkles == true {
            
            let isOn = defaults.value(forKey: SHOULD_SHOW_WRINKLES_GUIDE) as? Bool ?? true
            self.switchView.isOn = isOn
            self.scrollView.scrollRectToVisible(self.viewSeven.frame, animated: false)
            self.titleLabel.text = "Wrinkles".localized
            self.desxriptionLabel.text = "Position camera on wrinkles and capture. Ensure that camera is fully and lightly touches the skin".localized
        }
        
        if self.isImpurities == true {
            
            let isOn = defaults.value(forKey: SHOULD_SHOW_IMPURITIES_GUIDE) as? Bool ?? true
            self.switchView.isOn = isOn
            self.scrollView.scrollRectToVisible(self.viewFour.frame, animated: false)
            self.titleLabel.text = "Impurities".localized
            self.desxriptionLabel.text = "Position camera on cheeks and press capture button on the camera device. Ensure that camera is fully and lightly touches the skin".localized
        }
        
        if self.isKeratin == true {
            
            self.titleLabel.text = "Keratin".localized
            self.desxriptionLabel.addAttribute(fullText: "Step 1: Put the pink side of sebum paper on cheeks for 3 seconds.".localized, attributedText: "Step 1:".localized, attributedFont: UIFont.systemFont(ofSize: self.desxriptionLabel.font.pointSize, weight: .semibold))
            let isOn = defaults.value(forKey: SHOULD_SHOW_KERATIN_GUIDE) as? Bool ?? true
            self.switchView.isOn = isOn
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.isHidden = false
        
        if self.isPores != nil {
            
            self.scrollView.scrollRectToVisible(self.viewFour.frame, animated: false)
        }
        
        if self.isSpots != nil {
            
            self.scrollView.scrollRectToVisible(self.viewFour.frame, animated: false)
        }
        
        if self.isWrinkles != nil {
            
            self.scrollView.scrollRectToVisible(self.viewSeven.frame, animated: false)
        }
        
        if self.isImpurities != nil {
            
            self.scrollView.scrollRectToVisible(self.viewFour.frame, animated: false)
        }
        
        if self.isKeratin != nil {
            
            self.scrollView.scrollRectToVisible(self.viewFive.frame, animated: false)
        }
        
        if self.isSebum != nil {
            
            self.scrollView.scrollRectToVisible(self.viewOne.frame, animated: false)
        }
        
        if self.isMoisture != nil {
            
            self.scrollView.scrollRectToVisible(self.viewThree.frame, animated: false)
        }
    }
    
    @IBAction func switchViewPressed(_ sender: Any) {
        
        if self.isSebum == true {
            defaults.setValue(self.switchView.isOn, forKey: SHOULD_SHOW_SEBUM_GUIDE)
            defaults.synchronize()
        }
        
        if self.isMoisture == true {
            defaults.setValue(self.switchView.isOn, forKey: SHOULD_SHOW_MOISTURE_GUIDE)
            defaults.synchronize()
        }
        
        if self.isPores == true {
            defaults.setValue(self.switchView.isOn, forKey: SHOULD_SHOW_PORES_GUIDE)
            defaults.synchronize()
        }
        
        if self.isSpots == true {
            defaults.setValue(self.switchView.isOn, forKey: SHOULD_SHOW_SPOTS_GUIDE)
            defaults.synchronize()
        }
        
        if self.isWrinkles == true {
            defaults.setValue(self.switchView.isOn, forKey: SHOULD_SHOW_WRINKLES_GUIDE)
            defaults.synchronize()
        }
        
        if self.isImpurities == true {
            defaults.setValue(self.switchView.isOn, forKey: SHOULD_SHOW_IMPURITIES_GUIDE)
            defaults.synchronize()
        }
        
        if self.isKeratin == true {
            defaults.setValue(self.switchView.isOn, forKey: SHOULD_SHOW_KERATIN_GUIDE)
            defaults.synchronize()
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        
        if self.isKeratin != nil {
            
            self.titleLabel.text = "Keratin".localized
            self.desxriptionLabel.addAttribute(fullText: "Step 1: Put the pink side of sebum paper on cheeks for 3 seconds.".localized, attributedText: "Step 1:".localized, attributedFont: UIFont.systemFont(ofSize: self.desxriptionLabel.font.pointSize, weight: .semibold))
            self.scrollView.scrollRectToVisible(self.viewFive.frame, animated: false)
            self.pageControl.currentPage = 0
            self.previousButton.isHidden = true
            self.nextButton.isHidden = false
            self.pageControl.isHidden = false
        }
        
        if self.isSebum != nil {
         
            self.titleLabel.text = "Sebum".localized
            self.desxriptionLabel.addAttribute(fullText: "Step 1: Put the pink side of sebum paper on cheeks for 3 seconds.".localized, attributedText: "Step 1:".localized, attributedFont: UIFont.systemFont(ofSize: self.desxriptionLabel.font.pointSize, weight: .semibold))
            self.scrollView.scrollRectToVisible(self.viewOne.frame, animated: false)
            self.pageControl.currentPage = 0
            self.previousButton.isHidden = true
            self.yesNoStackView.isHidden = true
            self.nextButton.isHidden = false
            self.pageControl.isHidden = false
        }
        
        if self.isMoisture != nil {
            
            self.titleLabel.text = "T Zone Moisture".localized
            self.desxriptionLabel.addAttribute(fullText: "Step 1: Place Moisture Sensor on the forehead and press capture button on the camera device.".localized, attributedText: "Step 1:".localized, attributedFont: UIFont.systemFont(ofSize: self.desxriptionLabel.font.pointSize, weight: .semibold))
            self.scrollView.scrollRectToVisible(self.viewThree.frame, animated: false)
            self.pageControl.currentPage = 0
            self.previousButton.isHidden = true
            self.nextButton.isHidden = false
            self.pageControl.isHidden = false
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if self.isKeratin != nil {
            
            self.titleLabel.text = "Keratin".localized
            self.desxriptionLabel.addAttribute(fullText: "Step 2: Place black film on the top of camera and press capture. Make sure optical lens cover black film fully.".localized, attributedText: "Step 2:".localized, attributedFont: UIFont.systemFont(ofSize: self.desxriptionLabel.font.pointSize, weight: .semibold))
            self.scrollView.scrollRectToVisible(self.viewSix.frame, animated: false)
            self.pageControl.currentPage = 1
            self.previousButton.isHidden = false
            self.nextButton.isHidden = true
            self.pageControl.isHidden = false
        }
        
        if self.isSebum != nil {
         
            self.scrollView.scrollRectToVisible(self.viewTwo.frame, animated: false)
            self.desxriptionLabel.addAttribute(fullText: "Step 2: Place sebum paper on the top of camera and press capture button on the camera device.. Make sure optical lens cover sebum paper fully.".localized, attributedText: "Step 2:".localized, attributedFont: UIFont.systemFont(ofSize: self.desxriptionLabel.font.pointSize, weight: .semibold))
            self.pageControl.currentPage = 1
            self.previousButton.isHidden = false
            self.nextButton.isHidden = true
            self.yesNoStackView.isHidden = false
            self.pageControl.isHidden = false
        }
        
        if self.isMoisture != nil {
            
            self.titleLabel.text = "U Zone Moisture".localized
            self.desxriptionLabel.addAttribute(fullText: "Step 2: Place Moisture Sensor on the Cheeks and press capture button on the camera device.".localized, attributedText: "Step 2:".localized, attributedFont: UIFont.systemFont(ofSize: self.desxriptionLabel.font.pointSize, weight: .semibold))
            self.scrollView.scrollRectToVisible(self.viewFour.frame, animated: false)
            self.pageControl.currentPage = 1
            self.previousButton.isHidden = false
            self.nextButton.isHidden = true
            self.pageControl.isHidden = false
        }
    }
}
