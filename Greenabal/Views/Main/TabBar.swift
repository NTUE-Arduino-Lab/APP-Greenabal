//
//  TabBar.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct TabItem: Identifiable{
    var id = UUID()
    var name: String
    var image: String
    var selectedImage: String
}

var tabItems = [
    TabItem(name: "Setting", image: "icon_setting", selectedImage: "icon_setting_active"),
    TabItem(name: "Action", image: "icon_action", selectedImage: "icon_action_active"),
    TabItem(name: "Home", image: "icon_home", selectedImage: "icon_home_active"),
    TabItem(name: "Task", image: "icon_task", selectedImage: "icon_task_active"),
    TabItem(name: "Achivement", image: "icon_achivement", selectedImage: "icon_achivement_active")
]

struct TabBar: View {
    @State private var selectedTab = "Home"
    
    var body: some View {
        ZStack(alignment: .bottom){
            Group{
                switch selectedTab {
                case "Home":
                    HomeView()
                case "Action":
                    ActionView()
                    .clipped()
                case "Task":
                    TaskView()
                    .clipped()
                case "Achivement":
                    AchivementView()
                    .clipped()
                case "Setting":
                    SettingView()
                    .clipped()
                default:
                    HomeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 94
                )
                .shadow(color: Color(#colorLiteral(red: 0.7372549176216125, green: 0.7372549176216125, blue: 0.7372549176216125, alpha: 0.25)), radius:4, x:0, y:-4)
                
                HStack{
                    ForEach(tabItems){ item in
                        Button{
                            selectedTab = item.name
                        } label: {
                            selectedTab == item.name ?
                            Image(item.selectedImage) : Image(item.image)
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
    static var previews: some View {
        TabBar()
    }
}
