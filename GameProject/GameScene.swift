//
//  GameScene.swift
//  GameProject
//
//  Created by Daniel Kwiatkowski on 2015-05-19.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
//    var plane = SKSpriteNode()
    var playButton = SKSpriteNode(imageNamed: "play")
    
    override func didMoveToView(view: SKView) {
        self.playButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(self.playButton)
        self.backgroundColor = UIColor.blueColor()

//        var planeTexture = SKTexture(imageNamed: "planeYellow1");
//        var planeSecondTexture = SKTexture(imageNamed: "planeYellow2");
//        var planeThirdTexture = SKTexture(imageNamed: "planeYellow3");
//        
//        
//        plane = SKSpriteNode(texture: planeTexture)
//        plane.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
//        
//        
//        var animation = SKAction.animateWithTextures([planeTexture,planeSecondTexture,planeThirdTexture], timePerFrame: 0.1)
//        var makePlaneTap = SKAction.repeatActionForever(animation)
//        plane.runAction(makePlaneTap)
//        
//        self.addChild(plane)

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch : AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.playButton{
                print("Go to game")
                var scene = PlayScene(size:self.size)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
