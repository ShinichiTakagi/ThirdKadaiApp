//
//  ViewController.swift
//  ThirdKadaiApp
//
//  Created by 高木申一 on 2018/04/29.
//  Copyright © 2018年 高木申一. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var displayImageNo = 0
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButton(_ sender: Any) {
        displayImageNo += 1
        displayImage()
    }
    @IBOutlet weak var previousButton: UIButton!
    @IBAction func previousButton(_ sender: Any) {
        displayImageNo -= 1
        displayImage()
    }
    
    var timer: Timer!
    
    @objc func onTimer(timer: Timer) {
        displayImageNo += 1
        displayImage()
    }
    
    @IBAction func startOrPauseSlide(_ sender: Any) {
        if self.timer == nil {
            playButton.setTitle("Pause", for: .normal)
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
            nextButton.isEnabled = false
            previousButton.isEnabled = false
            
        }
        else if self.timer != nil {
            playButton.setTitle("Play", for: .normal)
            self.timer.invalidate()
            self.timer = nil
            nextButton.isEnabled = true
            previousButton.isEnabled = true
        }
    }
    
   
    
    @IBAction func onTapImage(_ sender: Any) {
        performSegue(withIdentifier: "Enlargement", sender: nil)
    }
    
    var image: UIImage!
    var imageNameArray = [
        "IMG_3458.jpg",
        "IMG_4743.jpg",
        "IMG_0753.jpg",
        "IMG_623.jpg"
    ]
    
    func displayImage() {
        if displayImageNo < 0 {
            displayImageNo = 3
        }
        
        if displayImageNo > 3 {
            displayImageNo = 0
        }
        
        let name = imageNameArray[displayImageNo]
        image = UIImage(named: name)
        imageView.image = image
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        image = UIImage(named: "IMG_3458.jpg")
        imageView.image = image
    }
    
    func segueEnlargementViewController() {
        self.performSegue(withIdentifier: "Enlargement", sender: self.image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Enlargement" {
            let enlargementViewController = segue.destination as! EnlargementViewController
             enlargementViewController.image = imageView.image
            if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil
                nextButton.isEnabled = true
                previousButton.isEnabled = true
            }
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }

}

