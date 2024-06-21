# 2024-NC2-A24-SpriteKit

## **🎥 Youtube Link**

(추후 만들어진 유튜브 링크 추가)


## **💡 About SpriteKit**

> SpriteKit란? 2D 애니메이션을 만드는 프레임 워크로, “게임 개발을 쉽게 도와주는 도구”
애니메이션, 피직스 시뮬레이션, 파티클 시스템 등 다양한 기능을 제공하는데요, 이 기능을 활용하면 캐릭터 이동, 시각 효과와 같은 애니메이션을 제작할 수 있기 때문에 생동감 넘치는 2D 게임을 만들 수 있습니다.
> 




## **🎯 What we focus on?**

> 우리 팀은 “캐릭터가 움직이는 2D 게임”을 만들고 싶었기 때문에  움직임을 구현할 수 있는 “애니메이션”과 “피직스 시뮬레이션”을 사용하기로 했습니다.
> 
> - 애니메이션
>     - 특정 동작이나 변화를 시간에 따라 시각적으로 표현하는 데 사용됩니다. 캐릭터가 특정 경로를 따라 이동하거나 오브젝트가 회전하는 동작 등 시각 효과를 연출할 수 있습니다.
>     - “피직스 시뮬레이션”은 중력, 가속도, 충돌과 같은 물리법칙을 기반으로 자연스러운 움직임을 만들어 냅니다.
> - 피직스 시뮬레이션
>     - 중력에 의해 떨어지거나, 캐릭터가 벽에 부딪혀 튕겨나오는 동작, 물체가 폭발하는 효과 등 상호작용을 만들어 게임의 현실감을 더합니다.





## **💼 Use Case**

> 다이어트에 스트레스 받는 사람을 위해
현실과는 반대로 저칼로리 아이템을 먹으면 캐릭터가 살이 찌는 낙하게임을 만들자!
> 





## **🖼️ Prototype**
![프로토타입 001](https://github.com/gorgeouseowoo/2024-NC2-A24-SpriteKit/assets/80272734/e56b5838-7a1a-4433-a200-6916abe34916)
![프로토타입2 001](https://github.com/gorgeouseowoo/2024-NC2-A24-SpriteKit/assets/80272734/57ddcf77-6f6b-434a-9361-89edf951d573)





## **🛠️ About Code**

### Animation 효과 구현하기
![코드리뷰 001](https://github.com/gorgeouseowoo/2024-NC2-A24-SpriteKit/assets/80272734/c09130d6-22e1-45ef-9696-7ad84bf0f69f)

SKAction()으로 액션 발생시키기
``` swift
func addItem() {
        let randomItem = arc4random_uniform(UInt32(3)) + 1 // 3가지 아이템 중 랜덤 선택
        let randomXPos = CGFloat(arc4random_uniform(UInt32(self.size.width))) // 위치 랜덤
        let itemHealthy = SKSpriteNode(imageNamed: "itemHealthy\(randomItem)") // 이미지 로딩
        
        itemHealthy.name = "itemHealthy"
        itemHealthy.position = CGPoint(x: randomXPos, y: self.size.height + item.size.height) 
        itemHealthy.zPosition = Layer.item
    
	       self.addChild(itemHealthy)

        let moveAct = SKAction.moveTo(y: -itemHealthy.size.height, duration: 2) //화면 바깥으로 보낸다
        let removeAct = SKAction.removeFromParent() //사용되지 않는 객체를 화면에서 삭제
        itemHealthy.run(SKAction.sequence([moveAct, removeAct])) // Action 순서대로 실행
    }
```

### Physic Simultaion 구현하기
![코드리뷰3 001](https://github.com/gorgeouseowoo/2024-NC2-A24-SpriteKit/assets/80272734/069fff69-1c14-4ee8-8737-009bd1e59388)

객체(item) 물리바디 설정하기
``` swift
func additem() {
        
        itemHealthy.physicsBody = SKPhysicsBody(rectangleOf: itemHealthy.size) 
        itemHealthy.physicsBody?.categoryBitMask = PhysicsCategory.itemHealthy 
        itemHealthy.physicsBody?.contactTestBitMask = 0
        itemHealthy.physicsBody?.collisionBitMask = 0
        
    }
```


충돌 확인 후 액션 발생시키기
``` swift
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
  // 액션 = 이미지 변경 
		  if firstBody.categoryBitMask == PhysicsCategory.player && secondBody.categoryBitMask == PhysicsCategory.itemHealthy {
	      guard let playerNode = firstBody.node as? Player else { return } 
	      changePlayer2(player: playerNode)
	      secondBody.node?.removeFromParent()
			}
}

```


