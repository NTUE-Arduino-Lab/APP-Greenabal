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
    @State var currentIndex = 0
    @GestureState var dragOffset: CGFloat = 0
    @Binding var medalDataArray:[MedalListData]
    var body: some View {
        VStack{
            HStack{
                Text("成就徽章").font(.custom("Roboto Bold", size: 14)).foregroundColor(Color(#colorLiteral(red: 0.12, green: 0.12, blue: 0.12, alpha: 1))).tracking(0.56)
                Spacer()
            }.padding(.top,20).padding(.horizontal,20)
            
            GeometryReader { outerView in
                
                //                ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing:0){
                    ForEach((0...medalDataArray.count/6), id: \.self){ index in
                        
                        
                        let num = index*6
                        LazyVGrid(columns: gridItemLayout) {
                            ForEach((num..<num+6), id: \.self) { number in
                                VStack(spacing:0){
                                    if number < medalDataArray.count{
                                        if medalDataArray[number].rank != 0{
                                            Image("\(medalDataArray[number].medalClass)-\(medalDataArray[number].rank)").padding(.bottom,5)
                                            Text("\(medalDataArray[number].medalName)").font(.custom("Roboto Regular", size: 14)).tracking(0.56).padding(.bottom,5)
                                            Text("\(medalDataArray[number].medalCondition)").font(.custom("Roboto Regular", size: 10)).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)))
                                        }else{
                                            Image("none").padding(.bottom,5)
                                            Text("???").font(.custom("Roboto Regular", size: 14)).tracking(0.56).padding(.bottom,5)
                                            Text("???").font(.custom("Roboto Regular", size: 10)).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)))
                                        }
                                    }else{
                                        
                                    }
                                }.frame(width: 80, height: 123).padding(.bottom,10)
                            }
                        }.padding(.horizontal, 20)
                            .frame(width: outerView.size.width, height: outerView.size.height)
                            .offset(x: -CGFloat(self.currentIndex) * outerView.size.width)
                            .offset(x: self.dragOffset).animation(Animation.linear(duration:0.3),value: UUID())

                    }
                }
                //            }
                .frame(width: outerView.size.width, height: outerView.size.height, alignment: .leading).background(.white).clipped().padding(.top,10)
                .gesture(
                    DragGesture()
                        .updating(self.$dragOffset, body: { value, state, transaction in
                            if self.currentIndex == 0 && value.translation.width > 0
                            {}else{
                                if medalDataArray.count > 6 * (currentIndex+1) {
                                    state = value.translation.width
                                }else if value.translation.width > 0{
                                    state = value.translation.width
                                }
                            }
                        })
                        .onEnded({ value in
                            var newIndex:Int
                            let threshold = outerView.size.width * 0.3
                            if value.translation.width < 0 {
                                if -value.translation.width > threshold{
                                    newIndex = self.currentIndex + 1
                                }else{
                                    newIndex = self.currentIndex
                                }
                            }else{
                                
                                if value.translation.width > threshold{
                                    newIndex = self.currentIndex - 1
                                }else{
                                    newIndex = self.currentIndex
                                }
                            }
                            if newIndex >= 0 {
                                
                                if medalDataArray.count > 6*(newIndex){
                                    self.currentIndex = newIndex
                                }
                            }
                            
                        })
                )
            }
            
            
            HStack(spacing:5){
                ForEach(0..<(medalDataArray.count / 6)+1){number in
                    if number == medalDataArray.count / 6  && medalDataArray.count%6 == 0 {
                        Text("")
                    }
                    else if number == currentIndex{
                        Circle()
                            .fill(Color(red: 18/255, green: 230/255,blue: 196/255))
                            .frame(width: 5, height: 5)
                    }else{
                        Circle()
                            .fill(Color(red: 230/255, green: 235/255,blue: 230/255))
                            .frame(width: 5, height: 5)
                    }
                    
                }
                
            }.padding(.bottom,18).padding(.top,10)
            
            
        }.frame(height: 360,alignment: .top).background( RoundedRectangle(cornerRadius: 10).fill(Color.white)).padding(.horizontal,16)
    }
}