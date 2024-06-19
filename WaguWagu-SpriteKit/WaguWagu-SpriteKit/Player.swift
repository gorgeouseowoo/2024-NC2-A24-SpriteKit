//
//  Player.swift
//  WaguWagu-SpriteKit
//
//  Created by KIM SEOWOO on 6/18/24.
//

import SpriteKit

//class Player: SKSpriteNode {
//    var screenSize: CGSize!
//
//    init(screenSize: CGSize) {
//        self.screenSize = screenSize
//        let playerTexture = Atlas.gameobject.textureNamed("waguPlayer")
//        super.init(texture: playerTexture, color: SKColor.clear, size: playerTexture.size())
//        self.zPosition = Layer.player
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class Player: SKSpriteNode {
    var screenSize: CGSize!
    var currentPlayerIndex: Int = 1
    
    
    init(screenSize: CGSize) {
        self.screenSize = screenSize
        let playerTexture = SKTexture(imageNamed: "waguPlayer\(currentPlayerIndex)")
        
        //
        let textureSize = playerTexture.size()
        let nodeSize = CGSize(width: textureSize.width * 0.2, height: textureSize.height * 0.2)
        
        super.init(texture: playerTexture, color: SKColor.clear, size: nodeSize)
        self.zPosition = Layer.player
        
        //MARK: - 물리바디 구현
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width / 3, height: self.size.height / 3), center: CGPoint(x: 0, y: 0)) // physicsBody의 사이즈는 rectangle, player 크기보다 physicsBody를 1/3 작게 구현하여 게임의 난이도를 낮춤, player의 중심
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.itemHealthy | PhysicsCategory.itemYum //충돌확인
        self.physicsBody?.collisionBitMask = 0 //물리충돌계산
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //⚠️MARK: - 이미지 변경 함수⚠️
    func gettingFat() {
        currentPlayerIndex += 1
        if currentPlayerIndex > 4 {
            //게임 종료 장치를 해야돼
            currentPlayerIndex = 1
        }
        let playerTexture = SKTexture(imageNamed: "waguPlayer\(currentPlayerIndex)")
        let action = SKAction.setTexture(playerTexture)
        
        // player인 node 사이즈 변화
        let nodeSize = playerTexture.size()
        self.size = CGSize(width: nodeSize.width * 0.2, height: nodeSize.height * 0.2)
        
        //MARK: - 물리바디 구현
        // playe의 physicsBody 사이즈 변화
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height), center: CGPoint(x: 0, y: 0))
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.itemHealthy | PhysicsCategory.itemYum
        self.physicsBody?.collisionBitMask = 0
        
        self.run(action)
    }
}



