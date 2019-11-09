//
//  ContentView.swift
//  Movie_Test_IOS
//
//  Created by Hamid Qureshi on 07/11/2019.
//  Copyright © 2019 Hamid Qureshi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var round = 1
    
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct baseStyle: ViewModifier {
        func body(content: Content) -> some View{
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct labelStyle: ViewModifier{
        func body(content: Content) ->  some View{
            return content
                .modifier(baseStyle())
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct valueStyle: ViewModifier{
        func body(content: Content) -> some View {
            return content
                .modifier(baseStyle())
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct buttonLargeTextStyle: ViewModifier{
           func body(content: Content) -> some View {
               return content
                   .foregroundColor(Color.black)
                   .font(Font.custom("Arial Rounded MT Bold", size: 18))
           }
       }
    
    struct buttonSmallTextStyle: ViewModifier{
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    var body: some View {
        VStack {
                Spacer()

                HStack {
                    Text("Put the bullseye as close as you can to:")
                        .modifier(labelStyle())
                    
                    Text("\(target)")
                        .modifier(valueStyle())
                }
            
            Spacer()

                
                HStack {
                    Text("1")
                        .modifier(labelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                    Text("100")
                        .modifier(labelStyle())
                }
            
            Spacer()

            
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit me!").modifier(buttonLargeTextStyle())
            }
            .background(Image("Button"))
            .modifier(baseStyle())
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in
                let roundedValue: Int = Int(sliderValue.rounded())
                let points = pointsforCurrentround(value: roundedValue)
                return Alert(title: Text(alertTitle(sliderValue: roundedValue)),
                             message: Text("The slider value is \(roundedValue). \n" +
                                "You scored \(points) points this round."),
                             dismissButton: .default(Text("Awesome!")){
                                self.totalScore += points
                                self.target = Int.random(in: 1...100)
                                self.round+=1
                    })
            }
            
            Spacer()
            

            
            HStack {
                
                Button(action: {
                    self.sliderValue = 50.0
                    self.target = Int.random(in: 1...100)
                    self.totalScore = 0
                    self.round = 1
                }){
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over").modifier(buttonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                .modifier(baseStyle())

                Spacer()
                
                Text("Score:")
                .modifier(labelStyle())

                Text("\(totalScore)")
                .modifier(valueStyle())

                Spacer()
                
                Text("Round:")
                .modifier(labelStyle())

                Text("\(round)")
                .modifier(valueStyle())

                Spacer()
                
                Button(action: {
                }){
                    NavigationLink(destination: AboutView()){
                        Image("InfoIcon")
                        Text("Info").modifier(buttonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                .modifier(baseStyle())

            }
            .padding(.bottom,20)
            
                
        }
        .accentColor(midnightBlue)
        .background(Image("Background"), alignment: .center)
        .navigationBarTitle("Bullseye")
    }
    
    func pointsforCurrentround(value: Int) -> Int {
        let baseScore = 100 - abs(target - value)
        var currentScore = baseScore
        
        if baseScore == 100 {
            currentScore += 100
        } else if baseScore == 99 {
            currentScore += 50
        }
                
        return currentScore
    }
    
    func alertTitle(sliderValue: Int) -> String{
        let difference = abs(target - sliderValue)
        let title: String
        if difference == 0{
            title = "Perfect!"
        }else if difference < 5{
            title = "You almost had it!"
        }else if difference <= 10{
            title = "Not bad!"
        }else{
            title = "Are you even trying?"
        }
        return title
            

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
