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

struct ModalButton: View {
    let text: String
    let icon: String
    let action: ()-> Void
    @Binding var disabled: Bool
    
    var body: some View {
        Button(action: {
            if !disabled{
                action()
            }
        }, label: {
            HStack(alignment:.center, spacing:4){
                Text(text)
                    .font(.custom("Roboto-Bold", size: 14))
                    .foregroundColor(Color.clear)
                    .tracking(0.56)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: !disabled ? Color(#colorLiteral(red: 0.06906247138977051, green: 0.9208333492279053, blue: 0.7675145268440247, alpha: 1)) : Color("gray-500"), location: 0.15625),
                                .init(color: !disabled ? Color(#colorLiteral(red: 0.028055548667907715, green: 0.8416666388511658, blue: 0.2558666467666626, alpha: 1)) : Color("gray-500"), location: 1)]),
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
            .disabled(disabled)
            .padding(.vertical,10)
            .padding(.horizontal,18)
            .frame(minWidth: 90)
            .background(
                RoundedRectangle(cornerRadius: 26)
                    .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.75)))
                    .shadow(color: Color(#colorLiteral(red: 0.0625, green: 0.0625, blue: 0.0625, alpha: 0.15000000596046448)), radius:5, x:0, y:3)
            )
            
        })
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
                Text(type != .knowledge ? type.rawValue : "為什麼要用環保吸管？")
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
                else if type == .knowledge {
                    KnowledgeModalContent(content: "環保署統計臺灣每年塑膠吸管使用量約30億根，在這樣大量使用及其方便又隨手可得的情況下，造成龐大且難處理的塑膠垃圾，更是在淨灘廢棄物中排名前5名，可想而知也影響到了海洋生態，曾經有影片紀錄從海龜的呼吸道中拔出長長的吸管，想到就覺得好痛！\n\n目前環保署已有管制實施，但我們可以自動落實，大家可以尋找自己喜歡的環保吸管，與環保餐具一起帶出門，保護我們的生活環境也救救海龜！")
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
