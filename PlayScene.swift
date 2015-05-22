//
//  PlayScene.swift
//  GameProject
//
//  Created by Daniel Kwiatkowski on 2015-05-19.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import SpriteKit

class PlayScene: SKScene,SKPhysicsContactDelegate{
    
    
    //defining the moving ground
    var runningGround = SKSpriteNode()
    //defining the plane node
    var plane = SKSpriteNode()
    //define the animation node project
    var animation = SKSpriteNode()
    //define the background image project
    var backGround = SKSpriteNode()
    //define score start at 0
    var score = 0
    //define the score node
    var scoreLabel = SKLabelNode()
    
    let deadPlaneGroup:UInt32 = 0x1 << 0
    let planeGroup:UInt32 = 0x1 << 1
    let rockGroup:UInt32 = 0x1 << 2
    let gapGroup:UInt32 = 0x1 << 3


    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        //declared hills
        println("We are at the scene")
        var grTexture = SKTexture(imageNamed:"groundGrass")
        runningGround.anchorPoint = CGPointMake(0, 0.5)
        runningGround = SKSpriteNode(texture: grTexture)
        runningGround.position = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame) + (self.runningGround.size.height/2))

        var moveSecondGround = SKAction.moveByX(-grTexture.size().width, y: 0, duration: 8)
        var replaceSecondBackground = SKAction.moveByX(grTexture.size().width, y: 0, duration: 0)
        var moveSecondForever = SKAction.repeatActionForever(SKAction.sequence([moveSecondGround,replaceSecondBackground]))
        var wave = SKSpriteNode(texture: grTexture)
        wave.position = CGPoint(x: grTexture.size().width / 2 + grTexture.size().width , y: CGRectGetMidY(self.frame))
        wave.runAction(moveSecondForever)

        
        for var i:CGFloat = 0; i<3; i++ {
            var wave = SKSpriteNode(texture: grTexture)
            wave.position = CGPoint(x: grTexture.size().width / 2 + grTexture.size().width * i, y: CGRectGetMinY(self.frame) + (self.runningGround.size.height/2))
            wave.runAction(moveSecondForever)
            wave.zPosition = 9
            self.addChild(wave)
        }

        //declared plane position and animation
        var planeTexture = SKTexture(imageNamed: "planeYellow1");
        var planeSecondTexture = SKTexture(imageNamed: "planeYellow2");
        var planeThirdTexture = SKTexture(imageNamed: "planeYellow3");
        plane = SKSpriteNode(texture: planeTexture)
        plane.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        
        var animation = SKAction.animateWithTextures([planeTexture,planeSecondTexture,planeThirdTexture], timePerFrame: 0.1)
        var makePlaneTap = SKAction.repeatActionForever(animation)
        plane.runAction(makePlaneTap)
        
        //add physics to tappy plane
        plane.physicsBody = SKPhysicsBody(circleOfRadius: plane.size.height/2)
        plane.physicsBody?.dynamic = true
        plane.physicsBody?.allowsRotation = false
        plane.physicsBody?.categoryBitMask = planeGroup
        plane.physicsBody?.collisionBitMask = rockGroup
        plane.physicsBody?.contactTestBitMask = rockGroup
        plane.physicsBody?.allowsRotation = false
        plane.zPosition = 10
        self.addChild(plane)
        
        
        //define the ground object
        var ground = SKNode()
        
        //set the ground position
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width,1))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = rockGroup
        self.addChild(ground)

        //declare the background
        var bgTexture = SKTexture(imageNamed:"background")
        backGround = SKSpriteNode(texture: bgTexture)
        backGround.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        backGround.size.height = self.frame.height
        backGround.zPosition = 0;
        self.addChild(backGround)
        
        //move the background
        var moveBackground = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        var replaceBackground = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        var moveForever = SKAction.repeatActionForever(SKAction.sequence([moveBackground,replaceBackground]))
        
        for var i:CGFloat = 0; i<3; i++ {
            var wave = SKSpriteNode(texture: bgTexture)
            wave.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
            wave.size.height = self.frame.height
            wave.runAction(moveForever)
            self.addChild(wave)
        }
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70)
        scoreLabel.zPosition = 10
        self.addChild(scoreLabel)

        var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("makeRocks"), userInfo: nil, repeats: true)
        
        runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed("planepropeller.wav", waitForCompletion: true)))
}
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

            plane.physicsBody?.velocity = CGVectorMake(0, 0)
            plane.physicsBody?.applyImpulse(CGVectorMake(0, 50))

        
        for touch in (touches as! Set<UITouch>){
            let location = touch.locationInNode(self)
            
            if location == plane.position {
                println("Tappy is touched")
            }
        }
        
    }
    
