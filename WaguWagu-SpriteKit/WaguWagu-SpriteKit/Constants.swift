//
//  Constants.swift
//  WaguWagu-SpriteKit
//
//  Created by KIM SEOWOO on 6/18/24.
//

import SpriteKit

struct Particle {
    static let hit = "hit"
}

struct Image {
    static let background = "backGround"
}

struct Layer {
    static let background: CGFloat = 0
    static let itemHealthy: CGFloat = 1
    static let itemHealthy2: CGFloat = 3
    static let itemYum: CGFloat = 2
    static let player: CGFloat = 10

    static let hud: CGFloat = 30
}


struct Atlas {
    static let gameobject = SKTextureAtlas(named: "GameObjects")
}

struct PhysicsCategory {
    static let player: UInt32 = 0x1 << 0
    static let itemHealthy: UInt32 = 0x1 << 2
    static let itemYum: UInt32 = 0x1 << 3
    static let itemHealthy2: UInt32 = 0x1 << 4
}

