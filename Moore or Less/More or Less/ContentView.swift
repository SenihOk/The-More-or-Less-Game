//
//  ContentView.swift
//  Code History
//
//  Created by Senih Okuyucu on 10/6/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var info = Info()
    @State private var startApp = false
    @State var scale: CGFloat = 0.0
    @State var tap: Bool = false
    var taptic_response = UIImpactFeedbackGenerator(style: .medium)
    func feedback_generator(){
        taptic_response.prepare()
        if tap == true{
            taptic_response.impactOccurred()
            tap = false
        }
    }
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Spacer()
                
                
                Text("More or Less")
                    .font(.largeTitle)
                    .padding(.bottom, 100)
                    .fixedSize()
                    .foregroundColor(Color("Color"))
                
                NavigationLink(destination: GameView(), isActive: $startApp){
                }
                Button("Start"){
                    startApp = true
                    tap.toggle()
                    feedback_generator()
                }
                    .padding(.top, 50.0)
                    .padding(.bottom, 30)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .opacity(self.scale)
                    .animation(.easeInOut(duration: 0.7).repeatForever(), value: scale)
                
                
                    
                Spacer()
                Text("Written by Senih O.")
                    .foregroundColor(.gray)
            }
            .onAppear {
                scale = 1
//                info.score = Info.score
            }
                
        }
        .environmentObject(info)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        
    }
    }
