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

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setProgress(progress: CGFloat) {
        foregroundNode.setProgress(progress)
    }
    
}
