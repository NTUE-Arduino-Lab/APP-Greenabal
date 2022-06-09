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
    var body: some View {
        
        VStack {
            Text("今日任務")
            .frame(
                 
                  maxWidth: .infinity
            ).frame( height: 48).background(.white)
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
        }.background(.blue)
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
