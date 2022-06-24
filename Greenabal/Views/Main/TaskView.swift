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
    
    @EnvironmentObject var taskListViewModel: TaskListViewModel
    @State private var showModal:Bool = false;
    @State private var taskModelIndex:Int = 0;
    //    @State private var taskCount:Int = taskListDataArray.count
    //    @State private var finishedTaskCount:Int = taskListDataArray.filter{$0.finish==true}.count
    @State private var title = "每日任務"
    private let name = "Task"
    private let modalHeader = "為什麼要用環保吸管？"
    private let TaskKnowledgeArticle:String="環保署統計臺灣每年塑膠吸管使用量約30億根，在這樣大量使用及其方便又隨手可得的情況下，造成龐大且難處理的塑膠垃圾，更是在淨灘廢棄物中排名前5名，可想而知也影響到了海洋生態，曾經有影片紀錄從海龜的呼吸道中拔出長長的吸管，想到就覺得好痛！\n目前環保署已有管制實施，但我們可以自動落實，大家可以尋找自己喜歡的環保吸管，與環保餐具一起帶出門，保護我們的生活環境也救救海龜！"
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    func setTaskModelIndex(Index:Int) -> (Void) {
        
    }
    struct TaskModalView: View {
        var modalHeader:String=""
        var TaskKnowledgeArticle:String=""
        @Binding var showModal:Bool
        var taskData:Task
        var completeTask: (Int) -> Void
        @Binding var taskModelIndex:Int
        func fakeCompleteMethon(fake:Int,fake2:Int){
            return
        }
        var body: some View {
            PopUpModalView(content:{
                ScrollView{
                    Text("\(TaskKnowledgeArticle)").font(.custom("Roboto Medium", size: 14)).tracking(0.56).lineSpacing(12)
                }.padding(.horizontal,24).padding(.vertical,12)
            },modalHeader:modalHeader,leaveNum:3,showModal:$showModal,completeMethon:completeTask,achivementCompleteMethon:fakeCompleteMethon,methonInt:taskModelIndex,modaltype:.knowledge)
            
            
        }
    }
    var body: some View {
        ZStack{
            VStack(){
                Header(title: $title, name: name)
                VStack{
                    
                    VStack(spacing:13){
                        HStack(alignment:.center ){
                            Spacer()
                            Text("完成\(taskListViewModel.completeCount)/5")
                                .font(.custom("Roboto Medium", size: 14))
                                .tracking(0.56)
                            
                        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
                        
                        ForEach(taskListViewModel.taskList.indices, id: \.self)  { index in
                            EachTaskView(index: index, data: taskListViewModel.taskList[index], completeTask: taskListViewModel.completeTask ,showModal:$showModal,taskModelIndex:$taskModelIndex)
                            
                        }.listRowSeparator(.hidden)
                    }.padding(.horizontal,27)
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .center)
            }
            //        .background(LinearGradient(
            //            gradient: Gradient(stops: [
            //                .init(color: Color(#colorLiteral(red: 0.6102343797683716, green: 0.7855484485626221, blue: 0.9125000238418579, alpha: 1)), location: 0),
            //                .init(color: Color(#colorLiteral(red: 0.915928840637207, green: 0.9526067972183228, blue: 0.9791666865348816, alpha: 1)), location: 1)]),
            //            startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
            //            endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999))
            //        )
            if showModal {
                TaskModalView(modalHeader:modalHeader,TaskKnowledgeArticle:TaskKnowledgeArticle,showModal:$showModal,taskData:taskListViewModel.taskList[0],completeTask: taskListViewModel.completeTask, taskModelIndex:$taskModelIndex)}
            }
            
    }
    
    
    
}



struct EachTaskView: View {
    
