//
//  AchivementView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/8.
//

import SwiftUI
struct MedalListData:Identifiable
{
    var id = UUID()
    var rank:Int
    //0~3
    var medalClass:String
    var medalName:String
    var medalCondition:String
}



struct AchivementView: View {
    //圖表作法參考自 https://www.appcoda.com.tw/swiftui-bar-chart/
    @EnvironmentObject var background: BackgroundViewModel
    @State var medalDataArray:[MedalListData]=[
        MedalListData(rank:3,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:3,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:3,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:3,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次"),
        MedalListData(rank:0,medalClass:"medal-bike",medalName:"YouBike 王",medalCondition:"騎行達 100 次")
        
    ]
    private let title = "成就"
    private let name = "Achivement"
    @State var data: [Double] = [0,12,1,2,15,13,22]
    @State var labels: [String] = ["0","6","12","18","24"]
    @State var tabTarget: Int = 0
    private var tabs = ["環保行動","島嶼圖鑑"]
    let accentColor1: Color = Color(red: 18/255, green: 235/255,blue: 196/255)
    let accentColor2: Color = Color(red: 7/255, green: 215/255,blue: 65/255)
    let axisColor: Color = Color.blue
    let showGrid: Bool = true
    let gridColor: Color = Color(red: 204/255, green: 204/255,blue: 204/255)
    let spacing: CGFloat = 15
    var body: some View {
        VStack{
            Header(title: title, name: name)
            VStack{
            ZStack(alignment: .bottom){
                if tabTarget == 0 {
                    ScrollView(.vertical,showsIndicators:false){
                        VStack(spacing: 20){
                        
                        RecordBlock(data:$data,labels: $labels,accentColor1: accentColor1,accentColor2: accentColor2,axisColor: axisColor,showGrid: showGrid,gridColor: gridColor,spacing: spacing)
                        AchivementBlock(pageNum:medalDataArray.count,medalDataArray:$medalDataArray)
                        }
                        Text("").frame(width: 200, height: 70).background(Color.clear)
                    }
                }
                else{
                    
                    IslandCollection()
                    
                }
                
                   
                SubTabBar(tabs:tabs,tabTarget: $tabTarget)
                
            }
            .padding([.bottom],93)
            
            
            
        } .frame(maxWidth: .infinity,
                 maxHeight: .infinity,
                 alignment: .center)
        }
        .background(background.color)
    }
}

struct AchivementView_Previews: PreviewProvider {
    static let backgroundViewModel = BackgroundViewModel()
    
    static var previews: some View {
        TabBar(initSelectedTab: "Achivement").environmentObject(backgroundViewModel)
    }
}





