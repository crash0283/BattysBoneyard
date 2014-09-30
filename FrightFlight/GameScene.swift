//
//  GameScene.swift
//  FrightFlight
//
//  Created by Chris Rasch on 9/27/14.
//  Copyright (c) 2014 __Flip Flop Studios__. All rights reserved.
//

import SpriteKit

class GameScene: StartScene {

    var startButton = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        
        staticBackground()
        
        titleName()
        
        startButton = SKSpriteNode (imageNamed: "play.png")
        startButton.name = "startButton"
        startButton.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 30)
        startButton.size = CGSizeMake(self.startButton.size.width / 12, self.startButton.size.height / 12)
        startButton.zPosition = 10
        self.addChild(startButton)
        
        
    }
    
    
    
    
    func staticBackground () {
        
        
        var backgroundTexture = SKTexture (imageNamed: "FrightFlight_BG.png")
        
        
        
            
        background = SKSpriteNode (texture: backgroundTexture)
        background.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 150)
        background.zPosition = 0
        
        self.addChild(background)
    
            
        
    }
    
    
    func titleName () {
        
        
        var frightFlightTitle = SKSpriteNode (imageNamed: "FrightFlightLogo.png")
        frightFlightTitle.position = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) + 100)
        frightFlightTitle.zPosition = 10
        self.addChild(frightFlightTitle)
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject? = touches.anyObject()
        let location = touch?.locationInNode(self)
        let node = nodeAtPoint(location!)
        
        if node.name == "startButton" {
            
            let transition = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 1)
            let scene = StartScene(size: self.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
            
            
        }
        
        
    }
    
    
}