    let index: Int
    var data: Task
    var completeTask: (Int) -> Void
    @Binding var showModal:Bool
    //     @State var reLoadWidth:CGFloat = CGFloat(0)
//    var setTaskModelIndex:(Int) -> Void
    @Binding var taskModelIndex:Int
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    //    var simpleDrag: some Gesture {
    //            DragGesture()
    //                .onChanged { value in
    //                    print("aaa")
    //                }
    //        }
    var body: some View {
        switch data.task.type{
        case TaskType.knowledge:
            HStack{
                Button{
                    showModal=true
                    taskModelIndex=index
                }label:{
                    
                    if data.isComplete{
                        ZStack {
                            Text("").frame(width: 48,
                                           height: 48).background(Color.clear)
                            Text("").frame(width: 16, height: 16).background(LinearGradient(
                                colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )).cornerRadius(8)
                        }
                    }else{
                        
                            Image("play-circle").frame(width: 48,
                                                       height: 48)
                        
                        
                    }
                }
                Text(data.task.name).font(.custom("Roboto Medium", size: 14))
                Spacer()
                if data.isComplete{
                    Text("已領取").font(.custom("Roboto Medium", size: 14)).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))).tracking(0.56)
                    
                }else{
                    Text("\(data.task.leaf)").font(.system(size: 14))
                        .overlay {
                            LinearGradient(
                                colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                                startPoint: .leading,
                                endPoint: .trailing
                            ) .mask(
                                Text("\(data.task.leaf)")
                                    .font(Font.system(size: 14))
                                    .multilineTextAlignment(.center)
                            )
                        }
                    Image("leaf")
                }
                Spacer().frame(width: 15, height: 40)
            }.background(.white).cornerRadius(10)
        case TaskType.normal:
            
            HStack{
                
                Button{
                    completeTask(index)
                }label:{
                    
                    ZStack {
                        Text("").frame(width: 48,
                                       height: 48).background(Color.clear)
                        if data.isComplete{
                            Text("").frame(width: 16, height: 16).background(LinearGradient(
                                colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )).cornerRadius(8)
                        }else{
                            Text("").frame(width: 14, height: 14).background(Color.clear).overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 210/255, green: 210/255,blue: 210/255), lineWidth: 2)
                                
                            )
                        }
                        
                    }
                }
                if data.isComplete{
                    Text(data.task.name).font(.custom("Roboto Medium", size: 14)).strikethrough().foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.6))).tracking(0.56)
                }else{
                    Text(data.task.name).font(.custom("Roboto Medium", size: 14))
                }
                
                Spacer()
                if data.isComplete{
                    Text("已領取").font(.custom("Roboto Medium", size: 14)).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))).tracking(0.56)
                    
                }else{
                    Text("\(data.task.leaf)").font(.system(size: 14))
                        .overlay {
                            LinearGradient(
                                colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                                startPoint: .leading,
                                endPoint: .trailing
                            ) .mask(
                                Text("\(data.task.leaf)")
                                    .font(Font.system(size: 14))
                                    .multilineTextAlignment(.center)
                            )
                        }
                    Image("leaf")
                    
                }
                Spacer().frame(width: 15, height: 40)
            }.background(.white).cornerRadius(10)
                .modifier(DraggableModifier(direction: .horizontal,finished:data.isComplete))
            //                    .gesture(
            //                                    simpleDrag
            //                                )
            //                Text("").frame(width: 48, height: 48 )
            //                Text("").frame(width: self.reLoadWidth, height: 48 )
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var leafVM:LeafViewModel = LeafViewModel()
    static var badgeVM:BadgeViewModel = BadgeViewModel()
    static var taskListVM:TaskListViewModel = TaskListViewModel(leafVM: leafVM, badgeVM: badgeVM)
    
    static var previews: some View {
        TabBar(initSelectedTab: "Task")
            .environmentObject(taskListVM)
    }
}

struct DraggableModifier : ViewModifier {
    enum Direction {
        case vertical
        case horizontal
    }
    
