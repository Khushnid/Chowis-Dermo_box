/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import PDFKit

class PDFCreator: NSObject {
    var logo : UIImage
    var customerName: String
    var customerDate: String
    var graph : UIImage
    var spider: UIImage
    var moisture : UIImage
    var TUZone : UIImage
    var poresImages : [UIImage] = []
    var spotsImages : [UIImage] = []
    var wrinklesImages : [UIImage] = []
    var impurityImages : [UIImage] = []
    var keratinImages : [UIImage] = []
    var UZoneImage : [UIImage] = []
    var TZoneImage : [UIImage] = []
    init(name: String, date: String, graph: UIImage, spider: UIImage, moisture: UIImage, TUZone: UIImage) {
        self.TUZone = TUZone
        self.customerName = name
        self.customerDate = date
        self.logo = #imageLiteral(resourceName: "mainLogo")
        self.graph = graph
        self.spider = spider
        self.moisture = moisture
    }

    
    func createFlyer() -> Data {
        self.initImage()
        // 1
        let pdfMetaData = [
            kCGPDFContextCreator: "DB Pisga",
            kCGPDFContextAuthor: " ",
            kCGPDFContextTitle: "diagnosis"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // 2
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        // 3
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        // 4
        let data = renderer.pdfData { (context) in
            // 5
            context.beginPage()
            let content = context.cgContext
            // 6
            let topY : CGFloat = 20.0
            let bottomY = drawBottom(content, pageRect: pageRect)
            let leftX = drawLeft(content, pageRect: pageRect)
            let rightX = drawRight(content, pageRect: pageRect)
            let logoBottom = drawTop(content, pageRect: pageRect)
            let titleBottom = drawMainTitle(content, pageRect: pageRect, textTop: logoBottom, textRight: rightX, textLeft: leftX,text: "Overall Results".localized)
            let graphBottom = drawGraph(content, pageRect: pageRect, leftX: leftX, topY: titleBottom, rightX: rightX)
            let spiderBottom = drawSpiderAndMoisture(pageRect: pageRect, leftX: leftX, topY: graphBottom, rightX: rightX)
            let TZoneLeft = drawSebumImage(content, pageRect: pageRect, leftX: leftX, topY: spiderBottom, text: "T Zone".localized, image: TZoneImage.last ?? #imageLiteral(resourceName: "defaultImage"))
            drawSebumImage(content, pageRect: pageRect, leftX: TZoneLeft, topY: spiderBottom, text: "U Zone".localized, image: UZoneImage.last ?? #imageLiteral(resourceName: "defaultImage"))
            drawTUZones(content, pageRect: pageRect, topY: spiderBottom, bottomY: bottomY, rightX: rightX)
            drawCustomerInfo(pageRect: pageRect, textTop: topY, textRight: rightX)
            
            context.beginPage()
            drawBottom(content, pageRect: pageRect)
            drawLeft(content, pageRect: pageRect)
            drawRight(content, pageRect: pageRect)
            drawTop(content, pageRect: pageRect)
            drawMainTitle(content, pageRect: pageRect, textTop: logoBottom, textRight: rightX, textLeft: leftX, text: "Captured Images".localized)
            let poresBottom = drawCollection(content, pageRect: pageRect, leftX: leftX, topY: titleBottom, rightX: rightX, text: "Pores".localized, images: poresImages)
            let spotsBottom = drawCollection(content, pageRect: pageRect, leftX: leftX, topY: poresBottom, rightX: rightX, text: "Spots".localized, images: spotsImages)
            let wrinklesBottom = drawCollection(content, pageRect: pageRect, leftX: leftX, topY: spotsBottom, rightX: rightX, text: "Wrinkles".localized, images: wrinklesImages)
            let impurityBottom = drawCollection(content, pageRect: pageRect, leftX: leftX, topY: wrinklesBottom, rightX: rightX, text: "Impurities".localized, images: impurityImages)
            drawCollection(content, pageRect: pageRect, leftX: leftX, topY: impurityBottom, rightX: rightX, text: "Keratin".localized, images: keratinImages)
        }
        
        return data
    }
    
    func initImage() {
        var diag = DiagData()
        
        // appending UZone Image
        if DiagnosisInformation.shared.sebumUZoneimages.isEmpty
        {  UZoneImage.append(#imageLiteral(resourceName: "defaultImage"))  }
        
        for i in 0 ..< DiagnosisInformation.shared.sebumUZoneimages.count {
            diag = DiagnosisInformation.shared.sebumUZoneimages[i]
            UZoneImage.append(Util.shared.getImageFromDatabase(fileName: diag.originalPath) ?? #imageLiteral(resourceName: "defaultImage"))
        }
        
        // appending TZone Image
        if DiagnosisInformation.shared.sebumTZoneImages.isEmpty
        {  TZoneImage.append(#imageLiteral(resourceName: "defaultImage"))  }
        
        for i in 0 ..< DiagnosisInformation.shared.sebumTZoneImages.count {
            diag = DiagnosisInformation.shared.sebumTZoneImages[i]
            TZoneImage.append(Util.shared.getImageFromDatabase(fileName: diag.originalPath) ?? #imageLiteral(resourceName: "defaultImage"))
        }
        
        // appending pores Image
        if DiagnosisInformation.shared.poresImages.isEmpty
        {  poresImages.append(#imageLiteral(resourceName: "defaultImage"))  }
        
        for i in 0 ..< DiagnosisInformation.shared.poresImages.count {
            diag = DiagnosisInformation.shared.poresImages[i]
            poresImages.append(Util.shared.getImageFromDatabase(fileName: diag.originalPath) ?? #imageLiteral(resourceName: "defaultImage"))
        }

        // appending spots Image
        if DiagnosisInformation.shared.spotsImages.isEmpty
        {  spotsImages.append(#imageLiteral(resourceName: "defaultImage"))  }
        
        for i in 0 ..< DiagnosisInformation.shared.spotsImages.count {
            diag = DiagnosisInformation.shared.spotsImages[i]
            spotsImages.append(Util.shared.getImageFromDatabase(fileName: diag.originalPath) ?? #imageLiteral(resourceName: "defaultImage"))
        }
        
        //appending wrinkles Image
        if DiagnosisInformation.shared.wrinklesImages.isEmpty
        {  wrinklesImages.append(#imageLiteral(resourceName: "defaultImage"))  }
        
        for i in 0 ..< DiagnosisInformation.shared.wrinklesImages.count {
            diag = DiagnosisInformation.shared.wrinklesImages[i]
            wrinklesImages.append(Util.shared.getImageFromDatabase(fileName: diag.originalPath) ?? #imageLiteral(resourceName: "defaultImage"))
        }
        
        //appending impurities Image
        if DiagnosisInformation.shared.impuritiesImages.isEmpty
        {  impurityImages.append(#imageLiteral(resourceName: "defaultImage")) }
        
        for i in 0 ..< DiagnosisInformation.shared.impuritiesImages.count {
            diag = DiagnosisInformation.shared.impuritiesImages[i]
            impurityImages.append(Util.shared.getImageFromDatabase(fileName: diag.originalPath) ?? #imageLiteral(resourceName: "defaultImage"))
        }
        
        //appending keratin Image
        if DiagnosisInformation.shared.keratinImages.isEmpty
        {  keratinImages.append(#imageLiteral(resourceName: "defaultImage")) }
        
        for i in 0 ..< DiagnosisInformation.shared.keratinImages.count {
            diag = DiagnosisInformation.shared.keratinImages[i]
            keratinImages.append(Util.shared.getImageFromDatabase(fileName: diag.originalPath) ?? #imageLiteral(resourceName: "defaultImage"))
        }
    }
    
    func drawTop(_ drawContext: CGContext, pageRect: CGRect) -> CGFloat {
        
        //Drawing 1st top frame
        drawContext.saveGState()
        drawContext.setLineWidth(3.0)
        drawContext.setStrokeColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        drawContext.move(to: CGPoint(x: 10, y: 20))
        drawContext.addLine(to: CGPoint(x: (pageRect.width * 0.40), y: 20))
        drawContext.strokePath()
        drawContext.restoreGState()
        
        let maxHeight = pageRect.height * 0.1
        let maxWidth = pageRect.width * 0.1
        
        //Draw logo image
        let aspectWidth = maxWidth / logo.size.width
        let aspectHeight = maxHeight / logo.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        
        let scaledWidth = logo.size.width * aspectRatio
        let scaledHeight = logo.size.height * aspectRatio
        
        let imageX = (( (pageRect.width * 0.40) + 10))
        let imageRect = CGRect(x: imageX, y: 5,
                               width: scaledWidth, height: scaledHeight)
        logo.draw(in: imageRect)
        
        //Drawing 2nd top frame
        drawContext.saveGState()
        drawContext.setLineWidth(3.0)
        drawContext.setStrokeColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        drawContext.move(to: CGPoint(x: pageRect.width - 10, y: 20))
        drawContext.addLine(to: CGPoint(x: imageX + imageRect.width + 10, y: 20))
        drawContext.strokePath()
        drawContext.restoreGState()
        
        //Returning top Y
        return imageRect.height
    }
    
    func drawCustomerInfo(pageRect: CGRect, textTop: CGFloat, textRight: CGFloat) {
        
        //Drawing name
        var customFont = UIFont(name: "STSong".localized, size: 16)
        let customColor = UIColor(red: 71/255, green: 72/255, blue: 71/255, alpha: 1)
        let nameTextAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: customFont, NSAttributedString.Key.foregroundColor: customColor]
        let attributedNameText = NSAttributedString(string: customerName, attributes: nameTextAttributes)
        let titleStringSize = attributedNameText.size()
        let titleStringRect = CGRect(x: textRight - titleStringSize.width - 10,
                                     y: textTop + 10, width: titleStringSize.width,
                                     height: titleStringSize.height)
        attributedNameText.draw(in: titleStringRect)
        let nameTextBottom = titleStringRect.origin.y + titleStringRect.size.height
        
        //Drawing Date
        customFont = UIFont(name: "STSong".localized, size: 14)
        let dateTextAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: customFont, NSAttributedString.Key.foregroundColor: customColor]
        let attributedDateText = NSAttributedString(string: customerDate, attributes: dateTextAttributes)
        let dateStringSize = attributedDateText.size()
        let dateStringRect = CGRect(x: textRight - dateStringSize.width - 10,
                                    y: nameTextBottom + 5, width: dateStringSize.width,
                                    height: dateStringSize.height)
        attributedDateText.draw(in: dateStringRect)
    }
    
    func drawMainTitle(_ drawContext: CGContext, pageRect: CGRect, textTop: CGFloat, textRight: CGFloat, textLeft: CGFloat, text: String) -> CGFloat {
        //Drawing main title
        var customFont = UIFont(name: "STSong".localized, size: 26)
        var customColor = UIColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        
        let titleTextAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: customFont, NSAttributedString.Key.foregroundColor: customColor]
        let attributedTitleText = NSAttributedString(string: "DIAGNOSTIC REPORT".localized, attributes: titleTextAttributes)
        let titleStringSize = attributedTitleText.size()
        let titleStringRect = CGRect(x: (pageRect.width / 4) ,
                                     y: textTop + 20, width: titleStringSize.width,
                                     height: titleStringSize.height)
        attributedTitleText.draw(in: titleStringRect)
        let titleBottom = titleStringRect.origin.y + titleStringRect.size.height
        
        
        //drawing overall result text
        customFont = UIFont(name: "STSong".localized, size: 20)
        customColor = UIColor(red: 71/255, green: 72/255, blue: 71/255, alpha: 1)
        let overallTitleAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: customFont, NSAttributedString.Key.foregroundColor: customColor]
        let attributedOverallTitleText = NSAttributedString(string: text, attributes: overallTitleAttributes)
        let overallTitleStringSize = attributedOverallTitleText.size()
        let overallStringRect = CGRect(x: (pageRect.width / 2 - overallTitleStringSize.width / 2),
                                       y: titleBottom + 10, width: overallTitleStringSize.width,
                                       height: overallTitleStringSize.height)
        attributedOverallTitleText.draw(in: overallStringRect)
        
        //Drawing left line
        drawContext.saveGState()
        drawContext.setLineWidth(2.0)
        drawContext.setStrokeColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        drawContext.move(to: CGPoint(x: textLeft + 5, y: titleBottom + 20))
        drawContext.addLine(to: CGPoint(x: (pageRect.width / 2 - overallTitleStringSize.width / 2) - 5, y: titleBottom + 20))
        drawContext.strokePath()
        drawContext.restoreGState()
        
        
        
        //drawing right line
        drawContext.saveGState()
        drawContext.setLineWidth(2.0)
        drawContext.setStrokeColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        drawContext.move(to: CGPoint(x: (overallStringRect.origin.x + overallStringRect.width + 5), y: titleBottom + 20))
        drawContext.addLine(to: CGPoint(x: textRight - 10, y: titleBottom + 20))
        drawContext.strokePath()
        drawContext.restoreGState()
        
        return titleBottom
    }
    
    func drawRight(_ drawContext: CGContext, pageRect: CGRect) -> CGFloat {
        //Drawing left frame
        drawContext.saveGState()
        drawContext.setLineWidth(3.0)
        drawContext.setStrokeColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        drawContext.move(to: CGPoint(x: pageRect.width - 10, y: 20))
        drawContext.addLine(to: CGPoint(x: pageRect.width - 10, y: pageRect.height - 20))
        drawContext.strokePath()
        drawContext.restoreGState()
        
        //Returning left X
        return pageRect.width - 10
    }
    
    func drawLeft(_ drawContext: CGContext, pageRect: CGRect) -> CGFloat {
        //Drawing right frame
        drawContext.saveGState()
        drawContext.setLineWidth(3.0)
        drawContext.setStrokeColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        drawContext.move(to: CGPoint(x: 10, y: 20))
        drawContext.addLine(to: CGPoint(x: 10, y: pageRect.height - 20))
        drawContext.strokePath()
        drawContext.restoreGState()
        
        //Returning right X
        return 10
    }
    
    func drawBottom(_ drawContext: CGContext, pageRect: CGRect) -> CGFloat {
        //Drawing bottom frame
        drawContext.saveGState()
        drawContext.setLineWidth(3.0)
        drawContext.setStrokeColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        drawContext.move(to: CGPoint(x: 10, y: pageRect.height - 20))
        drawContext.addLine(to: CGPoint(x: pageRect.width - 10, y: pageRect.height - 20))
        drawContext.strokePath()
        drawContext.restoreGState()
        
        //returning bottom Y
        return pageRect.height - 20
    }
    
    func drawGraph(_ drawContext: CGContext, pageRect: CGRect, leftX: CGFloat, topY: CGFloat, rightX: CGFloat) -> CGFloat {
        let maxHeight = pageRect.height * 0.3
        let maxWidth = pageRect.width * 0.9
        
        //drawing graph
        let aspectWidth = maxWidth / graph.size.width
        let aspectHeight = maxHeight / graph.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        
        let scaledWidth = graph.size.width * aspectRatio
        let scaledHeight = graph.size.height * aspectRatio
        
        let imageX = leftX + 40
        let imageRect = CGRect(x: imageX, y: topY + 50,
                               width: scaledWidth, height: scaledHeight)
        graph.draw(in: imageRect)
        
        //draw line
        drawContext.saveGState()
        drawContext.setLineWidth(2.0)
        drawContext.setStrokeColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        drawContext.move(to: CGPoint(x: leftX + 10, y: imageRect.origin.y + imageRect.height + 10))
        drawContext.addLine(to: CGPoint(x: rightX - 10, y: imageRect.origin.y + imageRect.height + 10))
        drawContext.strokePath()
        drawContext.restoreGState()
        
        return (imageRect.origin.y + imageRect.height + 10)
    }
    
    func drawSpiderAndMoisture(pageRect: CGRect, leftX: CGFloat, topY: CGFloat, rightX: CGFloat) -> CGFloat {
        
        let maxHeight = pageRect.height * 0.3
        let maxWidth = pageRect.width * 0.5
        
        //drawing graph
        var aspectWidth = maxWidth / spider.size.width
        var aspectHeight = maxHeight / spider.size.height
        var aspectRatio = min(aspectWidth, aspectHeight)
        
        var scaledWidth = spider.size.width * aspectRatio
        var scaledHeight = spider.size.height * aspectRatio
        
        var imageX = leftX - 40
        var imageRect = CGRect(x: imageX, y: topY + 10,
                               width: scaledWidth + 100, height: scaledHeight + 80)
        spider.draw(in: imageRect)
        
        //drawing moisture
        aspectWidth = maxWidth / moisture.size.width
        aspectHeight = maxHeight / moisture.size.height
        aspectRatio = min(aspectWidth, aspectHeight)
        
        scaledWidth = moisture.size.width * aspectRatio
        scaledHeight = moisture.size.height * aspectRatio
        
        //imageX = imageRect.origin.x + imageRect.width
        imageX = rightX - scaledWidth - 10
        imageRect = CGRect(x: imageX , y: topY + 10,
                           width: scaledWidth, height: scaledHeight)
        moisture.draw(in: imageRect)
        
        return imageRect.origin.y + imageRect.height
    }
    
    func drawCollection(_ drawContext: CGContext, pageRect: CGRect, leftX: CGFloat, topY: CGFloat, rightX: CGFloat, text: String, images: [UIImage]) -> CGFloat {
        
        //Drawing main title
        var customFont = UIFont(name: "STSong".localized, size: 20)
        var customColor = UIColor(red: 71/255, green: 72/255, blue: 71/255, alpha: 1)
        let titleTextAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: customFont, NSAttributedString.Key.foregroundColor: customColor]
        let attributedTitleText = NSAttributedString(string: text, attributes: titleTextAttributes)
        let titleStringSize = attributedTitleText.size()
        let titleStringRect = CGRect(x: leftX + 20,
                                     y: topY + 30, width: titleStringSize.width,
                                     height: titleStringSize.height)
        attributedTitleText.draw(in: titleStringRect)
        let titleBottom = titleStringRect.origin.y + titleStringRect.size.height
        
        //Drawing line
        drawContext.saveGState()
        drawContext.setLineWidth(2.0)
        drawContext.setStrokeColor(red: 162/255, green: 126/255, blue: 47/255, alpha: 1)
        drawContext.move(to: CGPoint(x: (titleStringRect.origin.x + titleStringRect.width + 10), y: topY + 40))
        drawContext.addLine(to: CGPoint(x: rightX - 30, y: topY + 40))
        drawContext.strokePath()
        drawContext.restoreGState()
        
        //drawing collections
        let maxHeight : CGFloat = 120
        let maxWidth = (pageRect.width - 100) / 5
        var collectionImageRect : [CGRect] = []
        for i in 0 ..< images.count {
            let aspectWidth = maxWidth / images[i].size.width
            let aspectHeight = maxHeight / images[i].size.height
            let aspectRatio = min(aspectWidth, aspectHeight)
            
            let scaledWidth = images[i].size.width * aspectRatio
            let scaledHeight = images[i].size.height * aspectRatio
            var imageX : CGFloat = 0
            if i == 0
            {  imageX = leftX + 10  }
            else
            {  imageX = collectionImageRect[i-1].origin.x + collectionImageRect[i-1].width + 10  }
            
            let imageRect = CGRect(x: imageX, y: titleBottom + 10,
                                   width: scaledWidth, height: scaledHeight)
            collectionImageRect.append(imageRect)
            images[i].draw(in: imageRect)
        }
        
        return collectionImageRect[0].origin.y + collectionImageRect[0].height - 10
    }
    
    func drawSebumImage(_ drawContext: CGContext, pageRect: CGRect, leftX: CGFloat, topY: CGFloat, text: String, image: UIImage) -> CGFloat {
        
        //Drawing main title
        var customFont = UIFont(name: "STSong".localized, size: 20)
        var customColor = UIColor(red: 71/255, green: 72/255, blue: 71/255, alpha: 1)
        let titleTextAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: customFont, NSAttributedString.Key.foregroundColor: customColor]
        let attributedTitleText = NSAttributedString(string: text, attributes: titleTextAttributes)
        let titleStringSize = attributedTitleText.size()
        let titleStringRect = CGRect(x: leftX + 20,
                                     y: topY + 30, width: titleStringSize.width,
                                     height: titleStringSize.height)
        attributedTitleText.draw(in: titleStringRect)
        let titleBottom = titleStringRect.origin.y + titleStringRect.size.height
     
        let maxHeight : CGFloat = 120
        let maxWidth = (pageRect.width - 100) / 5
        let aspectWidth = maxWidth / image.size.width
        let aspectHeight = maxHeight / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        
        let scaledWidth = image.size.width * aspectRatio
        let scaledHeight = image.size.height * aspectRatio
        
        let imageRect = CGRect(x: leftX + 10, y: titleBottom + 10,
                               width: scaledWidth, height: scaledHeight)
        image.draw(in: imageRect)
        
        return imageRect.origin.x + imageRect.width
    }
    
    func drawTUZones(_ drawContext: CGContext, pageRect: CGRect, topY: CGFloat, bottomY: CGFloat,  rightX: CGFloat)  {
        let maxHeight = bottomY - (topY + 10)
        let maxWidth = pageRect.width * 0.7
        
        let aspectWidth = maxWidth / TUZone.size.width
        let aspectHeight = maxHeight / TUZone.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        
        let scaledWidth = TUZone.size.width * aspectRatio
        let scaledHeight = TUZone.size.height * aspectRatio
        
        let imageX = rightX - scaledWidth - 5
        let imageRect = CGRect(x: imageX , y: topY + 10,
                           width: scaledWidth - 20, height: scaledHeight)
        TUZone.draw(in: imageRect)
    }

}
