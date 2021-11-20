//
//  CompareViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/10/18.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

class CompareViewController: BaseViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var originalScrollView: UIScrollView!
    @IBOutlet var exampleScrollView: UIScrollView!
    @IBOutlet var orignalPageControl: UIPageControl!
    @IBOutlet var examplePageControl: UIPageControl!
    @IBOutlet var exampleImageDescriptionLabel: UILabel!
    
    var mode:DiagnosisMode?
    var originalImages = [UIImage]()
    var examples = [UIImage]()
    var scrollWidth: CGFloat = 0.0
    var scrollHeight: CGFloat = 0.0
    
    let poresDescription = [
        
        "Good skin with normal pores".localized,
        "Good skin with few pores".localized,
        "Slightly large pores".localized,
        "Slightly large pores on oily skin".localized,
        "Large pores".localized,
        "Large pores".localized,
        "Very large pores".localized,
        "Very large pores".localized
    ]
    
    let spotsDescription = [
        
        "Good skin with no spots or pigmentation".localized,
        "Good skin with light pigmentation".localized,
        "Light pigmentation on the skin".localized,
        "Light pigmentation on the skin".localized,
        "Pigmentation is being spread on the skin".localized,
        "Pigmentation is being spread on the skin".localized,
        "Dark pigmentation spread on the skin".localized,
        "Dark pigmentation spread on the skin".localized
    ]
    
    let wrinklesDescription = [
        
        "Clean skin with no wrinkles".localized,
        "Few fine wrinkles".localized,
        "Fine wrinkles".localized,
        "Fine wrinkles".localized,
        "Fine wrinkles".localized,
        "Deep wrinkles".localized,
        "Deep wrinkles".localized,
        "Deep wrinkles and fine wrinkles".localized
    ]
    
    let impuritiesDescription = [
        
        "No impurities and porphyrin".localized,
        "A few small impurities in pores".localized,
        "A few impurities and porphyrins".localized,
        "Large impurities in pores".localized,
        "A lot of impurities spread widely".localized,
        "A lot of porphyrins".localized,
        "A lot of impurities spread widely".localized,
        "A lot of impurities and porphyrins".localized
    ]
    
    let keratinDescription = [
        
        "No keratin on the skin".localized,
        "Few keratin on the skin".localized,
        "Few keratin on the skin".localized,
        "Few keratin spread on the skin".localized,
        "Keratin spread on the skin".localized,
        "Keratin spread on the skin".localized,
        "A lot of keratin on the skin".localized,
        "A lot of keratin on the skin".localized
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollWidth = self.originalScrollView.frame.size.width
        self.scrollHeight = self.originalScrollView.frame.size.height
        self.titleLabel.text = "Compare".localized
        if mode == .pores {
            
            self.exampleImageDescriptionLabel.text = self.poresDescription.first?.localized
            let poresExampleImage = [
                "pore_01",
                "pore_02",
                "pore_03",
                "pore_04",
                "pore_05",
                "pore_06",
                "pore_07",
                "pore_08"
            ]
            self.addExampleImages(imageNames: poresExampleImage)
            self.addOriginalImages(
                diags: DiagnosisInformation.shared.poresImages)
            
        } else if mode == .spots {
            
            self.exampleImageDescriptionLabel.text = self.spotsDescription.first?.localized
            let spotsExampleImage = [
                "spot_01",
                "spot_02",
                "spot_03",
                "spot_04",
                "spot_05",
                "spot_06",
                "spot_07",
                "spot_08"
            ]
            self.addExampleImages(imageNames: spotsExampleImage)
            self.addOriginalImages(
                diags: DiagnosisInformation.shared.spotsImages)
            
        } else if mode == .wrinkles {
            
            self.exampleImageDescriptionLabel.text = self.wrinklesDescription.first?.localized
            let wrinklesExampleImage = [
                "wrinkle_01",
                "wrinkle_02",
                "wrinkle_03",
                "wrinkle_04",
                "wrinkle_05",
                "wrinkle_06",
                "wrinkle_07",
                "wrinkle_08",
            ]
            self.addExampleImages(imageNames: wrinklesExampleImage)
            self.addOriginalImages(
                diags: DiagnosisInformation.shared.wrinklesImages)
            
        } else if mode == .impurities {
            
            self.exampleImageDescriptionLabel.text = self.impuritiesDescription.first?.localized
            let impuritiesExampleImage = [
                "acne_01",
                "acne_02",
                "acne_03",
                "acne_04",
                "acne_05",
                "acne_06",
                "acne_07",
                "acne_08",
            ]
            self.addExampleImages(imageNames: impuritiesExampleImage)
            self.addOriginalImages(
                diags: DiagnosisInformation.shared.impuritiesImages)
            
        } else if mode == .keratin {
            
            self.exampleImageDescriptionLabel.text = self.keratinDescription.first?.localized
            let keratinExampleImage = [
                "keratin_01",
                "keratin_02",
                "keratin_03",
                "keratin_04",
                "keratin_05",
                "keratin_06",
                "keratin_07",
                "keratin_08",
            ]
            self.addExampleImages(imageNames: keratinExampleImage)
            self.addOriginalImages(
                diags: DiagnosisInformation.shared.keratinImages)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollWidth = self.originalScrollView.frame.size.width
        self.scrollHeight = self.originalScrollView.frame.size.height
        
        let selectedButtonColor = #colorLiteral(red: 1, green: 0.8491632342, blue: 0.3143449128, alpha: 1)
        self.originalScrollView.layer.borderWidth = 2
        self.originalScrollView.layer.borderColor = selectedButtonColor.cgColor
        
        self.exampleScrollView.layer.borderWidth = 2
        self.exampleScrollView.layer.borderColor = selectedButtonColor.cgColor
    }
    
    func addOriginalImages(diags: [DiagData]) {
        
        DispatchQueue.main.async {
            
            for imageView in self.originalScrollView.subviews {
                
                imageView.removeFromSuperview()
            }
            
            if diags.count > 0 {
                
                var index = 0
                
                self.originalScrollView.contentSize = CGSize(width: CGFloat(diags.count) * self.scrollWidth, height: self.scrollHeight)
                
                for diag in diags {
                    
                    var rectFrame = CGRect()
                    
                    rectFrame.origin.x = self.scrollWidth * CGFloat(index)
                    rectFrame.origin.y = 0
                    rectFrame.size.width = self.scrollWidth
                    rectFrame.size.height = self.scrollHeight
                    
                    let imageView = UIImageView(frame: rectFrame)
                    
                    if let img = Util.shared.getImageFromDatabase(fileName: diag.originalPath) {
                        
                        imageView.image = img
                    }
                    
                    imageView.isUserInteractionEnabled = true
                    self.originalScrollView.addSubview(imageView)
                    
                    index = index + 1
                }
                
                self.orignalPageControl.isHidden = false
                self.orignalPageControl.numberOfPages = index
                
                var value = 0
                var count = 0
                
                diags.forEach { (diag) in
                    
                    if diag.resultValue != -1 {
                        
                        value += diag.resultValue
                        count += 1
                    }
                }
                
                let rect = CGRect(x: 0, y: 0, width: self.scrollWidth, height: self.scrollHeight)
                
                DispatchQueue.main.async {
                    
                    self.originalScrollView.scrollRectToVisible(rect, animated: false)
                    self.originalScrollView.layoutSubviews()
                    self.originalScrollView.layoutIfNeeded()
                    self.viewDidLayoutSubviews()
                }
                
            } else {
                
                self.orignalPageControl.numberOfPages = 0
            }
        }
    }
    
    func addExampleImages(imageNames: [String]) {
        
        DispatchQueue.main.async {
            
            for imageView in self.exampleScrollView.subviews {
                
                imageView.removeFromSuperview()
            }
            
            self.exampleScrollView.contentSize = CGSize(width: CGFloat(imageNames.count) * self.scrollWidth, height: self.scrollHeight)
            
            var index = 0
            
            for name in imageNames {
                
                var rectFrame = CGRect()
                
                rectFrame.origin.x = self.scrollWidth * CGFloat(index)
                rectFrame.origin.y = 0
                rectFrame.size.width = self.scrollWidth
                rectFrame.size.height = self.scrollHeight
                
                let imageView = UIImageView(frame: rectFrame)
                imageView.image = UIImage(named: name)
                
                imageView.isUserInteractionEnabled = true
                self.exampleScrollView.addSubview(imageView)
                
                index = index + 1
            }
            
            self.examplePageControl.numberOfPages = imageNames.count
            
            let rect = CGRect(x: 0, y: 0, width: self.scrollWidth, height: self.scrollHeight)
            
            DispatchQueue.main.async {
                
                self.exampleScrollView.scrollRectToVisible(rect, animated: false)
                self.exampleScrollView.layoutSubviews()
                self.exampleScrollView.layoutIfNeeded()
                self.viewDidLayoutSubviews()
            }
        }
    }
}

extension CompareViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.originalScrollView {
            
            let page = Int((self.originalScrollView?.contentOffset.x ?? 0) / self.scrollWidth)
            self.orignalPageControl?.currentPage = page
            
        } else if scrollView == self.exampleScrollView {
            
            let page = Int((self.exampleScrollView?.contentOffset.x ?? 0) / self.scrollWidth)
            self.examplePageControl?.currentPage = page
            
            if mode == .pores {
                
                self.exampleImageDescriptionLabel.text = self.poresDescription[page].localized
                
            } else if mode == .spots {
                
                self.exampleImageDescriptionLabel.text = self.spotsDescription[page].localized
                
            } else if mode == .wrinkles {
                
                self.exampleImageDescriptionLabel.text = self.wrinklesDescription[page].localized
                
            } else if mode == .keratin {
                
                self.exampleImageDescriptionLabel.text = self.keratinDescription[page].localized
                
            } else if mode == .impurities {
                
                self.exampleImageDescriptionLabel.text = self.impuritiesDescription[page].localized
            }
        }
    }
}
