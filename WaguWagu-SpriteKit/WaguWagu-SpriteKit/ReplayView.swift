//
//  ReplayView.swift
//  WaguWagu-SpriteKit
//
//  Created by KIM SEOWOO on 6/19/24.
//

import SwiftUI

struct ReplayView: View {

    var body: some View {
        ZStack{
            Color(.black)
                .opacity(0.3)
            Image("replayBox")
                .resizable()
                .frame(width:266,height: 250)
            VStack{
                Text("FINISH")
                    .font(.system(size: 34))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(Color(red:51/255, green: 51/255,blue: 51/255))
                    .padding(.bottom,80)
                    .padding(.top,20)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack{
                        Image("replayButton")
                            .resizable()
                            .frame(width: 160,height: 56)
                        Text("REPLAY")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                })
                .padding(.bottom,20)
                
                
            }
            .frame(width:266,height: 250)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ReplayView()
}
