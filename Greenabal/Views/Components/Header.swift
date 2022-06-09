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
                .kerning(0.4)
                .fontWeight(.bold)
                .font(.system(size: 16))
        }
        .frame(maxWidth: .infinity,
               maxHeight: 48,
               alignment: .center)
        .background(name == "Home" ? Color.clear : Color.white)
    }
}

struct Header_Previews: PreviewProvider {
    static let background = BackgroundViewModel()
    
    static var previews: some View {
        TabBar().environmentObject(background)
    }
}
