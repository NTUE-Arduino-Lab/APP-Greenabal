//
//  Header.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/9.
//

import SwiftUI

struct Header: View {
    let title: String
    let name: String
    
    var body: some View {
        ZStack{
            Text(title)
                .font(.custom("Roboto Bold", size: 16))
                .tracking(0.64)
        }
        .frame(maxWidth: .infinity,
               maxHeight: 48,
               alignment: .center)
        .background(name == "Home" ? Color.clear : Color.white)
        .shadow(color: name == "Home" ? Color.clear:Color(#colorLiteral(red: 0.7572221755981445, green: 0.903833270072937, blue: 0.966666579246521, alpha: 0.25)), radius:4, x:0, y:4)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Home", name: "Home")
    }
}
