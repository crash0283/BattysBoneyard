//
//  GameScene.swift
//  FrightFlight
//
//  Created by Chris Rasch on 9/27/14.
//  Copyright (c) 2014 __Flip Flop Studios__. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: StartScene {
    

    var startButton = SKSpriteNode()
    
    
    
    override func didMoveToView(view: SKView) {
        
        
        staticBackground()
        
        titleName()
        
        startButton = SKSpriteNode (imageNamed: "startButton.png")
        startButton.name = "startButton"
        startButton.position = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) - 75)
        startButton.size = CGSizeMake(self.startButton.size.width / 6, self.startButton.size.height / 6)
        startButton.zPosition = 10
        self.addChild(startButton)
        
        var rotateStart = SKAction.rotateByAngle(0.25, duration: 1)
        var rotateStartBack = SKAction.rotateByAngle(-0.25, duration: 1)
        var rotateStartNeg = SKAction.rotateByAngle(-0.25, duration: 1)
        var rotateStartBegin = SKAction.rotateByAngle(0.25, duration: 1)

        var repeatStartSeq = SKAction.repeatActionForever(SKAction.sequence([rotateStart,rotateStartBack,rotateStartNeg,rotateStartBegin]))

        startButton.runAction(repeatStartSeq)
        
        
        
        
    }
    
    
    
    
    func staticBackground () {
        
        
        var backgroundTexture = SKTexture (imageNamed: "FrightFlight_BG.png")
        
        
        
            
        background = SKSpriteNode (texture: backgroundTexture)
        background.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 150)
        background.zPosition = 0
        
        self.addChild(background)
    
            
        
    }
    
    
    func titleName () {
        
        
        var frightFlightTitle = SKSpriteNode (imageNamed: "BattysBoneyardTitle.png")
        frightFlightTitle.position = CGPointMake((self.frame.size.width / 2) - 8, (self.frame.size.height / 2) + 100)
        frightFlightTitle.size = CGSizeMake(frightFlightTitle.size.width / 3, frightFlightTitle.size.height / 3)
        frightFlightTitle.zPosition = 10
        self.addChild(frightFlightTitle)
        
        
    }
    

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject? = touches.anyObject()
        let location = touch?.locationInNode(self)
        let node = nodeAtPoint(location!)
        
        if node.name == "startButton" {

            
            let transition = SKTransition.doorsOpenVerticalWithDuration(0.5)
            let scene = StartScene(size: self.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
            
            
        }
        
        
    }
    
    
}


