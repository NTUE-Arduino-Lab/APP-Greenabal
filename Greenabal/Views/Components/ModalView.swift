//
//  ModalView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/25.
//

import SwiftUI

struct RewardItem: View {
    let image: String
    let title: String
    let info: String
    
    var body: some View {
        VStack(spacing: 9){
            Image(image)
                .background(
                    Circle()
                        .fill(Color(red: 0.9458333253860474, green: 0.9458333253860474, blue: 0.9458333253860474))
                        .frame(width: 125, height: 125)
                )
            
            Spacer().frame(height: 7)
            
            Text(title)
                .font(.custom("Roboto Bold", size: 14))
                .tracking(0.56)
            
            Text(info)
                .font(.custom("Roboto Medium", size: 14))
                .tracking(0.56)
        }
    }
}

struct CarouselView<Content: View,T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    var maxCount: Int
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    var width: CGFloat
    
    init(width: CGFloat = 300, spacing: CGFloat = 0, trailingSpace: CGFloat = 100,maxCount: Int, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T) -> Content){
        self.list = []
        for index in 0..<maxCount {
            self.list.append(items[index])
        }
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
        self.width = width
        self.maxCount = maxCount
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: spacing){
                ForEach(list){ item in
                    content(item)
                        .frame(width: width)
                }
            }
            .offset(x: (CGFloat(currentIndex) * -width) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        currentIndex += Int(roundIndex)
                        if currentIndex >= maxCount {
                            currentIndex = maxCount - 1
                        }
                        else if currentIndex < 0 {
                            currentIndex = 0
                        }
                        index = currentIndex
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}

struct ModalButton: View {
    let text: String
    let icon: String
    let action: ()-> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack(alignment:.center, spacing:4){
                Text(text)
                    .font(.custom("Roboto-Bold", size: 14))
                    .foregroundColor(Color.clear)
                    .tracking(0.56)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 0.06906247138977051, green: 0.9208333492279053, blue: 0.7675145268440247, alpha: 1)), location: 0.15625),
                                .init(color: Color(#colorLiteral(red: 0.028055548667907715, green: 0.8416666388511658, blue: 0.2558666467666626, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: -1.3877787807814457e-15, y: -1.3877787807814457e-15),
                            endPoint: UnitPoint(x: 1.000000029802322, y: 1.000000029802322))
                        .mask(
                            Text(text)
                                .font(.custom("Roboto-Bold", size: 14))
                                .tracking(0.56)
                        )
                    )
                
                Image(icon)
            }
            .padding(.vertical,10)
            .padding(.horizontal,18)
            .background(
                RoundedRectangle(cornerRadius: 26)
                    .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.75)))
                    .shadow(color: Color(#colorLiteral(red: 0.0625, green: 0.0625, blue: 0.0625, alpha: 0.15000000596046448)), radius:5, x:0, y:3)
            )
            
        })
    }
}

struct MedalModalContent: View {
    let type: ModalType
    @State var currentIndex: Int = 0
    @EnvironmentObject var modalVM: ModalViewModel
    @EnvironmentObject var badgeVM: BadgeViewModel
    @State var btnText: String = ""
    
