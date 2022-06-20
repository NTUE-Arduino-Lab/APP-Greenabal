//
//  Achivement.swift
//  Greenabal
//
//  Created by Tony on 2022/6/16.
//



import Foundation
import SwiftUI



struct AchivementBlock: View {
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var pageNum:Int
    @Binding var medalDataArray:[MedalListData]
    var body: some View {
        VStack{
            HStack{
                Text("成就徽章").font(.custom("Roboto SemiBold", size: 14)).foregroundColor(Color(#colorLiteral(red: 0.12, green: 0.12, blue: 0.12, alpha: 1))).tracking(0.56)
                Spacer()
            }.padding(.top,14).padding(.horizontal,20)
            
            LazyVGrid(columns: gridItemLayout) {
                ForEach((0..<medalDataArray.count), id: \.self) { number in
                    VStack{
                        if medalDataArray[number].rank != 0{
                            Image("\(medalDataArray[number].medalClass)-\(medalDataArray[number].rank)")
                            Text("\(medalDataArray[number].medalName)").font(.custom("Roboto Regular", size: 14)).tracking(0.56)
                            Text("\(medalDataArray[number].medalCondition)").font(.custom("Roboto Regular", size: 10)).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)))
                        }else{
                            Image("none")
                            Text("???").font(.custom("Roboto Regular", size: 14)).tracking(0.56)
                            Text("???").font(.custom("Roboto Regular", size: 10)).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)))
                        }
                        
                    }
                }
            }.padding(.top,10)
            
            HStack(spacing:5){
                //                    ForEach(0..<(medalDataArray.count / 6)){number in
                //                        if number == 0{
                //                        Circle()
                //                            .fill(Color(red: 230/255, green: 235/255,blue: 230/255))
                //                            .frame(width: 5, height: 5)
                //                        }else{
                //                            Circle()
                //                                .fill(Color(red: 18/255, green: 230/255,blue: 196/255))
                //                                .frame(width: 5, height: 5)
                //                        }
                //                    }
                Circle()
                    .fill(Color(red: 18/255, green: 230/255,blue: 196/255))
                    .frame(width: 5, height: 5)
                Circle()
                    .fill(Color(red: 230/255, green: 235/255,blue: 230/255))
                    .frame(width: 5, height: 5)
                Circle()
                    .fill(Color(red: 230/255, green: 235/255,blue: 230/255))
                    .frame(width: 5, height: 5)
                Circle()
                    .fill(Color(red: 230/255, green: 235/255,blue: 230/255))
                    .frame(width: 5, height: 5)
            }
            
            
        }.frame(height: 314 ,alignment: .top).background( RoundedRectangle(cornerRadius: 10).fill(Color.white)).padding(.horizontal,16)
    }
}
