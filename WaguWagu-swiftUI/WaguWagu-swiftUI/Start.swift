//
//  Start.swift
//  WaguWagu-swiftUI
//
//  Created by KIM SEOWOO on 6/19/24.
//

import SwiftUI

struct Start: View {
    var body: some View {
        VStack{
            VStack {
                Text("GAME")
                    .multilineTextAlignment(.center)
                Text("START")
                    .multilineTextAlignment(.center)
            }
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .font(.system(size: 40))
            .foregroundStyle(.white)
            
            Button(action: {}, label: {
                ZStack {
                    Image("replayButton")
                        .resizable()
                        .frame(width:160,height: 52)
                    Text("START")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 28))
                        .foregroundStyle(.white)
                }
            })
            
            
        }
        .padding()
    }
}


#Preview {
    Start()
}
