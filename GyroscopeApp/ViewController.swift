//
//  ViewController.swift
//  GyroscopeApp
//
//  Created by Chidi Emeh on 11/30/18.
//  Copyright © 2018 Chidi Emeh. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    let motionManager = CMMotionManager()
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !motionManager.isGyroAvailable {
            let alert = UIAlertController(title: "No gyro", message: "Gyroscope could not be loaded.", preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        motionManager.deviceMotionUpdateInterval = 0.2//1.0 / 60.0;
        motionManager.startGyroUpdates()
        self.timer = Timer(fire: Date(), interval: (0.2), repeats: true, block: { [weak self] (timer) in
            if let data = self?.motionManager.gyroData {
                self?.xLabel.text = data.rotationRate.x.description
                self?.yLabel.text = data.rotationRate.y.description
                self?.zLabel.text = data.rotationRate.z.description
            }
        })
        
        RunLoop.current.add(self.timer, forMode: .default)
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
            
            self.motionManager.startGyroUpdates()
        }
    }

}

