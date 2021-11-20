//
//  ThreeDViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/10/18.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import ChowisSDK

class ThreeDViewController: BaseViewController {

    @IBOutlet var openGLView: OpenGLView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageButton: UIButton!
    @IBOutlet var threeDButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    
    var image:UIImage?
    var threeDPath:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.openGLView.isHidden = false
        self.imageView.isHidden = true
        if let image = self.image, let threeDPath = self.threeDPath {
         print("THREE D: ", threeDPath)
            self.imageView.image = image
            var filePath = ""
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentDirectory = paths[0]
            filePath = documentDirectory.appendingFormat("/" + threeDPath)
            print("FILE PATH: ", filePath)
            self.openGLView.setContentsWith(image, threeDImagePath: filePath)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.closeButton.layer.cornerRadius = self.closeButton.frame.size.height / 2
        self.imageButton.layer.cornerRadius = self.imageButton.frame.size.height / 2
        self.threeDButton.layer.cornerRadius = self.threeDButton.frame.size.height / 2
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.openGLView.removeContents()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func threeDButtonPressed(_ sender: UIButton) {
        
        self.openGLView.isHidden = false
        self.imageView.isHidden = true
    }
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        
        self.openGLView.isHidden = true
        self.imageView.isHidden = false
    }
}
