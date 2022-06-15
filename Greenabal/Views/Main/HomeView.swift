//
//  HomeView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .clear
        view.allowsTransparency = true
        
        print("You are in the game scene!")
        let spriteImg = SKSpriteNode(imageNamed: "island")
        spriteImg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        spriteImg.size.width = CGFloat(125)
        spriteImg.size.height = CGFloat(125)
        spriteImg.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2 + 20 )
        self.addChild(spriteImg)
        
        print(self.size.height)
    }
}

struct HomeView: View {
    @EnvironmentObject var backgroundViewModel: BackgroundViewModel
    @EnvironmentObject var leafViewModel: LeafViewModel
    private let title = "No.168 初來乍島 Lv.3"
    private let name = "Home"
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 216, height: 216)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        
        VStack{
            Header(title: title, name: name)
            
            ZStack{
                SpriteView(scene: self.scene , options: [.allowsTransparency])
                
                VStack{
                    HStack(alignment: .center){
                        Image("LeafCountBG")
                            .overlay(
                                Text("\(leafViewModel.count)")
                                    .font(.custom("Roboto Bold", size: 14))
                                    .tracking(1.2)
                                    .position(x: 60, y: 25)
                                    .multilineTextAlignment(.center)
                            )
                        
                        Rectangle()
                            .fill(Color.clear)
                        
                        Image("icon_shot")
                    }
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 12){
                        HStack(spacing: 3){
                            Text("\(leafViewModel.autoIncreseCount)")
                                .font(.custom("Roboto Medium", size: 14))
                                .tracking(0.56)
                            Image("icon_leaf_white")
                            Text("/ hr")
                                .font(.custom("Roboto Medium", size: 14))
                                .tracking(0.56)
                        }
                        
                        Button(action: {
                        }, label: {
                            HStack(alignment:.center, spacing: 2){
                                Text("升級島嶼 500")
                                    .foregroundColor(Color("gray-300"))
                                    .font(.custom("Roboto Medium", size: 14))
                                    .tracking(0.64)
                                Image("icon_leaf_gray")
                            }
                        })
                        .buttonStyle(.borderless)
                        .frame(width: 143, height: 36)
                        .background(RoundedRectangle(cornerRadius: 26).fill(Color.white))
                        
                    }
                    .padding(.bottom, 174)
                }
                .padding(.horizontal,16)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .top)
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .background(backgroundViewModel.color)
        .foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static let backgroundViewModel = BackgroundViewModel()
    static let leafViewModel = LeafViewModel()
    
    static var previews: some View {
        TabBar()
            .environmentObject(leafViewModel)
            .environmentObject(backgroundViewModel)
    }
}
