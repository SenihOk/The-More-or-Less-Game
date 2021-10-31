//
//  GameView.swift
//  Moore or Less
//
//  Created by Senih Okuyucu on 10/27/21.
//

import SwiftUI

struct GameView: View {
    let defaults = UserDefaults.standard
    @EnvironmentObject var info: Info
    @State var tap: Bool = false
    @State var score = 0
    @State var score_color:Color = (Color("Text Color"))
    @State var bt_count:Int = 0
    @State var ct_count:Int = 0
    @State var high_score = UserDefaults.standard.integer(forKey:"HighScore")
    @State private var reset_HS: Bool = false
    let taptic_response = UIImpactFeedbackGenerator(style: .medium)
    func correct(){
        info.score += 1
        score_color = .green
        withAnimation(.easeIn(duration: 0.35)) {
            self.score_color = .white
        }
    }
    func incorrect(){
        info.score = 0
        score_color = .red
        withAnimation(.easeIn(duration: 0.35)) {
        score_color = .white
        }
    }
    func checkHighScore(){
        
        self.high_score = defaults.integer(forKey: "HighScore")
        }
    func checkScore(){
        if info.score > self.high_score{
            self.high_score = info.score
            defaults.set(self.high_score, forKey: "HighScore")
        }
    }
 
    func getRandNum() -> Int{
        return (Int.random(in: 10..<100))
    }
    func getNewSet(){
        bt_count = getRandNum()
        ct_count = getRandNum()
        while ct_count == bt_count{
            ct_count = getRandNum()
        }
        checkScore()
        checkHighScore()
    }
    func feedback_generator(){
        taptic_response.prepare()
        if tap == true{
            taptic_response.impactOccurred()
            tap = false
        }
    }
    ///
    // done defining variables and setting up functions
    ///
    var body: some View {
        VStack(alignment: .center){
            Text("Which is Greater?")
                .font(.largeTitle)
    
            Button("High Score:\(high_score)"){
                reset_HS.toggle()
            }
            .alert(isPresented: $reset_HS) {
                Alert(title: Text("HS Reset"),
                      message: Text("Are you sure you want to reset your High Score?"),
                      primaryButton: .default(Text("Yes"), action:{
                    high_score = 0
                    defaults.set(high_score, forKey:"HighScore")
                }),
                      secondaryButton: .cancel(Text("No")))
            }
            .foregroundColor(Color("Text Color"))

            Text("Score:\(info.score)")
                .foregroundColor(Color("Text Color"))
                .colorMultiply(score_color)
//                .animation(.easeIn(duration: 0.2), value: score_color)
                .padding(.bottom, 50.0)
                .padding(.bottom, 300.0)
                .font(.title2)
            
            HStack(alignment: .center){
                VStack{
                    Button("\(bt_count)"){
                        tap.toggle()
                        feedback_generator()
                        if bt_count > ct_count{
                            correct()
                        }
                        else{
                            incorrect()
                        }
                        getNewSet()
                    }
                    .accentColor(.blue)
                    .font(.largeTitle)
                }
                .frame(width: 100, height: 200, alignment: .leading)
                Text("or")
                    .font(.largeTitle)
                Button("\(ct_count)"){
                    tap.toggle()
                    feedback_generator()
                    if bt_count < ct_count{
                        correct()
                    }
                    else{
                        incorrect()
                    }
                   getNewSet()
                }
                .accentColor(.blue)
                .font(.largeTitle)

                .frame(width: 100, height: 200, alignment: .trailing)

                .onAppear(){
                    getNewSet()
                    checkHighScore()
                }
                .onDisappear(){
                    checkScore()
                }
            }
        }
        .padding(40.0)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .preferredColorScheme(.dark)
    }
}
