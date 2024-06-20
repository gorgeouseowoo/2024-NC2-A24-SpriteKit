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

struct ImageAsset {
    static let background = "backGround"
}

struct Layer {
    static let background1: CGFloat = 0
    static let background2: CGFloat = 0.1
    static let upper: CGFloat = 0.2
    static let itemHealthy: CGFloat = 1
    static let itemYum: CGFloat = 2
    static let player: CGFloat = 10
    static let gameover: CGFloat = 20
    
    
    static let boxLayer: CGFloat = 30
    static let buttonLayer: CGFloat = 31
    static let tex: CGFloat = 32

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

