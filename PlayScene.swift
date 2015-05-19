//
//  PlayScene.swift
//  GameProject
//
//  Created by Daniel Kwiatkowski on 2015-05-19.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import SpriteKit

class PlayScene: SKScene {
    var playButton = SKSpriteNode(imageNamed: "play")
    
    override func didMoveToView(view: SKView) {
        println("We are going to play the game")
        
        self.playButton.position = CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))
        self.addChild(self.playButton)
        self.backgroundColor = UIColor.blueColor()
    }
}