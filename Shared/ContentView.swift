//
//  ContentView.swift
//  Shared
//
//  Created by 조상호 on 2021/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      VStack(alignment: .leading) {
        Spacer()
        HStack {
            Spacer()
            Image("Illustration 1")
              .resizable()
              .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
            Spacer()
        }
        Text("Hello, SwiftUI!").fontWeight(.bold).foregroundColor(Color.white)
        Text("30 Sections").font(.footnote).foregroundColor(Color.white)
      }
      .padding(.all)
      .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
      .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
      .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        ContentView()
        ContentView()
          .frame(width: 200.0, height: 200.0)
          .preferredColorScheme(.dark)
      }
    }
}
