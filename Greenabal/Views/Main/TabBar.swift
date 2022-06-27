//
//  TabBar.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var modalVM: ModalViewModel
    @State private var selectedTab: String = "Home"
    @State var shot: Bool = false
    
    init(initSelectedTab: String = "Home"){
        if initSelectedTab != "Home" {
            _selectedTab = State(initialValue: initSelectedTab)
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            Group{
                switch selectedTab {
                case "Home":
                    HomeView(shot: $shot)
                case "Action":
                    ActionView()
                case "Task":
                    TaskView()
                case "Achivement":
                    AchivementView()
                case "Setting":
                    SettingView()
                default:
                    HomeView(shot: $shot)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if !shot {
                ZStack(alignment: .top){
                    RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: 94
                    )
                    .shadow(color: Color(#colorLiteral(red: 0.7372549176216125, green: 0.7372549176216125, blue: 0.7372549176216125, alpha: 0.25)), radius:4, x:0, y:-4)
                    
                    HStack{
                        ForEach(Tab.all){ tab in
                            Button{
                                selectedTab = tab.name
                            } label: {
                                selectedTab == tab.name ?
                                Image(tab.selectedImage) : Image(tab.image)
                            }.frame(maxWidth: .infinity)
                        }
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: 60
                    )
                }.transition(.opacity)
            }
            
            if modalVM.show {
                ModalView(type: modalVM.type,show: $modalVM.show)
            }
            
            if modalVM.showSmall {
                GeometryReader { geometry in
                    LeafModalView()
                        .position(x: geometry.size.width / 2, y: 55)
                        .transition(.opacity)
                }
            }
        }
        .edgesIgnoringSafeArea(!shot ? .bottom : [.top,.bottom])
    }
}

struct TabBar_Previews: PreviewProvider {
    static let modalVM = ModalViewModel()
    static var leafVM: LeafViewModel = LeafViewModel(mvm: modalVM)
    static let backgroundVM = BackgroundViewModel()
    static var islandVM = IslandViewModel(leafVM: leafVM)
    
    static var previews: some View {
        TabBar()
            .environmentObject(leafVM)
            .environmentObject(backgroundVM)
            .environmentObject(islandVM)
            .environmentObject(modalVM)
    }
}
