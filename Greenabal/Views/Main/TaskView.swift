//
//  TaskView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI
struct ListData
{
    var taskClass:String
    var taskDetail:String
    var taskReward:Int
}

struct TaskView: View {
    @EnvironmentObject var background: BackgroundViewModel
    private let title = "每日任務"
    private let name = "Task"
    
    var body: some View {
        VStack(){
            Header(title: title, name: name)
            
            VStack{
                
                VStack {
                    
                    VStack(spacing:13){
                        HStack{
                            let leafNum:Int=2
                            Button{
                                
                            }label:{
                                Image("play-circle").frame(width: 48,
                                                           height: 48)
                            }
                            Text("閱讀環保知識").font(.system(size: 14))
                            Spacer()
                            
                            Text("\(leafNum)").font(.system(size: 14))
                                .overlay {
                                    LinearGradient(
                                        colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ) .mask(
                                        Text("\(leafNum)")
                                            .font(Font.system(size: 14))
                                            .multilineTextAlignment(.center)
                                    )
                                }
                            Image("leaf")
                            Spacer().frame(width: 15, height: 40)
                        }.background(.white).cornerRadius(10)
                        HStack{
                            let leafNum:Int=2
                            Button{
                                
                            }label:{
                                Image("play-circle").frame(width: 48,
                                                           height: 48)
                            }
                            Text("閱讀環保知識").font(.system(size: 14))
                            Spacer()
                            
                            Text("\(leafNum)").font(.system(size: 14))
                                .overlay {
                                    LinearGradient(
                                        colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ) .mask(
                                        Text("\(leafNum)")
                                            .font(Font.system(size: 14))
                                            .multilineTextAlignment(.center)
                                    )
                                }
                            Image("leaf")
                            Spacer().frame(width: 15, height: 40)
                            
                        }.background(.white).cornerRadius(10)
                        Spacer()
                    }.padding(.horizontal,27)
                }
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .background(background.color)
    }
}

struct TaskView_Previews: PreviewProvider {
    static let background = BackgroundViewModel()
    
    static var previews: some View {
        TabBar().environmentObject(background)
    }
}

