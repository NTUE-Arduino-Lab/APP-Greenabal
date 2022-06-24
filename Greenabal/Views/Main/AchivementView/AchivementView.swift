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
    var medalTitle:[String]
    var goalCounts: [Int]
    var medalCondition:[String]
    var medalReward:[Int] //獎勵葉子數量
    var medalRewardGot:[Bool] //葉子領過沒 true是還沒
}



struct AchivementView: View {
    //圖表作法參考自 https://www.appcoda.com.tw/swiftui-bar-chart/
    @State var medalDataArray:[MedalListData]=[
        MedalListData(rank:1,medalClass:"medal-bike",medalName:"Youbike王",medalTitle:["見習騎士","城市漫遊者","熱血鐵騎仔"],goalCounts: [10,50,100],medalCondition:["騎行達 10 次","騎行達 50 次","騎行達 100 次"],medalReward: [3,6,12],medalRewardGot: [true,false,false]),
        MedalListData(rank:2,medalClass:"medal-bike",medalName:"Youbike王",medalTitle:["見習騎士","城市漫遊者","熱血鐵騎仔"],goalCounts: [10,50,100],medalCondition:["騎行達 10 次","騎行達 50 次","騎行達 100 次"],medalReward: [3,6,12],medalRewardGot: [true,false,false]),
        MedalListData(rank:3,medalClass:"medal-bike",medalName:"Youbike王",medalTitle:["見習騎士","城市漫遊者","熱血鐵騎仔"],goalCounts: [10,50,100],medalCondition:["騎行達 10 次","騎行達 50 次","騎行達 100 次"],medalReward: [3,6,12],medalRewardGot: [true,false,false]),
        MedalListData(rank:1,medalClass:"medal-bus",medalName:"公車王",medalTitle:["招手攔車","坐在靠窗座","司機都很熟"],goalCounts: [10,50,100],medalCondition:["搭乘達 10 次","搭乘達 50 次","搭乘達 100 次"],medalReward: [3,6,12],medalRewardGot: [false,false,false]),
        MedalListData(rank:2,medalClass:"medal-bus",medalName:"公車王",medalTitle:["招手攔車","坐在靠窗座","司機都很熟"],goalCounts: [10,50,100],medalCondition:["搭乘達 10 次","搭乘達 50 次","搭乘達 100 次"],medalReward: [3,6,12],medalRewardGot: [false,false,false]),
        MedalListData(rank:3,medalClass:"medal-bus",medalName:"公車王",medalTitle:["招手攔車","坐在靠窗座","司機都很熟"],goalCounts: [10,50,100],medalCondition:["搭乘達 10 次","搭乘達 50 次","搭乘達 100 次"],medalReward: [3,6,12],medalRewardGot: [false,false,false]),
        MedalListData(rank:0,medalClass:"medal-bus",medalName:"公車王",medalTitle:["招手攔車","坐在靠窗座","司機都很熟"],goalCounts: [10,50,100],medalCondition:["搭乘達 10 次","搭乘達 50 次","搭乘達 100 次"],medalReward: [3,6,12],medalRewardGot: [false,false,false]),
        
    ]
    func getLeafMethon(Index:Int,rank:Int){
        medalDataArray[Index].medalRewardGot[rank - 1] = true
    }
    
    struct AchivementModalView: View {
        var modalHeader:String=""
        //        var TaskKnowledgeArticle:String=""
        @Binding var showModal:Bool
        func fakeCompleteMethon(fake:Int){
            return
        }
        var completeMethon: (Int,Int) -> Void
        @Binding var achiveModelIndex:Int
        var leaveNum:Int=0
        @Binding var fakeData:[MedalListData]
        var body: some View {
            PopUpModalView(content:{
                switch fakeData[achiveModelIndex].rank{
                case 3:
                    Text("3")
                case 2,1,0:
                    VStack(spacing:0){
                    Image("\(fakeData[achiveModelIndex].medalClass)-\(fakeData[achiveModelIndex].rank)").resizable().scaledToFit().frame(width: 125, height: 125).padding(.bottom,5)
                    Text("\(fakeData[achiveModelIndex].medalTitle[fakeData[achiveModelIndex].rank - 1])").font(.custom("Roboto Bold", size: 14)).tracking(0.56).padding(.bottom,5)

                    Text("\(fakeData[achiveModelIndex].medalCondition[fakeData[achiveModelIndex].rank - 1])").font(.custom("Roboto Regular", size: 14)).tracking(0.56)
                    }.padding(.bottom,10)
                default:Text("@@")
                }
//                VStack(spacing:0){
//                Image("\(fakeData[achiveModelIndex].medalClass)-\(fakeData[achiveModelIndex].rank)").resizable().scaledToFit().frame(width: 125, height: 125).padding(.bottom,5)
//                Text("\(fakeData[achiveModelIndex].medalTitle[fakeData[achiveModelIndex].rank - 1])").font(.custom("Roboto Bold", size: 14)).tracking(0.56).padding(.bottom,5)
//
//                Text("\(fakeData[achiveModelIndex].medalCondition[fakeData[achiveModelIndex].rank - 1])").font(.custom("Roboto Regular", size: 14)).tracking(0.56)
//                }.padding(.bottom,10)
               
                
            },modalHeader:modalHeader,leaveNum:leaveNum,showModal:$showModal,completeMethon:fakeCompleteMethon,achivementCompleteMethon:completeMethon,methonInt:achiveModelIndex,modaltype:.bagdge,
                           achivementFakeData: fakeData)
            
            
        }
    }
    
    @State private var title = "成就"
    private let name = "Achivement"
    @State var data: [Double] = [0,12,1,2,15,13,22]
    @State var labels: [String] = ["0","6","12","18","24"]
    @State var tabTarget: Int = 0
    @State private var showModal:Bool = false;
    @State private var achivementMedalIndex:Int = 0
    private var tabs = ["環保行動","島嶼圖鑑"]
    let accentColor1: Color = Color(red: 18/255, green: 235/255,blue: 196/255)
    let accentColor2: Color = Color(red: 7/255, green: 215/255,blue: 65/255)
    let axisColor: Color = Color.blue
    let showGrid: Bool = true
    let gridColor: Color = Color(red: 204/255, green: 204/255,blue: 204/255)
    let spacing: CGFloat = 15 //條狀圖間隔 15 以下基本上不會跑版 再更大要測試
    var body: some View {
        ZStack{
            VStack{
                Header(title: $title, name: name)
                VStack{
                    ZStack(alignment: .bottom){
                        if tabTarget == 0 {
                            ScrollView(.vertical,showsIndicators:false){
                                VStack(spacing: 18){
                                    
                                    RecordBlock(data:$data,labels: $labels,accentColor1: accentColor1,accentColor2: accentColor2,axisColor: axisColor,showGrid: showGrid,gridColor: gridColor,spacing: spacing)
                                    AchivementBlock(pageNum:medalDataArray.count,medalDataArray:$medalDataArray,showModal:$showModal,achivementMedalIndex:$achivementMedalIndex)
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
            if showModal{
                AchivementModalView(modalHeader:"成就勳章",showModal:$showModal,completeMethon:getLeafMethon,achiveModelIndex: $achivementMedalIndex,leaveNum: medalDataArray[achivementMedalIndex].medalReward[medalDataArray[achivementMedalIndex].rank-1],fakeData: $medalDataArray)
            }
        }
        
    }
}

struct AchivementView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(initSelectedTab: "Achivement")
    }
}





