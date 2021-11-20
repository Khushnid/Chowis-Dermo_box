//
//  OverallMatchedViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/09/30.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit

class OverallMatchedViewController: BaseViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var skinToneChartLabel: UILabel!
    @IBOutlet var skinToneChartImageView: UIImageView!
    @IBOutlet var skinToneColorView: UIView!
    @IBOutlet var skinToneColorLabel: UILabel!
    @IBOutlet var rgbImageView: UIImageView!
    @IBOutlet var hsvImageView: UIImageView!
    @IBOutlet var labImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
}
