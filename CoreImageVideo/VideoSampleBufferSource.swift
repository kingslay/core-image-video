//
//  Library.swift
//  CoreImageVideo
//
//  Created by Chris Eidhof on 03/04/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import Foundation
import AVFoundation
import GLKit

let pixelBufferDict: [String:AnyObject] =
[kCVPixelBufferPixelFormatTypeKey as String: NSNumber(unsignedInt: kCVPixelFormatType_32BGRA)]


class VideoSampleBufferSource: NSObject {
    lazy var displayLink: CADisplayLink? = CADisplayLink(target: self, selector: "displayLinkDidRefresh:")
   
    
    let videoOutput: AVPlayerItemVideoOutput
    let consumer: CVPixelBuffer -> ()
    let player: AVPlayer
    
    init?(url: NSURL, consumer callback: CVPixelBuffer -> ()) {
        player = AVPlayer(URL: url)
        consumer = callback
        videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: pixelBufferDict)
        player.currentItem!.addOutput(videoOutput)
        super.init()
        start()
    }
    
    func start() {
        if let asset = player.currentItem?.asset {
            asset.loadValuesAsynchronouslyForKeys(["tracks"]) { [weak self] in
                let statu = asset.statusOfValueForKey("tracks", error: nil)
                if statu == .Loaded {
                    var inputParameters: [AVAudioMixInputParameters] = []
                    for track in asset.tracksWithMediaType(AVMediaTypeAudio) {
                        let audioInputParams = AVMutableAudioMixInputParameters()
                        audioInputParams.setVolume(0.0, atTime: kCMTimeZero)
                        audioInputParams.trackID = track.trackID
                        inputParameters.append(audioInputParams)
                    }
                    let audioZeroMix = AVMutableAudioMix()
                    audioZeroMix.inputParameters = inputParameters
                    if let strongself = self {
                        strongself.player.currentItem?.audioMix = audioZeroMix
                        strongself.displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
                        strongself.player.play()
                        
                    }
                }
            }
        }
    }
    
    func displayLinkDidRefresh(link: CADisplayLink) {
        let itemTime = videoOutput.itemTimeForHostTime(CACurrentMediaTime())
        if videoOutput.hasNewPixelBufferForItemTime(itemTime) {
            var presentationItemTime = kCMTimeZero
            let pixelBuffer = videoOutput.copyPixelBufferForItemTime(itemTime, itemTimeForDisplay: &presentationItemTime)
            consumer(pixelBuffer!)
        }   
    }
    deinit {
        self.displayLink?.invalidate()
        self.displayLink = nil
        self.player.pause()
    }
    
}