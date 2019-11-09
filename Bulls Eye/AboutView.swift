//
//  AboutView.swift
//  Movie_Test_IOS
//
//  Created by Hamid Qureshi on 09/11/2019.
//  Copyright © 2019 Hamid Qureshi. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct headerStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 30))
            .foregroundColor(Color.black)
            .padding(.bottom,20)
            .padding(.top,20)
        }
    }
    
    struct textBodyStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(Color.black)
            .padding(.bottom,20)
            .padding(.leading,60)
            .padding(.trailing,60)

        }
    }
    
    var body: some View {
        Group{
            VStack{
                Text("🎯 Bullseye 🎯")
                    .modifier(headerStyle())
                
                Text("This is bullseye. A game where you can earn points by hitting the bullseye on the slider")
                    .modifier(textBodyStyle())

                Text("Enjoy the Game!")
                    .modifier(textBodyStyle())
            }
            .background(beige)
            .navigationBarTitle("About")
        }
        .background(Image("Background"))

    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
        .previewLayout(.fixed(width: 896, height: 414))
    }
}
