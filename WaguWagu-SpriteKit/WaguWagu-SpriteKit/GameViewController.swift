//
//  GameViewController.swift
//  WaguWagu-SpriteKit
//
//  Created by KIM SEOWOO on 6/18/24.
//

import UIKit
import SpriteKit
import SwiftUI

class GameViewController: UIViewController {
    
    //MARK: - StartView 불러오기
    let startHostingViewController = UIHostingController(rootView: StartView())
    
    @objc func tapStartButton() {
        startHostingViewController.view.removeFromSuperview()
        
        if let view = self.view as? SKView {
                   view.isPaused = false
               }
    }
    
    //MARK: - ReplayView 불러오기
    //    let endHostingViewController = UIHostingController(rootView: ReplayView())
//    let endHostingViewController = UIHostingController(rootView: ReplayView())
//    
//    
//    @objc func viewReplayScreen() {
//        print("die")
//        endHostingViewController.view.addSubview(endHostingViewController.view)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - swiftUI to UIKit
        startHostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        startHostingViewController.view.frame = view.bounds
        startHostingViewController.view.backgroundColor = .clear
        startHostingViewController.rootView.tapStart = tapStartButton
        
        //        view.addSubview(startHostingViewController.view)
        
//        endHostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        endHostingViewController.view.frame = view.bounds
//        endHostingViewController.view.backgroundColor = .clear
//        
//        
        //view.addSubview(endHostingViewController.view)
        view.addSubview(startHostingViewController.view)
        
        // 게임 끝났을 때 - 조건문
        // 게임 종료 시점
        
        //        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 화면 가로 회전
        //        NSLayoutConstraint.activate([
        //            hostingController1.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        //            hostingController1.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        //            hostingController1.view.topAnchor.constraint(equalTo: view.topAnchor)
        //            hostingController1.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        //        ])
        
        if let view = self.view as! SKView? {
          
            //MARK: - GameScene 불러오기
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFit
            view.presentScene(scene)
            view.ignoresSiblingOrder = true  // 컴퓨터에게 개체를 그리는 순서를 맡긴다
            view.showsFPS = true // 프레임 표시
            view.showsNodeCount = true // node의 개수 표시
            view.showsPhysics = false // 물리바디 표시
            
            view.isPaused = true
           
            // 버튼을 누르면 게임 시작
            // 버튼을 누르기 전에는 게임 멈춤
            
            
            
//            if scene.gameOverr {
//                endHostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
//                endHostingViewController.view.frame = view.bounds
//                endHostingViewController.view.backgroundColor = .clear
//                
//                
//                self.view.addSubview(endHostingViewController.view)
//            }
        }
    }
    
    
    
    // 화면을 회전했을 때 따라오느냐
    override var shouldAutorotate: Bool {
        return true
    }
    
    // landscape mode
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
        //        if UIDevice.current.userInterfaceIdiom == .phone {
        //            return .allButUpsideDown
        //        } else {
        //            return .all
        //        }
    }
    
    // status bar를 표시할 것이냐
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
