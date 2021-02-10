//
//  ShareVC.swift
//  HEMPDAY
//
//  Created by admin on 12/29/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class ShareVC: UIViewController ,UIDocumentInteractionControllerDelegate{
    
    @IBOutlet weak var qrcodeImageView: UIImageView!
    
    var generatedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrcodeImageView.image = generateQRCode(from: "https://ioair.link/hxbvc3")
        generatedImage = qrcodeImageView.image
        shareQrCode()
        print("generatedImage",generatedImage)
         }
    
    func shareQrCode(){
        
        guard let validQR = generatedImage else { return }
        let activityItem: [UIImage] = [validQR]
        let activityController = UIActivityViewController(activityItems: activityItem as [UIImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
         
    @IBAction func backButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
         
    func generateQRCode(from string:String) -> UIImage? {
             
            let data = string.data(using: String.Encoding.ascii)
             
            if let filter = CIFilter(name: "CIQRCodeGenerator"){
                 
            filter.setValue(data, forKey: "inputMessage")
                 
            let transform = CGAffineTransform(scaleX: 3, y: 3)
                 
            if let output = filter.outputImage?.transformed(by: transform) {
                     return UIImage(ciImage: output)
                 }
             }
             return nil
         }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
