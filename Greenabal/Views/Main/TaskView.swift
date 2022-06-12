//
//  TaskView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI




struct taskListData:Identifiable
{
    var id = UUID()
    var finish:Bool
    var taskClass:String
    var taskDetail:String
    var taskReward:Int
}

struct TaskView: View {
    
    @EnvironmentObject var background: BackgroundViewModel
    @State private var taskListDataArray : [taskListData] = [
        taskListData(finish:false, taskClass: "1",taskDetail: "閱讀環保知識",taskReward: 2),
        taskListData(finish:false, taskClass: "2",taskDetail: "自備環保餐具無拿取免洗餐具",taskReward: 3),
        taskListData(finish:false, taskClass: "2",taskDetail: "落實資源回收",taskReward: 2),
        taskListData(finish:false, taskClass: "2",taskDetail: "自備購物袋/塑膠袋",taskReward: 2),
        taskListData(finish:false, taskClass: "2",taskDetail: "檢查並拔掉無使用的插頭",taskReward: 2)
    ]
    
//    @State private var taskCount:Int = taskListDataArray.count
//    @State private var finishedTaskCount:Int = taskListDataArray.filter{$0.finish==true}.count
    private let title = "每日任務"
    private let name = "Task"
    
    var body: some View {
        VStack{
            Header(title: title, name: name)
            
            VStack{
                
                
                    
                VStack(spacing:13){
                    HStack(alignment:.center ){
                        Spacer()
                        Text("完成\(taskListDataArray.filter{$0.finish==true}.count)/\(taskListDataArray.count)")
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
                   
                       
                        ForEach(0..<taskListDataArray.count,id: \.self)  { item in
                                       
                            EachTaskView(item:item,taskListDataArray:$taskListDataArray)
                            
                                   }
                        

                        
                        Spacer()
                    }.padding(.horizontal,27)
                
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .background(background.color)
    }
}



struct EachTaskView: View {
    var item:Int
    @Binding var taskListDataArray:[taskListData]
    
    var body: some View {
        switch taskListDataArray[item].taskClass{
        case "1":
            HStack{
                
                Button{
                    taskListDataArray[item].finish.toggle()
                }label:{
                    Image("play-circle").frame(width: 48,
                                               height: 48)
                }
                Text(taskListDataArray[item].taskDetail).font(.system(size: 14))
                Spacer()
                
                Text("\(taskListDataArray[item].taskReward)").font(.system(size: 14))
                    .overlay {
                        LinearGradient(
                            colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ) .mask(
                            Text("\(taskListDataArray[item].taskReward)")
                                .font(Font.system(size: 14))
                                .multilineTextAlignment(.center)
                        )
                    }
                Image("leaf")
                Spacer().frame(width: 15, height: 40)
            }.background(.white).cornerRadius(10)
        case "2":
            
            HStack{
                
                Button{
                    taskListDataArray[item].finish.toggle()
                   
                }label:{
                    
                    ZStack {
                        Text("").frame(width: 48,
                                       height: 48).background(Color.clear)
                        if taskListDataArray[item].finish{
                            Text("").frame(width: 16, height: 16).background(LinearGradient(
                                colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )).cornerRadius(8)
                        }else{
                            Text("").frame(width: 14, height: 14).background(Color.clear).overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 230/255, green: 230/255,blue: 230/255), lineWidth: 2)
                                
                            )
                        }
                        
                    }
                }
                Text(taskListDataArray[item].taskDetail).font(.system(size: 14))
                Spacer()
                
                Text("\(taskListDataArray[item].taskReward)").font(.system(size: 14))
                    .overlay {
                        LinearGradient(
                            colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ) .mask(
                            Text("\(taskListDataArray[item].taskReward)")
                                .font(Font.system(size: 14))
                                .multilineTextAlignment(.center)
                        )
                    }
                Image("leaf")
                Spacer().frame(width: 15, height: 40)
            }.background(.white).cornerRadius(10)
        default:
            Text("3: " + taskListDataArray[item].taskDetail)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static let background = BackgroundViewModel()
    
    static var previews: some View {
        TabBar().environmentObject(background)
    }
}
