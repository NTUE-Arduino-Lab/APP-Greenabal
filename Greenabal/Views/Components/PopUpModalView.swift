//
//  PopUpModalView.swift
//  Greenabal
//
//  Created by Tony on 2022/6/21.
//

import SwiftUI

struct PopUpModalView<Content: View>: View {
    @EnvironmentObject var taskListViewModel: TaskListViewModel
    @ViewBuilder var content: Content
    var modalHeader : String? = nil
    var leaveNum : Int? = nil
    @State var gotLeaf : Bool? = true
    @Binding var showModal:Bool
    var completeMethon: (Int) -> Void
    var achivementCompleteMethon: (Int,Int) -> Void
    var methonInt:Int
    enum Modaltype {
        case knowledge
        case bagdge
    }
    var modaltype: Modaltype
    var achivementFakeData:[MedalListData]?=[
        MedalListData(rank:1,medalClass:"medal-bike",medalName:"Youbike王",medalTitle:["見習騎士","城市漫遊者","熱血鐵騎仔"],goalCounts: [10,50,100],medalCondition:["騎行達 10 次","騎行達 50 次","騎行達 100 次"],medalReward: [3,6,12],medalRewardGot: [true,false,false])]
    var body: some View {
        
        
        VStack(spacing:0){
            ZStack{
                Text("").frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .center)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3))).onTapGesture {
                        showModal=false
                    }
                VStack(){
                    if modalHeader != nil{
                        Text("\(modalHeader ?? " ")").frame(maxWidth: .infinity,
                                                            maxHeight:50,alignment:.center).overlay(
                                                                Rectangle()
                                                                    .frame(height: 2)
                                                                    .foregroundColor(Color(#colorLiteral(red: 241/255, green: 241/255, blue: 241/255, alpha: 1))),
                                                                alignment: .bottom
                                                            )
                    }else{
                        
                    }
                    Spacer()
                    content
                    Spacer()
                    if leaveNum != nil{
                        ZStack{
                            
                            Text("").frame(maxWidth: .infinity,
                                           maxHeight:54,alignment:.center).overlay(
                                            Rectangle()
                                                .frame(height: 2)
                                                .foregroundColor(Color(#colorLiteral(red: 241/255, green: 241/255, blue: 241/255, alpha: 1))),
                                            alignment: .top
                                           )
                            
                            switch modaltype{
                            case .knowledge:
                            Button{
                                self.gotLeaf = true
                                completeMethon(methonInt)
                            }label:{
                                HStack(spacing:5){
                                    
                                        
                                        ButtonContents(gotLeaf:taskListViewModel.taskList[methonInt].isComplete,leaveNum:leaveNum)
                                    
                                    
                                }.frame(width: 90, height: 36).background(.white).clipShape(Capsule()).shadow(
                                    color: Color(#colorLiteral(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)),
                                    radius: CGFloat(3),
                                    x: CGFloat(0), y: CGFloat(5))
                            }.disabled(taskListViewModel.taskList[methonInt].isComplete)
                        case .bagdge:
                                Button{
                                    self.gotLeaf = true
                                    achivementCompleteMethon(methonInt,(achivementFakeData?[methonInt].rank)! )
                                }label:{
                                    HStack(spacing:5){
                                        
                                       
                                                //不會執行
                                        ButtonContents(gotLeaf:achivementFakeData?[methonInt].medalRewardGot[(achivementFakeData?[methonInt].rank)! - 1] ,leaveNum:leaveNum)
                                       
                                        
                                        
                                    }.frame(width: 90, height: 36).background(.white).clipShape(Capsule()).shadow(
                                        color: Color(#colorLiteral(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)),
                                        radius: CGFloat(3),
                                        x: CGFloat(0), y: CGFloat(5))
                                }.disabled((achivementFakeData?[methonInt].medalRewardGot[(achivementFakeData?[methonInt].rank)! - 1])!)
                            }
                            
                            
                        }
                        
                    }else{}
                }.frame(maxWidth: .infinity,
                        maxHeight:400,alignment:.center).background(Color(#colorLiteral(red: 0.9700000286102295, green: 0.9700000286102295, blue: 0.9700000286102295, alpha: 1))).cornerRadius(20).padding(.horizontal,30)
                
                
                
            }.frame(maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center)
            
        }
        
    }
}

struct ButtonContents:View{
    var gotLeaf:Bool?
    var leaveNum:Int?
    
    var body:some View{
        
        if gotLeaf == true{
            Text("\(leaveNum ?? 0)").font(.custom("Roboto Bold", size: 14)).tracking(0.56).multilineTextAlignment(.trailing).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)))
            
            Image("icon-leaf-gray-2")
        }else{
            Text("\(leaveNum ?? 0)").font(.custom("Roboto Bold", size: 14)).tracking(0.56).multilineTextAlignment(.trailing).overlay {
                LinearGradient(
                    colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                    startPoint: .leading,
                    endPoint: .trailing
                ) .mask(
                    Text("\(leaveNum ?? 0)").font(.custom("Roboto Bold", size: 14))
                        .tracking(0.56).multilineTextAlignment(.trailing)
                )
            }
            
            Image("leaf")
            
        }
    }
}
