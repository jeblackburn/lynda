//
//  GameScene.swift
//  BrickBreaker
//
//  Created by Jon on 1/5/15.
//  Copyright (c) 2015 Jonathan Blackburn. All rights reserved.
//

import SpriteKit

let BallCategoryName = "ball"
let PaddleCategoryName = "paddle"
let BlockCategoryName = "block"
let BlockNodeCategoryName = "blockNode"
let BallCategory   : UInt32 = 0x1 << 0 // 00000000000000000000000000000001
let BottomCategory : UInt32 = 0x1 << 1 // 00000000000000000000000000000010
let BlockCategory  : UInt32 = 0x1 << 2 // 00000000000000000000000000000100
let PaddleCategory : UInt32 = 0x1 << 3 // 00000000000000000000000000001000
let BorderCategory : UInt32 = 0x1 << 4 // 00000000000000000000000000010000


var isFingerOnPaddle = false

class GameScene: SKScene, SKPhysicsContactDelegate {

    var paddleNode: SKSpriteNode? = nil
    var ballNode: SKSpriteNode? = nil
    var brickCount = 5
    var gameOverScene = GameOverScene.unarchiveFromFile("GameOverScene") as GameOverScene!


    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)

        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        borderBody.categoryBitMask = BorderCategory
        
        self.physicsBody = borderBody
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        let bottom = SKNode()
        // Will the origin always be 0,0? Don't know.
        let bottomEdge = SKPhysicsBody(edgeFromPoint: CGPointMake(self.frame.minX, self.frame.minY + 1),
            toPoint: CGPointMake(self.frame.maxX, self.frame.minY + 1))
        bottom.physicsBody = bottomEdge
        bottom.physicsBody!.categoryBitMask = BottomCategory
        addChild(bottom)
        
        addBricks(view)
        setupBall(view)
        paddleNode!.physicsBody!.categoryBitMask = PaddleCategory

    }
    
    func setupBall(view: SKView) {
        let ball = self.childNodeWithName(BallCategoryName) as SKSpriteNode
        ball.physicsBody!.applyImpulse(CGVectorMake(10, 10))
        
        ballNode = ball
        
        paddleNode = (self.childNodeWithName(PaddleCategoryName) as SKSpriteNode)
        ball.physicsBody!.categoryBitMask = BallCategory
        ball.physicsBody!.contactTestBitMask = BottomCategory | BlockCategory | BorderCategory
    }
    
    func addBricks(view: SKView) {
        for i in 1 ... brickCount {
            var brick = SKSpriteNode(imageNamed: "block")
            brick.physicsBody = SKPhysicsBody(rectangleOfSize: brick.frame.size)
            brick.physicsBody!.dynamic = false
            brick.physicsBody?.categoryBitMask = BlockCategory
            let xpos = size.width/6 * CGFloat(i)
            let ypos = size.height - 50
            brick.position = CGPoint(x: xpos, y: ypos)
            addChild(brick)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        // 1. Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // 2. Assign the two physics bodies so that the one with the lower category is always stored in firstBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 3. react to the contact between ball and bottom
        if firstBody.categoryBitMask == BallCategory {
            switch secondBody.categoryBitMask {
            case BottomCategory:
                if let mainView = view {
                    gameOverScene.gameWon = false
                    mainView.presentScene(gameOverScene)
                }
            case BlockCategory:
                secondBody.node!.removeFromParent()
                brickCount -= 1
                if brickCount == 0 {
                    if let mainView = view {
                        gameOverScene.gameWon = true
                        mainView.presentScene(gameOverScene)
                    }
                }
            case BorderCategory:
                let currentVector = contact.contactNormal
                println("Bonk \(currentVector.dx), \(currentVector.dy)")
                let currentImpact = contact.collisionImpulse
                println("Power: \(currentImpact)")
                if currentImpact <= 5.0 && currentImpact > 0 {
                    println("Impulse power, Mr Sulu")
                    if currentVector.dx == 0 { // only the top
                        firstBody.applyImpulse(CGVector(dx: 0, dy: -1))
                    } else if currentVector.dy == 0 { // dx is -1 on the right wall, 1 on the left.
                        let dx = currentVector.dx
                        println("Applying impulse with dx = \(dx)")
                        firstBody.applyImpulse(CGVector(dx: dx, dy: 0))
                    }
                }
            default:
                return
            }
        }
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        var touchLocation = touch.locationInNode(self)
        
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            if body.node!.name == PaddleCategoryName {
                println("Began touch on paddle")
                isFingerOnPaddle = true
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // 1. Check whether user touched the paddle
        if isFingerOnPaddle {
            // 2. Get touch location
            var touch = touches.anyObject() as UITouch!
            var touchLocation = touch.locationInNode(self)
            var previousLocation = touch.previousLocationInNode(self)
            
//            // 3. Get node for paddle
//            var paddle = childNodeWithName(PaddleCategoryName) as SKSpriteNode!
            
            // 4. Calculate new position along x for paddle
            var paddleX = self.paddleNode!.position.x + (touchLocation.x - previousLocation.x)
            
            // 5. Limit x so that paddle won't leave screen to left or right
            paddleX = max(paddleX, paddleNode!.size.width/2)
            paddleX = min(paddleX, size.width - paddleNode!.size.width/2)
            
            // 6. Update paddle position
            paddleNode!.position = CGPointMake(paddleX, paddleNode!.position.y)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        isFingerOnPaddle = false
    }
    
    func addBlocks() {
        // 1. Store some useful constants
        let numberOfBlocks = 5
        
        let blockWidth = SKSpriteNode(imageNamed: "block.png").size.width
        let totalBlocksWidth = blockWidth * CGFloat(numberOfBlocks)
        
        let padding: CGFloat = 10.0
        let totalPadding = padding * CGFloat(numberOfBlocks - 1)
        
        // 2. Calculate the xOffset
        let xOffset = (CGRectGetWidth(frame) - totalBlocksWidth - totalPadding) / 2
        
        // 3. Create the blocks and add them to the scene
        for i in 0..<numberOfBlocks {
            let block = SKSpriteNode(imageNamed: "block.png")
            block.position = CGPointMake(xOffset + CGFloat(CGFloat(i) + 0.5)*blockWidth + CGFloat(i-1)*padding, CGRectGetHeight(frame) * 0.8)
            block.physicsBody = SKPhysicsBody(rectangleOfSize: block.frame.size)
            block.physicsBody!.allowsRotation = false
            block.physicsBody!.friction = 0.0
            block.physicsBody!.dynamic = false
            block.physicsBody!.affectedByGravity = false
            block.name = BlockCategoryName
            block.physicsBody!.categoryBitMask = BlockCategory
            addChild(block)
        }
    }
}
