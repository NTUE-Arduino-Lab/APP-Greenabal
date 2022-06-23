//
//  HomeView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

import SpriteKit

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

struct HomeView: View {
    @EnvironmentObject var backgroundVM: BackgroundViewModel
    @EnvironmentObject var leafVM: LeafViewModel
    @EnvironmentObject var islandVM: IslandViewModel
    @State private var title = "No.168 初來乍島 Lv.3"
    private let name = "Home"
    @State private var islandColor: Color = Color.white
    @State private var maskColor: Color = Color.white
    
    @State private var image: UIImage! = nil
    @State private var rect: CGRect = .zero
    
    @State private var shot: Bool = false
    
    @StateObject private var scene: GameScene =  {
        let scene = GameScene()
        scene.size = CGSize(width: 375, height: 812)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .aspectFill
        return scene
    }()
    
    @StateObject private var sceneCloud: CloudScene =  {
        let scene = CloudScene()
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
                ZStack{
                    SpriteView(scene: self.sceneCloud , options: [.allowsTransparency])
                    
                    SpriteView(scene: self.scene , options: [.allowsTransparency])
                }
                .padding(.top, shot ? 50 : 0)
                .onAppear{
                    islandColor = backgroundVM.maskColors.0
                    scene.maskColor = UIColor(islandColor)
                    scene.colorDuration = backgroundVM.duration
                    sceneCloud.maskColor = UIColor(islandColor)
                    sceneCloud.colorDuration = backgroundVM.duration
                }
                .onChange(of: backgroundVM.canAnimate, perform: { newValue in
                    if backgroundVM.canAnimate {
                        withAnimation(.linear(duration: backgroundVM.duration)) {
                            islandColor = backgroundVM.maskColors.1                                }
                    }
                })
                .onChange(of: islandColor, perform: { newValue in
                    scene.updateMaskColor(color: UIColor(newValue))
                    sceneCloud.updateMaskColor(color: UIColor(newValue))
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
                            //                            islandVM.updateIsland()
                            //                            changeTitle()
                            //                            scene.updateLevel(level: islandVM.currentIsland.currentLevel)
                            self.image = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: self.rect)
                            if image != nil {
                                takeScreenshot()
                                saveAndShare(img: image!)
                            }
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
            scene.level = islandVM.currentIsland.currentLevel
            changeTitle()
        }
        .background(RectGetter(rect: $rect))
        .if(shot) { view in
            view.edgesIgnoringSafeArea(.vertical)
        }
    }
    
    func changeTitle(){
        title = "No.\(islandVM.currentIsland.number) 初來乍島 Lv.\(islandVM.currentIsland.currentLevel)"
    }
    
    func saveAndShare(img: UIImage) {
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let filePath = "\(rootPath)/share.jpg"
        let imageData = img.pngData()
        fileManager.createFile(atPath: filePath, contents: imageData)
        let url:URL = URL.init(fileURLWithPath: filePath)
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(av, animated: true)
    }
    
    func takeScreenshot() {
        let bounds = scene.view?.bounds
        let boundsCloud = sceneCloud.view?.bounds
        
        UIGraphicsBeginImageContextWithOptions(image.size, true, UIScreen.main.scale)
        
        image.draw(at: CGPoint(x: 0, y: 0))
        
        sceneCloud.view?.drawHierarchy(in: boundsCloud!, afterScreenUpdates: true)
        scene.view?.drawHierarchy(in: bounds!, afterScreenUpdates: true)
        
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        image = screenshot
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
