//
//  FullWrinkleAnalysisViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/10/09.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import ChowisSDK

class FullWrinkleAnalysisViewController: BaseViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var fineWrinklesValueLabel: UILabel!
    @IBOutlet var deepWrinklesValueLabel: UILabel!
    @IBOutlet var veryDeepWrinklesValueLabel: UILabel!
    @IBOutlet var ultraFineWrinklesValueLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var ultraFineWrinklesLabel: UILabel!
    @IBOutlet var fineWrinklesLabel: UILabel!
    @IBOutlet var deepWrinklesLabel: UILabel!
    @IBOutlet var veryDeepWrinklesLabel: UILabel!
    @IBOutlet var totalScoreLabel: UILabel!
    @IBOutlet var cautionLabel: UILabel!
    @IBOutlet var normalLabel: UILabel!
    @IBOutlet var gradientConstraint: NSLayoutConstraint!
    @IBOutlet var imageView: UIImageView!
    
    var wrinkleData:DiagData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CWImageAnalysis.shared().skinWrinkle(
            withInputImageFile: self.wrinkleData.originalPath,
            rect: CGRect(),
            outputImageFile: self.wrinkleData.analyzedPath,
            ultraImageFile: self.wrinkleData.wrinkleUltraImageFile,
            fineImageFile: self.wrinkleData.wrinkleFineImageFile,
            deepImageFile: self.wrinkleData.wrinkleDeepImageFile,
            veryDeepImageFile: self.wrinkleData.wrinkleVeryDeepImageFile)
        
        if let image = Util.shared.getImageFromDatabase(fileName: self.wrinkleData.analyzedPath) {
            
            self.imageView.image = image
        }
    }
    
    @IBAction func veryDeepWrinklesButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func ultraFineWrinklesButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func deepWrinklesButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func fineWrinklesButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
