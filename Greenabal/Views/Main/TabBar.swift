//
//  TabBar.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab: String = "Home"
    
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
                    HomeView()
                case "Action":
                    ActionView()
                case "Task":
                    TaskView()
                case "Achivement":
                    AchivementView()
                case "Setting":
                    SettingView()
                default:
                    HomeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
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
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabBar_Previews: PreviewProvider {
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
