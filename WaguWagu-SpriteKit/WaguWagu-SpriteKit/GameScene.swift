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
    
    override func didMove(to view: SKView) {
        
        
        //MARK: - 배경 image 추가
        let background = SKSpriteNode(imageNamed: Image.background)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = Layer.background
        background.xScale = 0.3
        background.yScale = 0.3
        self.addChild(background)

        itemHealthyTimer = setTimer(interval: itemHealthyInterval, function: self.additemHealthy)
    }
    
    //MARK: - itemHealthy 추가 함수
    func additemHealthy() {
//        let randomItemHealthy = UInt32.random(in: 0...2)
        let randomItemHealthy = arc4random_uniform(UInt32(3)) + 1 // 3가지 중 랜덤 선택
        let randomXPos = CGFloat(arc4random_uniform(UInt32(self.size.width))) // 위치 랜덤
        let randomSpeed = TimeInterval(arc4random_uniform(UInt32(5)) + 5) // Speed 랜덤
        
//        let texture = Atlas.gameobject.textureNamed("itemHealthy\(randomItemHealthy)")
        
//        let itemHealthy = SKSpriteNode(texture: texture)
        let itemHealthy = SKSpriteNode(imageNamed: "itemHealthy\(randomItemHealthy)")
        
//        itemHealthy.name = "GameObjects/itemHealthy\(randomItemHealthy)"
        itemHealthy.name = "itemHealthy"
        itemHealthy.xScale = 0.25
        itemHealthy.yScale = 0.25
        itemHealthy.position = CGPoint(x: randomXPos, y: self.size.height + itemHealthy.size.height) // 화면에서 보이지 않는 바로 위
        itemHealthy.zPosition = Layer.itemHealthy
        
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
}
