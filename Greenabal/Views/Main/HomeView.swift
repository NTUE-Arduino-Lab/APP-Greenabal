//
//  HomeView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

import SpriteKit

class ShotScene: SKScene {
    @Binding var isShotting: Bool
    @Binding var shot: Bool
    
    var shotBtn: SKSpriteNode!
    var returnBtn: SKSpriteNode!
    
    init(isShotting: Binding<Bool>,shot: Binding<Bool>){
        _isShotting = isShotting
        _shot = shot
        super.init(size: CGSize(width: 375, height: 812))
        self.scaleMode = .aspectFill
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder: ) is not supported")
    }
    
    private func setupBtn(){
        shotBtn = SKSpriteNode(imageNamed: "icon_shot2")
        shotBtn.name = "ShotBtn"
        shotBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shotBtn.position = CGPoint(x: 0 , y: -220 )
        
        returnBtn = SKSpriteNode(imageNamed: "icon_return")
        returnBtn.name = "ReturnBtn"
        returnBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        returnBtn.position = CGPoint(x: 100 , y: -220 )
        
        addChild(shotBtn)
        addChild(returnBtn)
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        view.allowsTransparency = true
        
        setupBtn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "ShotBtn" && !isShotting{
                isShotting = true
            }
            else if touchedNode.name == "ReturnBtn" && shot{
                shot = false
            }
        }
    }
}

struct DefaultHomeInterfaceView: View {
    @EnvironmentObject var leafVM: LeafViewModel
    @EnvironmentObject var backgroundVM: BackgroundViewModel
    @EnvironmentObject var islandVM: IslandViewModel
    
    @Binding var shot: Bool
    var updateIsland: () -> Void
    
    var body: some View {
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
                
                Button(action: {
                    withAnimation {
                        shot = true
                    }
                }, label: {
                    Image(backgroundVM.state == .morning ? "icon_shot_black" : "icon_shot")
                })
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
                    updateIsland()
                }, label: {
                    HStack(alignment:.center, spacing: 2){
                        Text("升級島嶼 \( islandVM.currentIsland.getLevelLeaf())")
                            .foregroundColor(Color("gray-300"))
                            .font(.custom("Roboto Medium", size: 14))
                            .tracking(0.64)
                        Image("icon_leaf_gray")
                    }
                })
                .disabled(leafVM.count >= islandVM.currentIsland.getLevelLeaf() && islandVM.currentIsland.currentLevel <= islandVM.currentIsland.totalLevel - 1 ? false : true)
                .buttonStyle(.borderless)
                .frame(width: 143, height: 36)
                .background(RoundedRectangle(cornerRadius: 26).fill(Color("gray-200")))
            }
            .padding(.bottom, 210)
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .top)
        .padding(.horizontal,16)
    }
}

struct HomeView: View {
    @EnvironmentObject var backgroundVM: BackgroundViewModel
    @EnvironmentObject var islandVM: IslandViewModel
    @State private var title = "No.168 初來乍島 Lv.3"
    private let name = "Home"
    @State private var islandColor: Color = Color.white
    @State private var maskColor: Color = Color.white
    
    @State var image: UIImage! = nil
    @State private var rect: CGRect = .zero
    
    @State var isShotting: Bool = false
    
    @Binding var shot: Bool
    
    @StateObject private var scene: GameScene =  {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .aspectFill
        return scene
    }()
    
    private var sceneShot: ShotScene {
        let scene = ShotScene(isShotting: $isShotting,shot: $shot)
        scene.size = CGSize(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
        return scene
    }
    
    var body: some View {
        
        VStack{
            
            if !shot {
                Header(title: $title, name: name)
                    .foregroundColor(backgroundVM.state == .morning ? Color("black-font") : Color.white).transition(.opacity)
            }
            
            ZStack{
                ZStack{
                    SpriteView(scene: self.scene , options: [.allowsTransparency])
                    
                    if shot {
                        SpriteView(scene: self.sceneShot , options: [.allowsTransparency])
                    }
                }
                .padding(.top , shot ? 105 : 0)
                .onAppear{
                    islandColor = backgroundVM.maskColors.0
                    scene.maskColor = UIColor(islandColor)
                    scene.colorDuration = backgroundVM.duration
                }
                .onChange(of: backgroundVM.canAnimate, perform: { newValue in
                    if backgroundVM.canAnimate {
                        withAnimation(.linear(duration: backgroundVM.duration)) {
                            islandColor = backgroundVM.maskColors.1
                        }
                    }
                })
                .onChange(of: islandColor, perform: { newValue in
                    scene.updateMaskColor(color: UIColor(newValue))
                })
                
                if !shot {
                    DefaultHomeInterfaceView(shot: $shot, updateIsland: updateIsland).transition(.opacity)
                }
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
        }
        .foregroundColor(.white)
        .onAppear(){
            scene.level = islandVM.currentIsland.currentLevel
            changeTitle()
        }
        .background(RectGetter(rect: $rect))
        .onChange(of: isShotting, perform: { newValue in
            takeScreenshot()
            isShotting = false
        })
    }
    
    func updateIsland(){
        islandVM.updateIsland()
        changeTitle()
        scene.updateLevel(level: islandVM.currentIsland.currentLevel)
    }
    
    func changeTitle(){
        title = "No.\(islandVM.currentIsland.number) 初來乍島 Lv.\(islandVM.currentIsland.currentLevel)"
    }
    
    func saveAndShare(img: UIImage) {
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let filePath = "\(rootPath)/share.png"
        let imageData = img.pngData()
        fileManager.createFile(atPath: filePath, contents: imageData)
        let url:URL = URL.init(fileURLWithPath: filePath)
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        let keyWindow = UIApplication.shared.connectedScenes
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows.first
        
        keyWindow?.rootViewController!.present(av, animated: true)
    }
    
    func takeScreenshot() {
        var bounds = scene.view?.bounds
        
        bounds = CGRect(x: 0, y: 105, width: bounds!.width, height: bounds!.height)
        
        let keyWindow = UIApplication.shared.connectedScenes
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows.first
        
        image = keyWindow?.rootViewController?.view.asImage(rect: rect)
        
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, true, UIScreen.main.scale)
        
        image.draw(at: CGPoint(x: 0, y: 0))
        
        scene.view?.drawHierarchy(in: bounds!, afterScreenUpdates: false)
        
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        image = screenshot
        
        saveAndShare(img: image)
    }
}

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

struct RectGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }
    
    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }
        
        return Rectangle().fill(Color.clear)
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
