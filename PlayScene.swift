//
//  PlayScene.swift
//  GameProject
//
//  Created by Daniel Kwiatkowski on 2015-05-19.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import SpriteKit

class PlayScene: SKScene {
    
//    let runningGround = SKSpriteNode(imageNamed: "groundGrass")
    
    //defining the moving ground
    var runningGround = SKSpriteNode()
    //defining the plane node
    var plane = SKSpriteNode()
    //define the animation node project
    var animation = SKSpriteNode()
    //define the background image project
    var backGround = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
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
        plane.zPosition = 10
        self.addChild(plane)
        
        //define the ground object
        var ground = SKNode()
        
        //set the ground position
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width,1))
        ground.physicsBody?.dynamic = false
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
}
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("Tappy is flying")
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
}