//
//  LoadingPopupViewController.swift
//  Chowis Analysis Skin 2
//
//  Created by Bekzod Rakhmatov on 2020/10/03.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol LoadingPopupViewControllerDelegate: AnyObject {
    
    func didSelectLoadingPopupViewControllerDoneLoading(done: Bool)
}

class LoadingPopupViewController: BaseViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var loaderHolderView: UIView!
    var loaderView :NVActivityIndicatorView!
    
    weak var delegate: LoadingPopupViewControllerDelegate?
    
    var titleText:String?
    var messageText:String?
    var buttonText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let titleText = self.titleText {
            
            self.titleLabel.text = titleText
        }
        
        if let messageText = self.messageText {
            
            self.messageLabel.text = messageText
        }
        
        if let buttonText = self.buttonText {
            
            self.cancelButton.setTitle(buttonText, for: .normal)
        }
        
        let xAxis = self.loaderHolderView.bounds.midX
        let yAxis = self.loaderHolderView.bounds.midY
        let progressHeight: CGFloat = self.loaderHolderView.frame.size.height
        let frame = CGRect(x: (xAxis - (progressHeight / 2)), y: (yAxis - (progressHeight / 2)), width: progressHeight, height: progressHeight)
        self.loaderView = NVActivityIndicatorView(frame: frame)
        self.loaderHolderView.addSubview(loaderView)
        self.loaderView.type = .ballSpinFadeLoader
        self.loaderView.color = #colorLiteral(red: 1, green: 0.8235294118, blue: 0.2509803922, alpha: 1)
        self.loaderView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.dismiss(animated: true) {
                
                self.delegate?.didSelectLoadingPopupViewControllerDoneLoading(done: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height / 2
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