//    override func update(currentTime: NSTimeInterval) {
//        <#code#>
//    }
    
    
    func makeRocks(){

        //create gapheight
        let gapHeight = plane.size.height * 4
        var movementAmount = arc4random() % UInt32(self.frame.size.height/2)
        var rockOffset = CGFloat(movementAmount) - self.frame.size.height/5
        var moveRocks = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))
        var removeRocks = SKAction.removeFromParent()
        var moveAndRemove = SKAction.repeatActionForever(SKAction.sequence([moveRocks, removeRocks]))
        
        //create the rocks for the game
        var firstTexture = SKTexture(imageNamed: "rockGrassDown")
        var topRock = SKSpriteNode(texture: firstTexture)
        topRock.runAction(moveAndRemove)
        topRock.physicsBody = SKPhysicsBody(rectangleOfSize: topRock.size)
        topRock.physicsBody?.dynamic = false
        topRock.physicsBody?.categoryBitMask = rockGroup
        topRock.physicsBody?.collisionBitMask = planeGroup
        topRock.physicsBody?.contactTestBitMask = planeGroup
        topRock.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + topRock.size.height/2 + gapHeight/2 + rockOffset)
        
        //second bottom rock
        var secondTexture = SKTexture(imageNamed: "rockGrass")
        var bottomRock = SKSpriteNode(texture: secondTexture)
        bottomRock.runAction(moveAndRemove)
        bottomRock.physicsBody=SKPhysicsBody(rectangleOfSize: bottomRock.size)
        bottomRock.physicsBody?.dynamic = false
        bottomRock.physicsBody?.categoryBitMask = rockGroup
        bottomRock.physicsBody?.collisionBitMask = planeGroup
        bottomRock.physicsBody?.contactTestBitMask = planeGroup
        bottomRock.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) - topRock.size.height/2 - gapHeight/2 + rockOffset)
        
        self.addChild(topRock)
        self.addChild(bottomRock)
        
        var gap = SKNode()
        gap.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + rockOffset)
        gap.physicsBody = SKPhysicsBody(rectangleOfSize:CGSizeMake(bottomRock.size.width, gapHeight))
        gap.runAction(moveAndRemove)
        gap.physicsBody?.dynamic = false
        gap.physicsBody?.categoryBitMask = gapGroup
        gap.physicsBody?.collisionBitMask = gapGroup
        gap.physicsBody?.contactTestBitMask = planeGroup
        self.addChild(gap)
        
    }

    
    func gameOver(){
        var gameover = 0
        
        plane.physicsBody?.categoryBitMask = deadPlaneGroup
//        plane.physicsBody?.contactTestBitMask =
//        plane.physicsBody?.collisionBitMask =
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: Selector("restartGame"), userInfo: nil, repeats: false)
        
//        runningGround.speed = 0
//        plane.speed = 0
//        animation.speed = 0
//        backGround.speed = 0
    }
    
    
    func restartGame(){
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene)
    }
    
    //collision detection
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyB.categoryBitMask == gapGroup || contact.bodyA.categoryBitMask == gapGroup {
            score++
            scoreLabel.text = "\(score)"
            
        } else if contact.bodyB.categoryBitMask == rockGroup || contact.bodyA.categoryBitMask == rockGroup{
            self.gameOver()
        }else {
            println("game over")
            
        }
    }
    
    
}