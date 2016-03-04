//
//  StaticVideoViewController.swift
//  CoreImageVideo
//
//  Created by Chris Eidhof on 03/04/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit
import AVFoundation

class StaticVideoViewController: UIViewController {
    var coreImageView: CoreImageView?
    var videoSource: VideoSampleBufferSource?
    
    var angleForCurrentTime: Float {
        return Float(NSDate.timeIntervalSinceReferenceDate() % M_PI*2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coreImageView = CoreImageView(frame: CGRectMake(0, 100,UIScreen.mainScreen().bounds.width , 200))
        self.view.addSubview(self.coreImageView!)
    }
    
    override func viewDidAppear(animated: Bool) {
//        let url = NSBundle.mainBundle().URLForResource("Cat", withExtension: "mp4")!
//        let url = NSURL(string: "http://sc.seeyouyima.com/audio/data/01.mp4")!
        let url = NSURL(string: "http://us.sinaimg.cn/002Ke8wLjx06ZLAB9GoE050d010000e90k01.m3u8")!

        videoSource = VideoSampleBufferSource(url: url) { [weak self] buffer in
//            let background = kaleidoscope()(image)
//            let mask = radialGradient(image.extent.center, radius: CGFloat(self.angleForCurrentTime) * 100)
//            let output = blendWithMask(image, mask: mask)(background)
            self?.coreImageView?.image = CIImage(CVPixelBuffer: buffer)
        }
    }
    override func viewDidDisappear(animated: Bool) {
        self.videoSource?.displayLink?.invalidate()
        self.videoSource?.displayLink = nil
        self.videoSource = nil
        self.coreImageView = nil
    }
}