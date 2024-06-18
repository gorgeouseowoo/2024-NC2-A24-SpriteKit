//
//  Constants.swift
//  WaguWagu-SpriteKit
//
//  Created by KIM SEOWOO on 6/18/24.
//

import SpriteKit


struct Image {
    static let background = "backGround"
}

struct Layer {
    static let background: CGFloat = 0
    static let itemHealthy: CGFloat = 1
    static let player: CGFloat = 10
}


struct Atlas {
    static let gameobject = SKTextureAtlas(named: "GameObjects")
}

struct PhysicsCategory {
    static let player: UInt32 = 0x1 << 0
    static let healthyItem: UInt32 = 0x1 << 2
}

