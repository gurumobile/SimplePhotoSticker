//
//  ViewController.swift
//  SimpleSticker
//
//  Created by Bogdan Dimitrov Filov on 10/12/16.
//  Copyright © 2016 Bogdan Dimitrov Filov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImgView: UIImageView!
    
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var gallaryBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var cameraBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var gallaryBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var minusBtnConstraint: NSLayoutConstraint!
    
    var stickersArray = [PinchZoomImageView]()
    
    let maximumImageHeight: CGFloat = 150.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button Actions...
    @IBAction func onCameraClick(sender: AnyObject) {
    }
    
    @IBAction func onGallaryClick(sender: AnyObject) {
    }
    
    @IBAction func onPlusClick(sender: AnyObject) {
        let randomImageNumber = arc4random_uniform(9) + 1
        
        // Get the Image
        let stickerImage = UIImage(named: "\(randomImageNumber)")
        
        // Create the sticker with the image
        let sticker = PinchZoomImageView(image: stickerImage)
        
        // Get the frame of the sticker
        var frame = sticker.frame
        
        // Create Random Origin Point
        let pointX = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width / 2)))
        
        // Resize and Place the sticker
        frame = CGRect(x: pointX, y: 0, width: frame.size.width, height: maximumImageHeight)
        
        // Position the sticker
        sticker.frame = frame
        
        // Add the sticker to the main view
        self.view.addSubview(sticker)
        
        // Add to the sticker array
        stickersArray.append(sticker)
    }

    @IBAction func onMinusClick(sender: AnyObject) {
        guard stickersArray.count > 0 else {
            return
        }
        
        let sticker = stickersArray.removeLast()
        sticker.removeFromSuperview()
    }
    
    @IBAction func onSaveClick(sender: AnyObject) {
        // Hide the buttons first!
        plusBtn.hidden = true
        saveBtn.hidden = true
        
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // Show the buttons again
        plusBtn.hidden = false
        saveBtn.hidden = false
        
        // Show alert
        let alertController = UIAlertController(title: "Image Saved", message:"Screen Saved to Photo Gallery", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

