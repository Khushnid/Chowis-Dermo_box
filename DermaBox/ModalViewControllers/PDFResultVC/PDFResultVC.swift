//
//  PDFResultVC.swift
//  Chowis Analysis Skin 2
//
//  Created by ~Akhtamov on 5/15/21.
//  Copyright © 2021 Chowis Co Ltd. All rights reserved.
//

import Foundation
import PDFKit

protocol PDFResultPopupViewControllerDelegate: AnyObject {
    func didSelectPDFResultViewControllerLeftButtonPressed()
    func didSelectPDFResultPopupViewControllerRightButtonPressed()
}

class PDFResultVC: BaseViewController {
    
    //MARK: - Outlets
    public var documentData: Data?
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: PDFResultPopupViewControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
      super.viewDidLoad()
      
      if let data = documentData {
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
      }
        self.setLocalization()
    }
    
    //MARK: - Layouts
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.leftButton.layer.cornerRadius = self.leftButton.frame.size.height / 2
        self.rightButton.layer.cornerRadius = self.rightButton.frame.size.height / 2
        
        self.leftButton.applyGradient(colours: [#colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1), #colorLiteral(red: 0.9150692821, green: 0.8693137169, blue: 0.5810949802, alpha: 1), #colorLiteral(red: 0.7779700756, green: 0.5936511159, blue: 0.0965700075, alpha: 1)], cornerRadius: self.leftButton.frame.size.height / 2)
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.delegate?.didSelectPDFResultPopupViewControllerRightButtonPressed()
        }
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.delegate?.didSelectPDFResultViewControllerLeftButtonPressed()
        }
    }
    
    func setLocalization() {
        leftButton.setTitle("Yes".localized, for: .normal)
        rightButton.setTitle("Close".localized, for: .normal)
        titleLabel.text = "Would you like to send the results\n to the costumer?".localized
    }
}
