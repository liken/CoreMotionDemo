//
//  YMotionSynchronizer.swift
//  CoreMotionDemo
//
//  Created by leacode on 14/8/4.
//  Copyright (c) 2014年 leacode. All rights reserved.
//
//  用于监听设备的方向变化，即便设备设置锁定了方向也可以监听。
//

import UIKit
import AVFoundation
import CoreMotion

class MotionSynchronizer: NSObject {
    
    weak var delegate: MotionDetectiveDelegate!
    
    private var motionQueue: NSOperationQueue!
    private var updateInterval: NSTimeInterval!
    private var motionManager: CMMotionManager!
    
    private var deviceOrientation : UIDeviceOrientation! {
    willSet {
        self.delegate.willRotateToInterfaceOrientation!(newValue)
    }
    }
    
    override init() {
        motionQueue = NSOperationQueue()
        motionQueue.maxConcurrentOperationCount = 1
        motionManager = CMMotionManager()
        super.init()
    }
    
    /*
        开始监听运动
    */
    func startMonitorMotion() {
        
        motionQueue = NSOperationQueue()
        
        if !self.motionManager.deviceMotionActive {
            self.motionManager.accelerometerUpdateInterval = 1
            self.motionManager.startDeviceMotionUpdates()
            
            let motionHandler: CMDeviceMotionHandler = {motion, error in
                self.detectDeviceOrientation(motion)
            }
            self.motionManager.accelerometerUpdateInterval = 60
            self.motionManager.startDeviceMotionUpdatesToQueue(self.motionQueue, withHandler: motionHandler)
        }
        
    }
    
    /*
        停止监听运动
    */
    func stopMonitorMotion() {
        if self.motionManager.deviceMotionActive {
            self.motionManager.stopDeviceMotionUpdates()
        }
    }
    
    func detectDeviceOrientation(motion:CMDeviceMotion) {
        
        let x = motion.gravity.x
        let y = motion.gravity.y
        
        var angle = atan2(y, x)
        
        if  angle >= -2.25 && angle <= -0.25
        {
            if self.deviceOrientation != UIDeviceOrientation.Portrait {
                self.deviceOrientation = .Portrait
            }
        }
        else if angle >= -1.75 && angle <= 0.75
        {
            if self.deviceOrientation != UIDeviceOrientation.LandscapeRight {
                self.deviceOrientation = .LandscapeRight
            }
        }
        else if angle >= 0.75 && angle <= 2.25
        {
            if self.deviceOrientation != UIDeviceOrientation.PortraitUpsideDown {
                self.deviceOrientation = .PortraitUpsideDown
            }
        }
        else if angle <= -2.25 || angle >= 2.25
        {
            if self.deviceOrientation != UIDeviceOrientation.LandscapeLeft {
                self.deviceOrientation = .LandscapeLeft
            }
        }
        
    }


}

/*
    监听运动委托
    实现委托方法可以获得设备的方向
*/
@objc protocol MotionDetectiveDelegate {
    
    optional func willRotateToInterfaceOrientation(deviceOrientation: UIDeviceOrientation)

}

