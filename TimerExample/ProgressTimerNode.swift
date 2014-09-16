//
//  ProgressTimerNode.swift
//  TimerExample
//
//  Created by Andrew Cavanagh on 9/15/14.
//  Copyright (c) 2014 Tortuca Labs. All rights reserved.
//

import UIKit
import SpriteKit

class ProgressTimerNode: SKSpriteNode {
   
    var running: Bool = false
    var startTime: NSTimeInterval!
    var duration: NSTimeInterval!
    
    private var foregroundNode: ProgressTimerForegroudCropNode!
    private var backgroundNode: SKSpriteNode!
    private var accessoryNode: SKSpriteNode!
    
    init(foregroundImageName: String?, backgroundImageName: String?, accessoryImageName: String?) {

        var foregroundTexture: SKTexture?
        var backgroundTexture: SKTexture?
        var accessoryTexture: SKTexture?
        
        if let uForegroundImageName = foregroundImageName {
            foregroundTexture = SKTexture(imageNamed: uForegroundImageName)
        }
        
        if let uBackgroundImageName = backgroundImageName {
            backgroundTexture = SKTexture(imageNamed: uBackgroundImageName)
        }
        
        if let uAccessoryImageName = accessoryImageName {
            accessoryTexture = SKTexture(imageNamed: uAccessoryImageName)
        }
        
        super.init(texture: nil, color: UIColor.clearColor(), size: foregroundTexture!.size())
        
        setupBackgroundSpriteNode(backgroundTexture)
        setupForegroundSpriteNode(foregroundTexture)
        setupAccessorySpriteNode(accessoryTexture)
    }
    
    func runWithDuration(duration: NSTimeInterval) {
        self.stopRunning()
        self.startTime = CFAbsoluteTimeGetCurrent()
        self.duration = duration
        running = true
    }
    
    func stopRunning() {
        running = false
        self.setProgress(0)
    }
    
    func calculateProgress(systemTime: CFTimeInterval) {
        if (running) {
            let elapsedTime: NSTimeInterval = CFAbsoluteTimeGetCurrent() - startTime
            let progress: CGFloat = CGFloat(elapsedTime / duration)
            self.setProgress(progress)
            
            if (progress >= 1) {
                self.stopRunning()
            }
        }
    }
    
    private func setProgress(progress: CGFloat) {
        foregroundNode.setProgress(progress)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupBackgroundSpriteNode(texture: SKTexture?) {
        if let backgroundTexture = texture {
            backgroundNode = SKSpriteNode(texture: backgroundTexture)
            backgroundNode.zPosition = -1
            self.addChild(backgroundNode)
        }
    }
    
    private func setupForegroundSpriteNode(texture: SKTexture?) {
        if let foregroundTexture = texture {
            foregroundNode = ProgressTimerForegroudCropNode(texture: foregroundTexture)
            foregroundNode.zPosition = 0
            self.addChild(foregroundNode)
        }
    }
    
    private func setupAccessorySpriteNode(texture: SKTexture?) {
        if let accessoryTexture = texture {
            accessoryNode = SKSpriteNode(texture: accessoryTexture)
            accessoryNode.zPosition = 1
            self.addChild(accessoryNode)
        }
    }
    
    class ProgressTimerForegroudCropNode: SKCropNode {
        
        var indicatorSpriteNode: SKSpriteNode!
        var maskShapeNode: SKShapeNode!
        var radius: CGFloat!
        
        convenience init(texture: SKTexture) {
            self.init()
            radius = texture.size().width * 0.5
            initIndicatorSpriteNode(texture)
            initMaskShapeNode()
        }
        
        func initIndicatorSpriteNode(texture: SKTexture) {
            indicatorSpriteNode = SKSpriteNode(texture: texture)
            self.addChild(indicatorSpriteNode)
        }
        
        func initMaskShapeNode() {
            maskShapeNode = SKShapeNode.node()
            maskShapeNode.antialiased = false
            maskShapeNode.lineWidth = indicatorSpriteNode.texture!.size().width
            self.maskNode = maskShapeNode
        }
        
        func setProgress(progress: CGFloat) {
            var indicatorProgress: CGFloat = 1.0 - progress
            var startAngle: CGFloat = CGFloat(M_PI * 0.5)
            var endAngle: CGFloat = startAngle + (indicatorProgress * 2.0 * CGFloat(M_PI))
            
            var path = UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
            
            self.maskShapeNode.path = path.CGPath
        }
        
    }
    
}
