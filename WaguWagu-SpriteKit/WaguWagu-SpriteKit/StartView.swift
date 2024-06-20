//
//  StartView.swift
//  WaguWagu-SpriteKit
//
//  Created by KIM SEOWOO on 6/19/24.
//

import SwiftUI


struct StartView: View {
    var tapStart: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.3)
            VStack{
                VStack {
                    Text("GAME")
                        .multilineTextAlignment(.center)
                    Text("START")
                        .multilineTextAlignment(.center)
                }
                
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 40))
                .foregroundColor(.white)
                
                
                Button(action: {
                    if let tapStart {
                        print("start")
                        tapStart()
                    }
                }, label: {
                    ZStack {
                        Image("replayButton")
                            .resizable()
                            .frame(width:160,height: 52)
                        Text("START")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                    }
                })
                
                
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}



#Preview {
    StartView {}
}
