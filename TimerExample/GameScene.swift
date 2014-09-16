//
//  GameScene.swift
//  TimerExample
//
//  Created by Andrew Cavanagh on 9/15/14.
//  Copyright (c) 2014 Tortuca Labs. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var timer: ProgressTimerNode!
    let startTime: CGFloat = CGFloat(CACurrentMediaTime())
    let kCyclesPerSecond: CGFloat = 0.25
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.whiteColor()
        
        timer = ProgressTimerNode(foregroundImageName: "progress_foreground", backgroundImageName: "progress_background", accessoryImageName: "progress_accessory")
        
        timer.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
        
        self.addChild(timer)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        super.update(currentTime)
        
        let floatTime = CGFloat(currentTime)
        let secondsElapsed: CGFloat = floatTime - startTime
        let cycle: CGFloat = secondsElapsed * kCyclesPerSecond
        let progress: CGFloat = cycle - CGFloat(Int(cycle))
        
        timer.setProgress(progress)
        
    }
}
