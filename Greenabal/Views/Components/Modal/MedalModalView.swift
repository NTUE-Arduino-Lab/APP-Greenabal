//
//  MedalModalView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/26.
//

import SwiftUI

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

struct MedalModalContent: View {
    let type: ModalType
    @State var currentIndex: Int = 0
    @EnvironmentObject var modalVM: ModalViewModel
    @EnvironmentObject var badgeVM: BadgeViewModel
    @State var btnText: String = ""
    @State var btnDisabled: Bool = false
    
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
                ForEach(0..<modalVM.medalData.currentStar, id: \.self){ index in
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
        
        ModalButton(text: "\(modalVM.medalData.items[currentIndex].goalCount)", icon: !btnDisabled ? "icon_leaf_green" : "icon-leaf-gray-2", action: BtnAction, disabled: $btnDisabled)
            .onChange(of: modalVM.medalData.items[currentIndex].getLeafState, perform: { newValue in
                btnDisabled = newValue
            })
            .onAppear(){
                btnDisabled = modalVM.medalData.items[currentIndex].getLeafState
            }
    }
    
    func BtnAction(){
        badgeVM.GetReward(name: modalVM.medalData.name, star: currentIndex + 1)
//        modalVM.hideModal()
        btnDisabled = true
    }
}

struct MedalModalView_Previews: PreviewProvider {
    static var modalVM: ModalViewModel = ModalViewModel()
    static var leafVM: LeafViewModel = LeafViewModel(mvm: modalVM)
    @State static var show: Bool = true
    @State var badgeVM: BadgeViewModel = BadgeViewModel(leafVM: leafVM,modalVM: modalVM)
    
    static var previews: some View {
        ModalView(type: .medal, show: $show)
            .environmentObject(modalVM)
    }
}