    var body: some View {
        VStack{
            if modalVM.medalData.currentStar == 1 {
                RewardItem(image: modalVM.medalData.items[0].image, title: modalVM.medalData.items[0].title, info: modalVM.medalData.items[0].goalDiscription)
            }
            else {
                CarouselView(maxCount: modalVM.medalData.currentStar, index: $currentIndex, items: modalVM.medalData.items)
                {
                    medal in RewardItem(image: medal.image, title: medal.title, info: medal.goalDiscription)
                }
                .frame(width: 300, height: 200)
                .clipped()
            }
            
            if type == .getMedal{
                
                Spacer().frame(height: 17)
                
                Text("下一階段：\(modalVM.medalData.currentCount)/\(modalVM.medalData.items[modalVM.medalData.currentStar].goalCount)次")
                    .font(.custom("Roboto Medium", size: 14))
                    .tracking(0.56)
            }
            else {
                
                Spacer().frame(height: 24)
                
                HStack(spacing: 5){
                ForEach(0..<modalVM.medalData.totalStar, id: \.self){ index in
                    if index == currentIndex {
                        Circle()
                            .fill(LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color(#colorLiteral(red: 0.06906247138977051, green: 0.9208333492279053, blue: 0.7675145268440247, alpha: 1)), location: 0.15625),
                                    .init(color: Color(#colorLiteral(red: 0.028055548667907715, green: 0.8416666388511658, blue: 0.2558666467666626, alpha: 1)), location: 1)]),
                                startPoint: UnitPoint(x: -1.3877787807814457e-15, y: -1.3877787807814457e-15),
                                endPoint: UnitPoint(x: 1.000000029802322, y: 1.000000029802322)))
                        .frame(width: 5, height: 5)}
                    else{
                        Circle()
                            .fill(Color(red: 0.9019607901573181, green: 0.9019607901573181, blue: 0.9019607901573181))
                            .frame(width: 5, height: 5)
                    }
                }
            }
            }
        }
        .padding(.top, 10)
        
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(red: 241/255, green: 241/255, blue: 241/255))
            .frame(width: 300,height: 1)
        
        ModalButton(text: "\(modalVM.medalData.items[currentIndex].goalCount)", icon: "icon_leaf_green", action: BtnAction)
    }
    
    func BtnAction(){
        badgeVM.GetReward(name: modalVM.medalData.name, star: modalVM.medalData.currentStar)
        modalVM.hideModal()
    }
}

struct GiftModalContent: View {
    @EnvironmentObject var modalVM: ModalViewModel
    @EnvironmentObject var barcodeVM: BarcodeListViewModel
    
    var body: some View {
        VStack{
            
            if modalVM.buyData.gift is GiftIsland {
                let gift: GiftIsland = modalVM.buyData.gift as! GiftIsland
                RewardItem(image: "icon_big_gift", title: "購買\(modalVM.buyData.seal)商品", info: "獲得\(gift.type.rawValue)")
            }
            else if modalVM.buyData.gift is GiftLeaf {
                let gift: GiftLeaf = modalVM.buyData.gift as! GiftLeaf
                RewardItem(image: "icon_big_gift", title: "購買\(modalVM.buyData.seal)商品", info: "獲得 \(gift.leaf) 片葉子")
            }
            
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(red: 241/255, green: 241/255, blue: 241/255))
            .frame(width: 300,height: 1)
        
        if modalVM.buyData.gift is GiftIsland {
            ModalButton(text: "稀有島嶼", icon: "icon_gift_ticket", action: BtnAction)
        }
        else if modalVM.buyData.gift is GiftLeaf {
            let item: GiftLeaf = modalVM.buyData.gift as! GiftLeaf
            ModalButton(text: "\(item.leaf)", icon: "icon_leaf_green", action: BtnAction)
        }
    }
    
    func BtnAction(){
        barcodeVM.OpenGift(item: modalVM.buyData)
        modalVM.hideModal()
    }
}

enum ModalType: String{
    case knowledge = "環保知識"
    case medal = "成就勳章"
    case gift = "獲得寶箱"
    case getMedal = "獲得成就"
}

struct ModalView: View {
    let type: ModalType
    @Binding var show: Bool
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.black)
                .opacity(0.3)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    show = !show
                }
            
            VStack(spacing: 16){
                Text(type != .knowledge ? type.rawValue : "aaa")
                    .font(.custom("Roboto Bold", size: 16))
                    .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12))
                    .tracking(0.64)
                    .frame(height: 36,alignment: .bottom)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 241/255, green: 241/255, blue: 241/255))
                    .frame(width: 300,height: 1)
                
                if type == .gift{
                    GiftModalContent()
                }
                else if type == .medal {
                    MedalModalContent(type: .medal)
                }
                else if type == .getMedal {
                    MedalModalContent(type: .getMedal)
                }

                
            }
            .frame(alignment: .top)
            .padding(.bottom,20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

struct ModalView_Previews: PreviewProvider {
    static var leafVM: LeafViewModel = LeafViewModel()
    static var modalVM: ModalViewModel = ModalViewModel()
    @State static var show: Bool = true
    @State var badgeVM: BadgeViewModel = BadgeViewModel(leafVM: leafVM,modalVM: modalVM)
    
    static var previews: some View {
        ModalView(type: .medal, show: $show)
            .environmentObject(modalVM)
    }
}
