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
    
    init(screenSize: CGSize) {
        self.screenSize = screenSize
        let playerTexture = SKTexture(imageNamed: "waguPlayer")
        super.init(texture: playerTexture, color: SKColor.clear, size: playerTexture.size())
        self.zPosition = Layer.player
        
        //MARK: - 물리바디 구현
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width / 3, height: self.size.height / 3), center: CGPoint(x: 0, y: 0)) // physicsBody의 사이즈는 rectangle, player 크기보다 physicsBody를 1/3 작게 구현하여 게임의 난이도를 낮춤, player의 중심
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.healthyItem //충돌확인
//        self.physicsBody?.contactTestBitMask = PhysicsCategory.healthyItem | PhysicsCategory.yumItem
        self.physicsBody?.collisionBitMask = 0 //물리충돌계산
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
