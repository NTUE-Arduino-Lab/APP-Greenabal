//
//  TaskView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var taskListVM: TaskListViewModel
    @State private var title = "每日任務"
    private let name = "Task"
    
    var body: some View {
        ZStack{
            VStack(){
                Header(title: $title, name: name)
                
                VStack{
                    VStack(spacing:13){
                        HStack(alignment:.center ){
                            Spacer()
                            Text("完成\(taskListVM.completeCount)/5")
                                .font(.custom("Roboto Medium", size: 14))
                                .tracking(0.56)
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
                        
                        ForEach(taskListVM.taskList.indices, id: \.self)  { index in
                            EachTaskView(index: index, data: taskListVM.taskList[index], completeTask: taskListVM.completeTask)
                        }
                        .listRowSeparator(.hidden)
                    }.padding(.horizontal,27)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .center)
            }
        }
    }
}



struct EachTaskView: View {
    @EnvironmentObject var modalVM: ModalViewModel
    let index: Int
    var data: Task
    var completeTask: (Int) -> Void
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    
    var body: some View {
        switch data.task.type{
        case TaskType.knowledge:
            HStack{
                Button{
                    modalVM.showKnowledgeModal(data: data)
                }label:{
                    if data.isComplete{
                        ZStack{
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color(#colorLiteral(red: 0.06906247138977051, green: 0.9208333492279053, blue: 0.7675145268440247, alpha: 1)), location: 0.15625),
                                        .init(color: Color(#colorLiteral(red: 0.028055548667907715, green: 0.8416666388511658, blue: 0.2558666467666626, alpha: 1)), location: 1)]),
                                    startPoint: UnitPoint(x: -1.3877787807814457e-15, y: -1.3877787807814457e-15),
                                    endPoint: UnitPoint(x: 1.000000029802322, y: 1.000000029802322)))
                                .frame(width: 16, height: 16)
                        }.frame(width: 48, height: 48)
                    }else{
                        Image("play-circle")
                            .frame(width: 48,height: 48)
                    }
                }
                
                Text(data.task.name).font(.custom("Roboto Medium", size: 14))
                
                Spacer()
                
                if data.isComplete{
                    Text("已領取")
                        .font(.custom("Roboto Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)))
                        .tracking(0.56)
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
                    Text(data.task.name)
                        .font(.custom("Roboto Medium", size: 14))
                        .strikethrough()
                        .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.6))).tracking(0.56)
                }else{
                    Text(data.task.name).font(.custom("Roboto Medium", size: 14))
                }
                
                Spacer()
                
                if data.isComplete{
                    Text("已領取")
                        .font(.custom("Roboto Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)))
                        .tracking(0.56)
                    
                }else{
                    Text("\(data.task.leaf)")
                        .font(.system(size: 14))
                        .overlay {
                            LinearGradient(
                                colors: [Color(red: 18/255, green: 235/255,blue: 195/255),Color(red: 7/255, green: 215/255,blue: 66/255) ],
                                startPoint: .leading,
                                endPoint: .trailing
                            ).mask(
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
        }
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

struct TaskView_Previews: PreviewProvider {
    static var modalVM: ModalViewModel = ModalViewModel()
    static var leafVM: LeafViewModel = LeafViewModel(mvm: modalVM)
    static var badgeVM: BadgeViewModel = BadgeViewModel(leafVM: leafVM, modalVM: modalVM)
    static var taskListVM:TaskListViewModel = TaskListViewModel(leafVM: leafVM, badgeVM: badgeVM)
    
    static var previews: some View {
        TabBar(initSelectedTab: "Task")
            .environmentObject(taskListVM)
            .environmentObject(modalVM)
    }
}
