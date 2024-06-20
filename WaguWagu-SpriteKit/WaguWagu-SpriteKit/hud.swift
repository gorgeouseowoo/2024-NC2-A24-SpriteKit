//
//  hud.swift
//  WaguWagu-SpriteKit
//
//  Created by KIM SEOWOO on 6/18/24.
//

import SpriteKit

class Hud: SKNode {
    // 화면 크기를 받아올 컨테이너
    var screenSize: CGSize!
    
    var scoreLabel = SKLabelNode()
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var livesArray: [SKSpriteNode] = []
    
    func createHud(screenSize: CGSize) {
        self.screenSize = screenSize
        
        addScoreLabel()
//        addLive()
    }
    
    func addScoreLabel() {
        scoreLabel.text = "SCORE: 0"
        scoreLabel.fontName = "SF Pro"
        scoreLabel.fontColor = .black
        scoreLabel.fontSize = 20
        scoreLabel.position.x = 260
        scoreLabel.position.y = screenSize.height - 100
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.zPosition = Layer.hud
        self.addChild(scoreLabel)
    }
    
    //MARK: - 목숨
    func addLive() {
        for live in 1...3 {
            let liveNode = SKSpriteNode(imageNamed: "level")
            liveNode.position.x = screenSize.width - 10 - CGFloat(5 - live) * liveNode.size.width // 1일 때 가장 왼쪽에 있는 하트 생성
            
            liveNode.position.y = screenSize.height - 100
            liveNode.zPosition = Layer.hud
            liveNode.xScale = 0.2
            liveNode.yScale = 0.2
            self.addChild(liveNode)
            livesArray.append(liveNode)
            
        }
    }
    
    func subtractLive() {
        guard let liveNode = self.livesArray.first else { return }
        liveNode.removeFromParent()
        self.livesArray.removeFirst() // 가장 첫번째 요소 삭제
    }
}
