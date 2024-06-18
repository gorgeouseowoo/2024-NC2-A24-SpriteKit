//
//  GameViewController.swift
//  WaguWagu-SpriteKit
//
//  Created by KIM SEOWOO on 6/18/24.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
        
        //MARK: - GameScene 불러오기
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .aspectFit
        view.presentScene(scene)
        view.ignoresSiblingOrder = true  // 컴퓨터에게 개체를 그리는 순서를 맡긴다
        view.showsFPS = true // 프레임 표시
        view.showsNodeCount = true // node의 개수 표시
        view.showsPhysics = false // 물리바디 표시
    }
}

    // 화면을 회전했을 때 따라오느냐
    override var shouldAutorotate: Bool {
        return true
    }

    // landscape mode
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    // status bar를 표시할 것이냐
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
