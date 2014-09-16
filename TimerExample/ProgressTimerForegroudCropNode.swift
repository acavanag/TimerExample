//
//  ProgressTimerForegroudCropNode.swift
//  TimerExample
//
//  Created by Andrew Cavanagh on 9/15/14.
//  Copyright (c) 2014 Tortuca Labs. All rights reserved.
//

import UIKit
import SpriteKit

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
