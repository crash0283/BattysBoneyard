//
//  StartScene.swift
//  FrightFlight
//
//  Created by Chris Rasch on 9/27/14.
//  Copyright (c) 2014 __Flip Flop Studios__. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    //Define Sprites
    var bat = SKSpriteNode()
    var deadBat = SKSpriteNode()
    var background = SKSpriteNode()
    var topObject = SKSpriteNode()
    var topObject2 = SKSpriteNode()
    var bottomObject = SKSpriteNode()
    var bottomObject2 = SKSpriteNode()
    var restartButton = SKSpriteNode()
    var backToMenuButton = SKSpriteNode()
    
    //Define collision masks
    let batGroup: UInt32 = 1
    let objectGroup: UInt32 = 2
    let gapGroup: UInt32 = 0 << 3
    
    var movingObjects = SKNode()
    
    var gameOver = 0
    var score = 0
    var theScoreTitle = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var gameOverLabel = SKSpriteNode()
    var startDirections = SKLabelNode()
    
    var labelHolder = SKNode()
    var startGame = 1
    var highScoreLabel = SKLabelNode()
    var highScore = Int()
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        movingObjects.speed = 0
        
        self.addChild(movingObjects)
        self.addChild(labelHolder)
        
        
        //Give Scene Gravity
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        
        //Create label for score
        scoreLabel.fontName = "Scary Halloween Font"
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = SKColor.yellowColor()
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) + 240)
        scoreLabel.alpha = 0
        scoreLabel.zPosition = 20
        self.addChild(scoreLabel)
        
        theScoreTitle.fontName = "Scary Halloween Font"
        theScoreTitle.fontSize = 50
        theScoreTitle.fontColor = SKColor.yellowColor()
        theScoreTitle.text = "Score:"
        theScoreTitle.position = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) + 320)
        theScoreTitle.alpha = 0
        theScoreTitle.zPosition = 20
        self.addChild(theScoreTitle)
        
        
        
        
        //Create label for start directions
        startDirections.fontName = "Scary Halloween Font"
        startDirections.fontSize = 40
        startDirections.text = "Tap To Start!"
        startDirections.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 100)
        startDirections.zPosition = 20
        self.addChild(startDirections)
        
        //Create bird texture
        var batTexture = SKTexture (imageNamed: "eye_bat_walk1.png")
        var batTexture2 = SKTexture (imageNamed: "eye_bat_walk2.png")
        var batTexture3 = SKTexture (imageNamed: "eye_bat_walk3.png")
        var batTexture4 = SKTexture (imageNamed: "eye_bat_walk4.png")
        
        //Init background
        makeBackground()
        
        //Create bird animation
        var animation = SKAction.animateWithTextures([batTexture,batTexture2,batTexture3,batTexture4], timePerFrame: 0.1)
        var makeBatFlap = SKAction.repeatActionForever(animation)
        
        //Setup bird position and physics
        bat = SKSpriteNode (texture: batTexture)
        bat.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bat.zPosition = 10
        bat.physicsBody = SKPhysicsBody (rectangleOfSize: CGSizeMake(bat.size.width / 2, bat.size.height / 2))
        bat.physicsBody?.dynamic = false
        bat.physicsBody?.allowsRotation = false
        bat.physicsBody?.categoryBitMask = batGroup
        bat.physicsBody?.collisionBitMask = gapGroup
        bat.physicsBody?.contactTestBitMask = objectGroup
        
        self.addChild(bat)
        bat.runAction(makeBatFlap)
        
        
        
        //Make scene a collider
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        ground.physicsBody?.categoryBitMask = objectGroup
        self.addChild(ground)
        
        //Create timer for pipes
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("makeCollisionObjects"), userInfo: nil, repeats: true)
        
        
    }
    
    func makeBackground() {
        
        
        var backgroundTexture = SKTexture (imageNamed: "FrightFlight_BG.png")
        
        var moveBg = SKAction.moveByX(-backgroundTexture.size().width, y: 0, duration: 9)
        var replaceBg = SKAction.moveByX(backgroundTexture.size().width, y: 0, duration: 0)
        
        var moveBgForever = SKAction.repeatActionForever(SKAction.sequence([moveBg,replaceBg]))
        
        for var i: CGFloat = 0; i < 3; i++ {
            
            background = SKSpriteNode (texture: backgroundTexture)
            background.position = CGPoint(x: backgroundTexture.size().width / 2 + backgroundTexture.size().width * i, y: CGRectGetMidY(self.frame) + 150)
            background.zPosition = 0
            
            background.runAction(moveBgForever)
            movingObjects.addChild(background)

            
            
        }
        
        
    }
    
    func makeCollisionObjects() {
        
        if gameOver == 0 && movingObjects.speed == 1 {
            
            var topObjectTexture = SKTexture (imageNamed: "skeleton.png")
            var topObjectTexture2 = SKTexture (imageNamed: "skeleton_02.png")
            var bottomObjectTexture = SKTexture (imageNamed: "graveStoneGround.png")
            var bottomObjectTexture2 = SKTexture (imageNamed: "newGraveGround_02.png")
            
            let gapHeight = bat.size.height * 2
            var movementAmount = arc4random() % UInt32(self.frame.height / 2)
            var objectOffset = CGFloat(movementAmount) - self.frame.size.height / 4
            
            
            var moveObjects = SKAction.moveByX(-self.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))
            var removeObjects = SKAction.removeFromParent()
            var objectSeq = SKAction.sequence([moveObjects,removeObjects])
            
            
            var randomObjects = arc4random() % 2
            var gap = SKNode()
            
            
            if randomObjects == 0 {
                
                topObject = SKSpriteNode (texture: topObjectTexture)
                topObject.position = CGPointMake(self.frame.width / 2 + self.frame.width, self.frame.height / 2 + topObject.size.height / 2 + gapHeight / 2 + objectOffset)
                topObject.zPosition = 1
                topObject.physicsBody = SKPhysicsBody (rectangleOfSize: CGSizeMake((topObject.size.width) / 2, topObject.size.height))
                topObject.physicsBody?.dynamic = false
                topObject.physicsBody?.categoryBitMask = objectGroup
            
            
            
                movingObjects.addChild(topObject)
                topObject.runAction(objectSeq)
                
                bottomObject = SKSpriteNode (texture: bottomObjectTexture)
                bottomObject.position = CGPointMake(self.frame.width / 2 + self.frame.width, self.frame.height / 2 - bottomObject.size.height / 2 - gapHeight / 2 + objectOffset)
                bottomObject.zPosition = 2
                bottomObject.physicsBody = SKPhysicsBody (rectangleOfSize: CGSizeMake((bottomObject.size.width) / 2, bottomObject.size.height))
                bottomObject.physicsBody?.dynamic = false
                bottomObject.physicsBody?.categoryBitMask = objectGroup
                
                movingObjects.addChild(bottomObject)
                bottomObject.runAction(objectSeq)
                

                gap.position = CGPointMake(self.frame.width / 2 + self.frame.width, self.frame.height / 2 + objectOffset)
                gap.physicsBody = SKPhysicsBody (rectangleOfSize: CGSize(width: topObject.frame.size.width / 4, height: gapHeight))
                gap.physicsBody?.dynamic = false
                gap.physicsBody?.collisionBitMask = gapGroup
                gap.physicsBody?.categoryBitMask = gapGroup
                gap.physicsBody?.contactTestBitMask = batGroup
                movingObjects.addChild(gap)
                gap.runAction(objectSeq)
                
            } else if randomObjects == 1 {
            
                topObject2 = SKSpriteNode (texture: topObjectTexture2)
                topObject2.position = CGPointMake(self.frame.width / 2 + self.frame.width, self.frame.height / 2 + topObject2.size.height / 2 + gapHeight / 2 + objectOffset)
                topObject2.zPosition = 1
                topObject2.physicsBody = SKPhysicsBody (rectangleOfSize: CGSizeMake((topObject2.size.width) / 2, topObject2.size.height))
                topObject2.physicsBody?.dynamic = false
                topObject2.physicsBody?.categoryBitMask = objectGroup
                
                
                
                movingObjects.addChild(topObject2)
                topObject2.runAction(objectSeq)
                
                bottomObject2 = SKSpriteNode (texture: bottomObjectTexture2)
                bottomObject2.position = CGPointMake(self.frame.width / 2 + self.frame.width, self.frame.height / 2 - bottomObject2.size.height / 2 - gapHeight / 2 + objectOffset)
                bottomObject2.zPosition = 2
                bottomObject2.physicsBody = SKPhysicsBody (rectangleOfSize: CGSizeMake((bottomObject2.size.width) / 2, bottomObject2.size.height))
                bottomObject2.physicsBody?.dynamic = false
                bottomObject2.physicsBody?.categoryBitMask = objectGroup
                
                movingObjects.addChild(bottomObject2)
                bottomObject2.runAction(objectSeq)
                
                gap.position = CGPointMake(self.frame.width / 2 + self.frame.width, self.frame.height / 2 + objectOffset)
                gap.physicsBody = SKPhysicsBody (rectangleOfSize: CGSize(width: topObject2.frame.size.width / 4, height: gapHeight))
                gap.physicsBody?.dynamic = false
                gap.physicsBody?.collisionBitMask = gapGroup
                gap.physicsBody?.categoryBitMask = gapGroup
                gap.physicsBody?.contactTestBitMask = batGroup
                movingObjects.addChild(gap)
                gap.runAction(objectSeq)
               
            }
            
            
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        if contact.bodyA.categoryBitMask == gapGroup || contact.bodyB.categoryBitMask == gapGroup {
            
            score++
            scoreLabel.text = String(score)
            
            
            
        } else {
            
            if gameOver == 0 {
                
                gameOver = 1
                movingObjects.speed = 0
                
                var pulseRed = SKAction.sequence([SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.1), SKAction.colorizeWithColorBlendFactor(0.0, duration: 0.2)])
                
                
                deadBat = SKSpriteNode (imageNamed: "eye_bat_dead.png")
                deadBat.position = CGPointMake(bat.position.x, bat.position.y)
                bat.alpha = 0
                self.addChild(deadBat)
                
                deadBat.physicsBody = SKPhysicsBody (rectangleOfSize: CGSizeMake(deadBat.size.width / 2, deadBat.size.height / 2))
                deadBat.physicsBody?.dynamic = true
                deadBat.physicsBody?.allowsRotation = false
                deadBat.zPosition = 10
                deadBat.physicsBody?.categoryBitMask = batGroup
                deadBat.physicsBody?.collisionBitMask = gapGroup
                deadBat.physicsBody?.contactTestBitMask = objectGroup
                
                deadBat.runAction(pulseRed)
                
                
                
                gameOverLabel = SKSpriteNode (imageNamed: "NewGameOver.png")
                gameOverLabel.position = CGPointMake(self.frame.width / 2, self.frame.height + 100)
                
                var moveLabelTo = SKAction.moveToY(self.frame.height / 2 + 10, duration: 0.5)
                var scaleLabel = SKAction.scaleTo(0.35, duration: 0.5)
                //var redLabel = SKAction.colorizeWithColor(SKColor .redColor(), colorBlendFactor: 1, duration: 0.5)
                
                var groupLabel = SKAction.group([moveLabelTo,scaleLabel])
                gameOverLabel.runAction(groupLabel)
                
                gameOverLabel.zPosition = 20
                labelHolder.addChild(gameOverLabel)
                
                var restartButtonTexture = SKTexture(imageNamed: "restartButton.png")
                restartButton = SKSpriteNode (texture: restartButtonTexture)
                restartButton.position = CGPointMake((self.frame.size.width / 2) - 100, (self.frame.size.height / 2) - 500)
                restartButton.size = CGSizeMake(150, 150)
                var moveRestart = SKAction.moveToY(self.frame.size.height / 2 - 100, duration: 0.15)
                labelHolder.addChild(restartButton)
                restartButton.runAction(moveRestart)
                restartButton.zPosition = 20
                restartButton.name = "restartButton"
                
                var backToMenuButtonTexture = SKTexture(imageNamed: "backButton.png")
                backToMenuButton = SKSpriteNode (texture: backToMenuButtonTexture)
                backToMenuButton.position = CGPointMake((self.frame.size.width / 2) + 140, (self.frame.size.height / 2) - 500)
                backToMenuButton.size = CGSizeMake(150, 150)
                var moveBack = SKAction.moveToY(self.frame.size.height / 2 - 100, duration: 0.15)
                labelHolder.addChild(backToMenuButton)
                backToMenuButton.runAction(moveBack)
                backToMenuButton.zPosition = 100
                backToMenuButton.name = "backToMenuButton"
                
                NSUserDefaults.standardUserDefaults().integerForKey("highscore")
                
                if score > NSUserDefaults.standardUserDefaults().integerForKey("highscore") {
                    
                    NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "highscore")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                }
                
                highScore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
                
                
                //Create label for score
                highScoreLabel.fontName = "Scary Halloween Font"
                highScoreLabel.fontSize = 32
                highScoreLabel.fontColor = SKColor.redColor()
                highScoreLabel.text = "High Score: \(highScore)"
                highScoreLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 30)
                highScoreLabel.zPosition = 20
                highScoreLabel.alpha = 1
                labelHolder.addChild(highScoreLabel)
                
                
                
                
                
                
            }
        }
        
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
        if gameOver == 0 {
            
            startDirections.alpha = 0
            scoreLabel.alpha = 1
            theScoreTitle.alpha = 1


            bat.physicsBody?.velocity = CGVectorMake(0, 0)
            bat.physicsBody?.applyImpulse(CGVectorMake(0, 200))
            startGame = 0
            
            if startGame == 0 {
                
                bat.physicsBody?.dynamic = true
                movingObjects.speed = 1
                
            }
            
        } else {
            
            var touch: AnyObject? = touches.anyObject()
            var location = touch?.locationInNode(self)
            var node = nodeAtPoint(location!)
            
            if node.name == "restartButton" {
                
                deadBat.alpha = 0
                bat.alpha = 1
                score = 0
                scoreLabel.text = "0"
                startDirections.alpha = 1
                theScoreTitle.alpha = 0
                scoreLabel.alpha = 0
                movingObjects.removeAllChildren()
                makeBackground()
                bat.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
                labelHolder.removeAllChildren()
                bat.physicsBody?.velocity = CGVectorMake(0, 0)
                startGame = 1
                bat.physicsBody?.dynamic = false
                
                gameOver = 0
                
                
                
                movingObjects.speed = 0
                restartButton.alpha = 0
                backToMenuButton.alpha = 0
                highScoreLabel.alpha = 0
                
                
            } else if node.name == "backToMenuButton" {
                
                let transitionToMenu = SKTransition.fadeWithColor(SKColor.greenColor(), duration: 1)
                let scene = GameScene(size: self.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.scene?.view?.presentScene(scene, transition: transitionToMenu)
                
                
            }
            
            
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}



