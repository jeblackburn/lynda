//
//  GameScene.swift
//  ActionsDemo
//
//  Created by Jon on 1/13/15.
//  Copyright (c) 2015 Jonathan Blackburn. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        
        println("View width: \(view.frame.width) and height: \(view.frame.height)")
        println("Scene width: \(self.frame.width) and height: \(self.frame.height)")
        /* Setup your scene here */
        self.backgroundColor = SKColor(red: 0.29, green: 0.75, blue: 0.99, alpha: 1)
        scaleMode = SKSceneScaleMode.ResizeFill
        
        var platform = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: 100.0, height: 20.0))
        platform.position = CGPoint(x: 50, y: 100)
        addChild(platform)
        
        var move = SKAction.moveByX(size.width - platform.size.width, y: 0, duration: 2)
        var moveback = move.reversedAction()
        var wait = SKAction.waitForDuration(1.5)
        var backAndForth = SKAction.sequence([move, wait, moveback, wait])
        var repeat = SKAction.repeatActionForever(backAndForth)
        platform.runAction(repeat)
        
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
