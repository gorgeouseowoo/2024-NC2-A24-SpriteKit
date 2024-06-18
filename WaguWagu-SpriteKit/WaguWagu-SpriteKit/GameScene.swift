//
//  GameScene.swift
//  WaguWagu-SpriteKit
//
//  Created by KIM SEOWOO on 6/18/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: - 타이머 컨테이너
    var itemHealthyTimer = Timer()
    var itemHealthyInterval: TimeInterval = 1.5
    
    //MARK: - Player
//    let player = SKSpriteNode(imageNamed: "waguPlayer")
    var player: Player!
    
    override func didMove(to view: SKView) {
        
        //MARK: - 중력
        self.physicsWorld.contactDelegate = self //개체 간 일어나는 충돌을 gameScene이 관리 - SKPhysicsContactDelegate 상속

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0) // 중력의 영향을 받지 않음
        
        //MARK: - 배경 image 추가
        let background = SKSpriteNode(imageNamed: Image.background)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = Layer.background
        background.xScale = 0.3
        background.yScale = 0.3
        self.addChild(background)

        itemHealthyTimer = setTimer(interval: itemHealthyInterval, function: self.additemHealthy)
        
        //MARK: - player 배치
        player = Player(screenSize: self.size)
        player.position = CGPoint(x: size.width / 2, y: player.size.height / 2)
        player.xScale = 0.2
        player.yScale = 0.2
        self.addChild(player)

      
    }
    
    //MARK: - itemHealthy 추가 함수
    func additemHealthy() {
//        let randomItemHealthy = UInt32.random(in: 0...2)
        let randomItemHealthy = arc4random_uniform(UInt32(3)) + 1 // 3가지 중 랜덤 선택
        let randomXPos = CGFloat(arc4random_uniform(UInt32(self.size.width))) // 위치 랜덤
        let randomSpeed = TimeInterval(arc4random_uniform(UInt32(6)) + 6) // Speed 랜덤
        
//        let texture = Atlas.gameobject.textureNamed("itemHealthy\(randomItemHealthy)")
        
//        let itemHealthy = SKSpriteNode(texture: texture)
        let itemHealthy = SKSpriteNode(imageNamed: "itemHealthy\(randomItemHealthy)")
        
//        itemHealthy.name = "GameObjects/itemHealthy\(randomItemHealthy)"
        itemHealthy.name = "itemHealthy"
        itemHealthy.xScale = 0.2
         itemHealthy.yScale = 0.2
        itemHealthy.position = CGPoint(x: randomXPos, y: self.size.height + itemHealthy.size.height) // 화면에서 보이지 않는 바로 위
        itemHealthy.zPosition = Layer.itemHealthy
        
        //MARK: - 물리바디 부여
        itemHealthy.physicsBody = SKPhysicsBody(rectangleOf: itemHealthy.size)
        itemHealthy.physicsBody?.categoryBitMask = PhysicsCategory.healthyItem
        itemHealthy.physicsBody?.contactTestBitMask = 0
        itemHealthy.physicsBody?.collisionBitMask = 0
        
        self.addChild(itemHealthy)
        
        let moveAct = SKAction.moveTo(y: -itemHealthy.size.height, duration: randomSpeed) //화면 바깥으로 보낸다
        let removeAct = SKAction.removeFromParent() //사용되지 않은 객체를 화면에서 삭제
        
        itemHealthy.run(SKAction.sequence([moveAct, removeAct]))
    }
    
    //MARK: - 타이머 함수
    func setTimer(interval: TimeInterval, function:@escaping () -> Void) -> Timer {
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            function()
        }
        timer.tolerance = interval * 0.2 // 0.2초 정도 느려도 됨
        
        return timer
    }
    
    //MARK: - player 터치하면 움직임
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var location: CGPoint!
        if let touch = touches.first {
            location = touch.location(in: self)
        }
        self.player.run(SKAction.moveTo(x: location.x, duration: 0.2))
    }
    
    //MARK: - 두 Body의 충돌 확인 함수
    // firstBody - player, secondBody - healthyItem
    func didBegin(_ contact: SKPhysicsContact) {
        // 충돌한 두 바디 정렬
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.player && secondBody.categoryBitMask == PhysicsCategory.healthyItem {
            print("player and healthyItem")
        }
        
        //yumItem 여기에 적기
    }
    
    

}
