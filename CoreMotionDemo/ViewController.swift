//
//  ViewController.swift
//  CoreMotionDemo
//
//  Created by leacode on 14/10/28.
//  Copyright (c) 2014年 leacode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MotionDetectiveDelegate {
    
    var motionMonitor: MotionSynchronizer?

    @IBOutlet weak var orientationLabel: UILabel!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionMonitor = MotionSynchronizer()
        motionMonitor!.delegate = self
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let monitor = motionMonitor {
            monitor.startMonitorMotion()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let monitor = motionMonitor {
            monitor.stopMonitorMotion()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - MotionDetectiveDelegate
    func willRotateToInterfaceOrientation(deviceOrientation: UIDeviceOrientation) {
        if deviceOrientation == UIDeviceOrientation.Portrait {
            dispatch_async(dispatch_get_main_queue()) {
                self.orientationLabel.text = "Portrait"
                self.orientationLabel.transform = CGAffineTransformIdentity
            }
        }
        else if deviceOrientation == UIDeviceOrientation.LandscapeLeft {
            dispatch_async(dispatch_get_main_queue()) {
                self.orientationLabel.text = "LandscapeLeft"
                self.orientationLabel.transform = CGAffineTransformMakeRotation( CGFloat(-M_PI_2*3) )
            }
        }
        else if deviceOrientation == UIDeviceOrientation.LandscapeRight {
            dispatch_async(dispatch_get_main_queue()) {
                self.orientationLabel.text = "LandscapeRight"
                self.orientationLabel.transform = CGAffineTransformMakeRotation( CGFloat(M_PI_2*3) )
            }
        }
    }

}

