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
    var itemHealthyInterval: TimeInterval = 1
    var itemYumTimer = Timer()
    var itemYumInterval: TimeInterval = 1.2
    
    var gameViewController: GameViewController?
    
    
    let hud = Hud()
    
    //MARK: - Player
    //        let player = SKSpriteNode(imageNamed: "waguPlayer")
    var player: Player!
    
    //MARK: - 게임continue?
    var continueScreen = SKSpriteNode()
    
    
    //MARK: - 게임스타트
    func gameStart() {
        itemHealthyTimer.invalidate()
        itemYumTimer.invalidate()
    }
    
    //MARK: - 게임오버
    func gameOver() {
        
        itemHealthyTimer.invalidate()
        itemYumTimer.invalidate()
        //        gameOverr = true
        continueScreen = creatContinueScreen()
        //        continueScreen = createReplayScreen()
        
        self.addChild(continueScreen)
        self.isPaused = true
        
        saveHighScore()
        //        gameViewController?.viewReplayScreen()
    }
    //MARK: - 게임continue
    //    func createReplayScreen() -> SKSpriteNode {
    //        continueScreen = SKSpriteNode(color: .clear, size: size)
    //        continueScreen.position = CGPoint(x: size.width / 2, y: size.height / 2)
    //        continueScreen.zPosition = Layer.gameover
    //        continueScreen.alpha = 0.9 // 투명도
    //
    //        // 여기에 replayView가 연결되어 있어야돼
    //        return continueScreen
    //    }
    //
    
    //MARK: - 게임continue
    func creatContinueScreen() -> SKSpriteNode {
        // continueScreen 전역변수로 설정 - 이유는 함수 외부에서도 접근하기 위해
        continueScreen = SKSpriteNode(color: SKColor.darkGray, size: size)
        continueScreen.position = CGPoint(x: size.width / 2, y: size.height / 2)
        continueScreen.zPosition = Layer.gameover
        continueScreen.alpha = 0.9 // 투명도
        
        let finishLabel = SKLabelNode(text: "FINISH")
        finishLabel.fontName = "SFProText"
        finishLabel.fontSize = 34
        finishLabel.fontColor = .black
        finishLabel.position = CGPoint(x: 0, y: size.height * 0.13 )
        finishLabel.zPosition = Layer.tex
        continueScreen.addChild(finishLabel)
        //에러⚠️ A Node can't parent itself
        
        let scoreLabel = SKLabelNode(text: String(format:"SCORE: %d", self.hud.score))
        scoreLabel.fontName = "SFProText-Bold"
        scoreLabel.fontSize = 28
        scoreLabel.fontColor = .black
        scoreLabel.position = CGPoint(x: 0, y:  size.height * 0.05)
        scoreLabel.zPosition = Layer.tex
        continueScreen.addChild(scoreLabel)
        
//        let highScoreLabel = SKLabelNode(text: String(format:"BEST: %d", self.hud.score, UserDefaults.standard.integer(forKey: "highScore")))
        let highScoreLabel = SKLabelNode(text: String(format:"BEST: %d", UserDefaults.standard.integer(forKey: "highScore")))
        highScoreLabel.fontName = "SFProText-Bold"
        highScoreLabel.fontSize = 28
        highScoreLabel.fontColor = .black
        highScoreLabel.position = CGPoint(x: 0, y:  size.height * 0.01)
        highScoreLabel.zPosition = Layer.tex
        continueScreen.addChild(highScoreLabel)
        
        let continueLabel = SKLabelNode(text: "REPLAY")
        continueLabel.name = "replay"
        continueLabel.fontName = "SFProText"
        continueLabel.fontSize = 34
        continueLabel.position = CGPoint(x: 0, y: -size.height / 10)
        continueLabel.zPosition = Layer.tex
        continueScreen.addChild(continueLabel)
        
        let replayBox = SKSpriteNode(imageNamed: "replayBox")
        replayBox.name = "replayBox"
        replayBox.position = CGPoint(x: 0, y: size.height * 0.03)
        replayBox.zPosition = Layer.boxLayer
        
        replayBox.xScale = 0.3
        replayBox.yScale = 0.3
        continueScreen.addChild(replayBox)
        
        let replayButton = SKSpriteNode(imageNamed: "replayButton")
        replayButton.name = "replayButton"
        replayButton.position = CGPoint(x: 0, y: -size.height / 12 )
        replayButton.zPosition = Layer.buttonLayer
        replayButton.xScale = 0.3
        replayButton.yScale = 0.3
        continueScreen.addChild(replayButton)
        
        return continueScreen
    }
    
    //MARK: - HighScore 저장
    func saveHighScore() {
        print("1 \(UserDefaults.standard.integer(forKey: "highScore"))") // 이게 문제??
        let userDefaults = UserDefaults.standard
        let highScore = userDefaults.integer(forKey: "highScore")
        
        if self.hud.score > highScore {
            userDefaults.set(self.hud.score, forKey: "highScore")
        }
        
        print("2 \(UserDefaults.standard.integer(forKey: "highScore"))") // 작동 잘됨
//        userDefaults.synchronize()
    }
    
    
    
    override func didMove(to view: SKView) {
        
        //MARK: - 중력
        self.physicsWorld.contactDelegate = self //개체 간 일어나는 충돌을 gameScene이 관리 - SKPhysicsContactDelegate 상속
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0) // 중력의 영향을 받지 않음
        
        //MARK: - 배경 image 추가
        let background1 = SKSpriteNode(imageNamed: "backGround")
        background1.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background1.zPosition = Layer.background1
        background1.xScale = 0.3
        background1.yScale = 0.3
        self.addChild(background1)
        
        let background2 = SKSpriteNode(imageNamed: "ground")
        background2.position = CGPoint(x: size.width / 2, y: size.height / 60 )
        background2.zPosition = Layer.background2
        background2.xScale = 0.5
        background2.yScale = 0.5
        self.addChild(background2)
        
        
        //MARK: - hud
        hud.createHud(screenSize: self.size)
        self.addChild(hud)
        
        //MARK: - 타이머
        itemHealthyTimer = setTimer(interval: itemHealthyInterval, function: self.additemHealthy)
        itemYumTimer = setTimer(interval: itemYumInterval, function: self.additemYum)
        
        
        //MARK: - player 배치
        player = Player(screenSize: self.size)
        player.position = CGPoint(x: size.width / 2, y: player.size.height * 3)
        self.addChild(player)
    }
    
    //MARK: - itemHealthy 생성 함수
    func additemHealthy() {
        //        let randomItemHealthy = UInt32.random(in: 0...2)
        let randomItemHealthy = arc4random_uniform(UInt32(3)) + 1 // 3가지 중 랜덤 선택
        let randomXPos = CGFloat(arc4random_uniform(UInt32(self.size.width))) // 위치 랜덤
//    let randomSpeed = TimeInterval(arc4random_uniform(UInt32(3)) + 3) // Speed 랜덤
        
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
        itemHealthy.physicsBody?.categoryBitMask = PhysicsCategory.itemHealthy
        itemHealthy.physicsBody?.contactTestBitMask = 0
        itemHealthy.physicsBody?.collisionBitMask = 0
        
        self.addChild(itemHealthy)

        let moveAct = SKAction.moveTo(y: -itemHealthy.size.height, duration: 2) //화면 바깥으로 보낸다
        let removeAct = SKAction.removeFromParent() //사용되지 않은 객체를 화면에서 삭제
        itemHealthy.run(SKAction.sequence([moveAct, removeAct]))
    }
    
    
    
    
    
    
    //MARK: - itemYum 추가 함수
    
    func additemYum() {
        
        let randomItemYum = arc4random_uniform(UInt32(3)) + 1
        let randomXPos = CGFloat(arc4random_uniform(UInt32(self.size.width)))
        let randomSpeed = TimeInterval(arc4random_uniform(UInt32(2)) + 2)

        let itemYum = SKSpriteNode(imageNamed: "itemYum\(randomItemYum)")
        itemYum.name = "itemYum"
        itemYum.xScale = 0.2
        itemYum.yScale = 0.2
        itemYum.position = CGPoint(x: randomXPos, y: self.size.height + itemYum.size.height)
        itemYum.zPosition = Layer.itemYum
        
        //물리바디 부여
        itemYum.physicsBody = SKPhysicsBody(rectangleOf: itemYum.size)
        itemYum.physicsBody?.categoryBitMask = PhysicsCategory.itemYum
        itemYum.physicsBody?.contactTestBitMask = 0
        itemYum.physicsBody?.collisionBitMask = 0
        
        self.addChild(itemYum)
        
        let moveAct = SKAction.moveTo(y: -itemYum.size.height, duration: randomSpeed)
        let removeAct = SKAction.removeFromParent()
        
        itemYum.run(SKAction.sequence([moveAct, removeAct]))
    }
    
    
    
    
  
    
    
    
    
    //MARK: - 타이머 함수
    func setTimer(interval: TimeInterval, function:@escaping () -> Void) -> Timer {
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            function()
        }
        timer.tolerance = interval * 0.2 // 0.2초 정도 느려도 됨
        
        return timer
    }
    
    //MARK: - 데미지 이펙트 정리 :: 충돌
    func explosion(targetNode: SKSpriteNode, isSmall: Bool) {
        let particle: String!
        if isSmall {
            particle = Particle.hit
        } else {
            particle = Particle.hit
        }
        guard let explosion = SKEmitterNode(fileNamed: particle) else { return }
        explosion.position = targetNode.position // 맞았을 때 targetNode가 있던 자리에 position 생성
        explosion.zPosition = targetNode.zPosition
        self.addChild(explosion)
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
    }
    
    //⚠️MARK: - itemHealthy와 충돌 후 이미지 변경⚠️
    func changePlayer(player: SKSpriteNode) {
        
        let playerFat = SKSpriteNode(imageNamed: "waguPlayer2")
        playerFat.position = player.position
        playerFat.zPosition = player.zPosition
        
        playerFat.xScale = 0.2
        playerFat.yScale = 0.2
        
        self.addChild(playerFat)
    }
    
    //}
    
    //⚠️MARK: - itemHealthy와 충돌 후 이미지 변경 ver2⚠️
    func changePlayer2(player: Player) {
        player.gettingFat()
    }
    
    
    //MARK: - 데미지 이펙트 정리 :: 피탄
    //    func playerDamageEffect() {
    //        let flashNode = SKSpriteNode(color: SKColor.red, size: self.size)
    //        flashNode.position = CGPoint(x:self.size.width / 2, y: self.size.height / 2)
    //        flashNode.zPosition = Layer.hud
    //        self.addChild(flashNode)
    //        flashNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.01), SKAction.removeFromParent()])) // 0.01초 뒤에 flashNode 삭제
    //    }
    
    //MARK: - player 터치하면 움직임
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var location: CGPoint!
        if let touch = touches.first {
            location = touch.location(in: self)
        }
        self.player.run(SKAction.moveTo(x: location.x, duration: 0.05)) // 터치 스크롤
    }
    
    
    
    //MARK: - replay 버튼 터치
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if let nodeName = nodesArray.first?.name {
                switch nodeName {
                case "replayButton":
                    replay()
                case "replay":
                    replay()
                default:
                    break
                }
            }
        }
    }
    
    //MARK: - replay 함수
    func replay() {
        continueScreen.removeFromParent()
        self.isPaused = false
        
        let callGameScene = GameScene(size: self.size)
        callGameScene.scaleMode = .aspectFit
        
        itemHealthyTimer = setTimer(interval: itemHealthyInterval, function: self.additemHealthy)
        itemYumTimer = setTimer(interval: itemYumInterval, function: self.additemYum)
        print("3 \(UserDefaults.standard.integer(forKey: "highScore"))")
        //MARK: - score가 다시 0이 됨
        self.hud.score = 0
        
        print("4 \(UserDefaults.standard.integer(forKey: "highScore"))")
        
    }
    
    
    //MARK: - 두 Body의 충돌 확인 함수
    // firstBody - player, secondBody - healthyItem
    
    func didBegin(_ contact: SKPhysicsContact) {
        // #1 충돌하는 2개의 객체간 물리바디 정렬하기
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // #2 충돌 후 액션 발생시키기
        // 액션 = 스코어 1점 획득
        if firstBody.categoryBitMask == PhysicsCategory.player && secondBody.categoryBitMask == PhysicsCategory.itemYum { // 충돌 확인
            print("player and yumItem")
            
            self.hud.score += 1 //액션
            
            guard let targetNode = secondBody.node as? SKSpriteNode else { return } // secondBody가 targetNod에 전달
            targetNode.removeFromParent() // secondBody 삭제
        }
        
        //MARK: - 충돌효과
        //                if firstBody.categoryBitMask == PhysicsCategory.player && secondBody.categoryBitMask == PhysicsCategory.healthyItem {
        //                    print("player and healthyItem")
        //
        //                    guard let targetNode = secondBody.node as? SKSpriteNode else { return } // secondBody가 targetNod에 전달
        //                    explosion(targetNode: targetNode, isSmall: true)
        //                    targetNode.removeFromParent() // secondBody 삭제
        //
        //                    firstBody.node?.removeFromParent() // firstBody 삭제
        
        //MARK: - 하트빼기
        //            hud.subtractLive()
        
        //MARK: - 피탄효과
        //    playerDamageEffect()
        
        
        //⚠️MARK: - 이미지 변경⚠️
        // 문제: player가 사라짐 -> 해결 playerNode.removeFromParent() 삭제
        
        if firstBody.categoryBitMask == PhysicsCategory.player && secondBody.categoryBitMask == PhysicsCategory.itemHealthy {
            print("player and healthyItem")
            
            guard let playerNode = firstBody.node as? Player else { return } // fisrtBody가 targetNod에 전달
            changePlayer2(player: playerNode)
            secondBody.node?.removeFromParent()
        }
        
        //⚠️MARK: - 점수 획득⚠️
        
        
       
    }
}


