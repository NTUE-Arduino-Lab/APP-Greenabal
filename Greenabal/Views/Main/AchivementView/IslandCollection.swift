//
//  IslandCollection.swift
//  Greenabal
//
//  Created by Tony on 2022/6/17.
//

import SwiftUI

struct IslandCollection: View {
    @EnvironmentObject var islandVM: IslandViewModel
    
    var body: some View {
        VStack{
            Text("\(islandVM.currentIsland.name)").font(.custom("Roboto Bold", size: 18)).tracking(1.44)
            Text("No. \(islandVM.currentIsland.number)").font(.custom("Roboto Medium", size: 16)).tracking(0.64).padding(.top,10)
            
            GeometryReader { outerView in
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
            HStack(){
                Image("IslandCollection-1").resizable().frame(width: 240, height: 240).padding(.trailing,40)
                Image("lockedCollection").padding(.trailing,40)
                Image("lockedCollection").padding(.trailing,40)
                Image("lockedCollection")
            }.frame( alignment: .leading)
                        .padding(.leading, outerView.size.width/2 - 120 ).padding(.trailing, outerView.size.width/2 - 70)
                }.frame(height: 300, alignment: .center)
                
            }.frame(height: 300)
            Text("Lv. \(islandVM.currentIsland.currentLevel)").font(.custom("Roboto Medium", size: 18)).tracking(0.72).padding(.bottom,10)
            Text("綠化天數：\(islandVM.currentIsland.costDay) 天").font(.custom("Roboto Medium", size: 18)).tracking(0.72)
            Text("").frame( height: 20).background(Color.clear)
        }.frame(maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center)
    }
}