    let direction: Direction
    @State private var reLoadWidth:CGFloat=CGFloat(0)
    @State private var draggedOffset: CGSize = .zero
    @State private var BreakPoint:CGSize = .zero
    @State private var isShowIcon:Bool = false
    @State private var IconOpacity:Double = 0
    @State private var frameOpacity:Double = 0
    var finished:Bool
    //    @State private var frameCornerR:Double = 0
    
    func body(content: Content) -> some View {
        HStack{
            content
                .offset(
                    finished == true ?
                    CGSize(width: 0,height:   0 )
                    :
                        CGSize(width: direction == .vertical ? 0 : draggedOffset.width,
                               height: direction == .horizontal ? 0 : draggedOffset.height)
                    
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            //               if self.draggedOffset.width > CGFloat(-40) && self.draggedOffset.width <= CGFloat(0){
                            print(finished)
                            guard !finished else{
                                return
                            }
                            if self.BreakPoint.width == CGFloat(0){
                                if value.translation.width >= CGFloat(-52) && value.translation.width <= CGFloat(0){
                                    self.draggedOffset = CGSize(width:self.BreakPoint.width + value.translation.width,height:self.BreakPoint.height + value.translation.height)
                                    self.reLoadWidth = CGFloat(value.translation.width * -1 - 2)
                                    if value.translation.width <= CGFloat(-12){
                                        self.frameOpacity =  ( -12 - value.translation.width )/40
                                    }
                                    if value.translation.width <= CGFloat(-32){
                                        self.IconOpacity =  ( -32 - value.translation.width )/20
                                        //                            self.frameCornerR = (-32 - value.translation.width)/2
                                    }
                                }
                                
                            }else if self.BreakPoint.width == CGFloat(-50){
                                if value.translation.width <= CGFloat(52) && value.translation.width >= CGFloat(0){
                                    self.draggedOffset = CGSize(width:self.BreakPoint.width + value.translation.width,height:self.BreakPoint.height + value.translation.height)
                                    self.reLoadWidth = CGFloat(46 - value.translation.width )
                                    if value.translation.width <= CGFloat(40){
                                        self.frameOpacity =  (40 - value.translation.width )/40
                                        
                                    }else{
                                        self.frameOpacity = 0
                                    }
                                    if value.translation.width <= CGFloat(20){
                                        self.IconOpacity =  (20 - value.translation.width )/20
                                    }else{
                                        
                                        self.IconOpacity = 0
                                    }
                                }
                            }
                            
                            
                            
                            //                print(value.translation)
                            //                print(value.startLocation)
                            //                    print(self.draggedOffset.width)
                            
                            //                }
                        }
                        .onEnded { value in
                            guard !finished else{
                                self.draggedOffset = .zero
                                self.BreakPoint = .zero
                                self.reLoadWidth=CGFloat(0)
                                self.IconOpacity=0
                                self.frameOpacity = 0
                                return
                            }
                            if value.translation.width < -30{
                                self.draggedOffset = CGSize(width:-50 , height:0 )
                                self.BreakPoint = CGSize(width:-50 , height:0 )
                                self.reLoadWidth=CGFloat(48)
                                self.IconOpacity=0.8
                                self.frameOpacity = 1
                                //                    isShowIcon.toggle()
                            }else{
                                self.draggedOffset = .zero
                                self.BreakPoint = .zero
                                self.reLoadWidth=CGFloat(0)
                                self.IconOpacity=0
                                self.frameOpacity = 0
                                //                    isShowIcon.toggle()
                            }
                            
                        }
                ).overlay(HStack{Spacer()
                    if(finished){}else{
                        ZStack{Text("").frame(width: self.reLoadWidth, height: 48 ).background(.white).cornerRadius(10).opacity(self.frameOpacity)
                            Button{
                                print("reload!")
                            } label: {
                                Image("reLoad").resizable().frame(width: 16, height: 16).opacity(self.IconOpacity)
                            }
                        }}
                },alignment: .top)
            
        }
    }
    
}
