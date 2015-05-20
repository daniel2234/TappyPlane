//
//  PlayScene.swift
//  GameProject
//
//  Created by Daniel Kwiatkowski on 2015-05-19.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import SpriteKit

class PlayScene: SKScene {
    
    let runningGround = SKSpriteNode(imageNamed: "groundGrass")
    var plane = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
        println("We are at the scene")
        self.backgroundColor = UIColor.blueColor()
        self.runningGround.anchorPoint = CGPointMake(0, 0.5)
        self.runningGround.position = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame) + (self.runningGround.size.height))
        self.addChild(self.runningGround)
        
        
        var planeTexture = SKTexture(imageNamed: "planeYellow1");
        var planeSecondTexture = SKTexture(imageNamed: "planeYellow2");
        var planeThirdTexture = SKTexture(imageNamed: "planeYellow3");
        
        
        plane = SKSpriteNode(texture: planeTexture)
        plane.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        
        var animation = SKAction.animateWithTextures([planeTexture,planeSecondTexture,planeThirdTexture], timePerFrame: 0.1)
        var makePlaneTap = SKAction.repeatActionForever(animation)
        plane.runAction(makePlaneTap)
                
        self.addChild(plane)
    }
    
    
//    override func update(currentTime: NSTimeInterval) {
//        <#code#>
//    }
}