//
//  HomeView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

import SpriteKit

class GameScene: SKScene, ObservableObject {
    @Published var level: Int = 1
    
    var island: SKSpriteNode!
    
    private var islandAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Island")
    }
    
    private var islandTexture: SKTexture {
        return islandAtlas.textureNamed("Island_L\(level)")
    }
    
    
    private var islandIdleTextures: [SKTexture] {
        return [
            islandAtlas.textureNamed("Island_L\(level)"),
            islandAtlas.textureNamed("Island_L\(level)")
        ]
    }
    
    private func setupIsland() {
        island = SKSpriteNode(texture: islandTexture)
        
        island.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        island.size.width = CGFloat(380)
        island.size.height = CGFloat(380)
        island.position = CGPoint(x: 0 , y: 80 )
        
        addChild(island)
    }
    
    func startIdleAnimation() {
        let idleAnimation = SKAction.animate(with: islandIdleTextures, timePerFrame: 0.05)
        
        island.run(SKAction.repeatForever(idleAnimation), withKey: "playerIdleAnimation")
    }
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .clear
        view.allowsTransparency = true
        
        setupIsland()
        startIdleAnimation()
    }
    
    func setLevel(level: Int){
        self.level = level
        setupIsland()
        startIdleAnimation()
    }
}

struct HomeView: View {
    @EnvironmentObject var backgroundVM: BackgroundViewModel
    @EnvironmentObject var leafVM: LeafViewModel
    @EnvironmentObject var islandVM: IslandViewModel
    @State private var title = "No.168 初來乍島 Lv.3"
    private let name = "Home"
    @State private var islandColor: Color = Color.red
    @State private var maskColor: Color = Color.white
    
    @StateObject private var scene: GameScene =  {
        let scene = GameScene()
        scene.size = CGSize(width: 375, height: 812)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .aspectFill
        return scene
    }()
    
    var body: some View {
        
        VStack{
            Header(title: $title, name: name)
                .foregroundColor(backgroundVM.state == .morning ? Color("black-font") : Color.white)
            
            ZStack{
                SpriteView(scene: self.scene , options: [.allowsTransparency])
                    .colorMultiply(islandColor)
                    .onAppear{
                        islandColor = backgroundVM.maskColors.0
                    }
                    .onChange(of: backgroundVM.canAnimate, perform: { newValue in
                        if backgroundVM.canAnimate {
                            withAnimation(.linear(duration: backgroundVM.duration)) {
                                islandColor = backgroundVM.maskColors.1
                            }
                        }
                    })
                
                VStack{
                    HStack(alignment: .center){
                        Image(backgroundVM.state == .morning ? "leaf_count_bg_black" : "leaf_count_bg_white")
                            .overlay(
                                Text("\(leafVM.count)")
                                    .font(.custom("Roboto Bold", size: 14))
                                    .tracking(1.2)
                                    .position(x: 60, y: 25)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(backgroundVM.state == .morning ? Color("black-font") : Color.white)
                            )
                        
                        Rectangle()
                            .fill(Color.clear)
                        
                        Image(backgroundVM.state == .morning ? "icon_shot_black" : "icon_shot")
                    }
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 12){
                        HStack(spacing: 3){
                            Text("\(leafVM.autoIncreseCount)")
                                .font(.custom("Roboto Medium", size: 14))
                                .tracking(0.56)
                            Image(backgroundVM.state == .morning ? "icon_leaf_black" : "icon_leaf_white")
                            Text(" / hr")
                                .font(.custom("Roboto Medium", size: 14))
                                .tracking(0.56)
                        }
                        .foregroundColor(backgroundVM.state == .morning ? Color("black-font") : Color.white)
                        
                        Button(action: {
                            islandVM.updateIsland()
                            changeTitle()
                            scene.setLevel(level: islandVM.currentIsland.currentLevel)
                        }, label: {
                            HStack(alignment:.center, spacing: 2){
                                Text("升級島嶼 \( islandVM.currentIsland.getLevelLeaf())")
                                    .foregroundColor(Color("gray-300"))
                                    .font(.custom("Roboto Medium", size: 14))
                                    .tracking(0.64)
                                Image("icon_leaf_gray")
                            }
                        })
                        .disabled(leafVM.count >= islandVM.currentIsland.getLevelLeaf() ? false : true)
                        .buttonStyle(.borderless)
                        .frame(width: 143, height: 36)
                        .background(RoundedRectangle(cornerRadius: 26).fill(Color("gray-200")))
                    }
                    .padding(.bottom, 210)
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
        .foregroundColor(.white)
        .onAppear(){
            scene.setLevel(level: islandVM.currentIsland.currentLevel)
            changeTitle()
        }
    }
    
    func changeTitle(){
        title = "No.\(islandVM.currentIsland.number) 初來乍島 Lv.\(islandVM.currentIsland.currentLevel)"
    }
}

struct HomeView_Previews: PreviewProvider {
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
