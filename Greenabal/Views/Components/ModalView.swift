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
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    var width: CGFloat
    
    init(width: CGFloat = 300, spacing: CGFloat = 0, trailingSpace: CGFloat = 100, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T) -> Content){
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
        self.width = width
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
                        if currentIndex >= 3 {
                            currentIndex = 2
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

struct Post: Identifiable {
    var id = UUID().uuidString
    var postImage: String
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
    @State var currentIndex: Int = 0
    @Binding var posts: [Post]
    
    var body: some View {
        VStack{
            CarouselView(index: $currentIndex, items: posts)
            {
                post in RewardItem(image: "medal-bike-1", title: "城市自遊俠", info: "騎行達10次")
            }
            .frame(width: 300, height: 200)
            .clipped()
            
            Spacer().frame(height: 24)
            
            HStack(spacing: 5){
                ForEach(posts.indices, id: \.self){ index in
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
        .padding(.top, 10)
    }
}

struct GiftModalContent: View {
    let title: String
    let info: String
    
    var body: some View {
        VStack{
            RewardItem(image: "icon_big_gift", title: title, info: info)
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
}

enum ModalType: String{
    case knowledge = "環保知識"
    case medal = "成就勳章"
    case gift = "獲得寶箱"
}

struct ModalView: View {
    let type: ModalType
    @Binding var show: Bool
    @State var posts: [Post] = []
    
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
                    GiftModalContent(title: "購買環保標章商品", info: "獲得稀有島嶼兌換卷")
                }
                else if type == .medal {
                    MedalModalContent(posts: $posts)
                        .onAppear{
                            for index in 1...3{
                                posts.append(Post(postImage: "medal-bike-\(index)"))
                            }
                        }
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 241/255, green: 241/255, blue: 241/255))
                    .frame(width: 300,height: 1)
                
                ModalButton(text: "稀有島嶼", icon: "icon_gift_ticket", action: GiftBtnAction)
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
    
    func MedalBtnAction(){
        print("medal action")
    }
    
    func GiftBtnAction(){
        print("gift action")
    }
}

struct ModalView_Previews: PreviewProvider {
    static let leafVM = LeafViewModel()
    static let backgroundVM = BackgroundViewModel()
    static var islandVM = IslandViewModel(leafVM: leafVM)
    
    static var previews: some View {
        TabBar()
            .environmentObject(leafVM)
            .environmentObject(backgroundVM)
            .environmentObject(islandVM)
    }
}
