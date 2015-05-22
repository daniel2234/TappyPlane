//
//  GameScene.swift
//  GameProject
//
//  Created by Daniel Kwiatkowski on 2015-05-19.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import SpriteKit

class GameScene: SKScene{
    

    var playButton = SKSpriteNode(imageNamed: "play")
    
    override func didMoveToView(view: SKView) {
        self.playButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(self.playButton)
        self.backgroundColor = UIColor.blueColor()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch : AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.playButton{
                var scene = PlayScene(size:self.size)
                let skView = self.view as SKView?
                skView?.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView!.bounds.size
                skView?.presentScene(scene)
                
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
