//
//  GameScene.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/23.
//

import SpriteKit

class GameScene: SKScene, ObservableObject {
    @Published var level: Int = 1
    @Published var maskColor: UIColor = UIColor.white
    @Published var colorDuration: CGFloat = 0.5
    let islandIdleImageCount: [Int] = [1,1,1,1,2]
    let islandUpgradeImageCount: [Int] = [2,2,2,8]
    let timePerFrame:TimeInterval = 0.2
    
    var island: SKSpriteNode!
    var mask: SKSpriteNode!
    
    private var islandAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Island")
    }
    
    private var islandTexture: SKTexture {
        return islandAtlas.textureNamed("Island_Idle_L\(level)_0")
    }
    
    private var islandIdleTextures: [SKTexture] {
        var textures: [SKTexture] = []
        for index in 0..<islandIdleImageCount[level-1] {
            textures.append(islandAtlas.textureNamed("Island_Idle_L\(level)_\(index)"))
        }
        return textures
    }
    
    private var islandUpgradeTextures: [SKTexture] {
        var textures: [SKTexture] = []
        for index in 0..<islandUpgradeImageCount[level-1] {
            textures.append(islandAtlas.textureNamed("Island_Upgrade_L\(level+1)_\(index)"))
        }
        return textures
    }
    
    private func setupIsland(){
        island = SKSpriteNode(texture: islandTexture)
        
        island.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        island.size.width = CGFloat(380)
        island.size.height = CGFloat(380)
        island.position = CGPoint(x: 0 , y: 0 )
        
        mask = SKSpriteNode(color: maskColor, size: island.size)
        mask.anchorPoint = island.anchorPoint
        mask.position =  CGPoint(x: 0 , y: 70 )
    }
    
    func idleAnimation() -> SKAction{
        let idleAnimation = SKAction.animate(with: islandIdleTextures, timePerFrame: timePerFrame)
        return SKAction.repeatForever(idleAnimation)
    }
    
    func upgradeAnimation() -> SKAction{
        let upgradeAnimation = SKAction.animate(with: islandUpgradeTextures, timePerFrame: timePerFrame)
        return upgradeAnimation
    }
    
    func runAnimation(actions: [SKAction]){
        let sequence = SKAction.sequence(actions)
        island.run(sequence)
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        view.allowsTransparency = true
        
        setupIsland()
        island.blendMode = .multiply
        //        addChild(island)

        mask.addChild(island)
        
        addChild(mask)
        
        let idleAnimation = idleAnimation()
        runAnimation(actions:[idleAnimation])
    }
    
    func updateLevel(level: Int){
        let upgradeAnimation = upgradeAnimation()
        self.level = level
        let idleAnimation = idleAnimation()
        runAnimation(actions:[upgradeAnimation,idleAnimation])
    }
    
    func updateMaskColor(color: UIColor){
        if mask != nil{
            maskColor = color
            let action = SKAction.colorize(with: color, colorBlendFactor: 1, duration: colorDuration)
                        mask.run(action)
        }
    }
}

class CloudScene: SKScene, ObservableObject {
    @Published var maskColor: UIColor = UIColor.white
    @Published var colorDuration: CGFloat = 0.5
    let timePerFrame:TimeInterval = 0.2
    
    var cloud: SKSpriteNode!
    var mask: SKSpriteNode!
    
    private var cloudAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Cloud")
    }
    
    private var cloudTexture: SKTexture {
        return cloudAtlas.textureNamed("cloud_1")
    }
    
    private var cloudIdleTextures: [SKTexture] {
        var textures: [SKTexture] = []
        for index in 0..<21 {
            textures.append(cloudAtlas.textureNamed("cloud_\(index+1)"))
        }
        return textures
    }
    
    private func setupCloud(){
        cloud = SKSpriteNode(texture: cloudTexture)
        
        cloud.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        cloud.size.width = CGFloat(375)
        cloud.size.height = CGFloat(666.67)
        cloud.position = CGPoint(x: 0 , y: 0 )
        
        mask = SKSpriteNode(color: maskColor, size: cloud.size)
        mask.anchorPoint = cloud.anchorPoint
        mask.position =  CGPoint(x: 0 , y: 90 )
    }
    
    func cloudIdleAnimation() -> SKAction{
        let idleAnimation = SKAction.animate(with: cloudIdleTextures, timePerFrame: timePerFrame*1.25)
        return SKAction.repeatForever(idleAnimation)
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        view.allowsTransparency = true
        
        setupCloud()
        cloud.blendMode = .multiply
        //        addChild(cloud)
        let cloudIdleAnimation = cloudIdleAnimation()
        cloud.run(cloudIdleAnimation)
        
        mask.addChild(cloud)
        
        addChild(mask)
    }
    
    func updateMaskColor(color: UIColor){
        if mask != nil{
            maskColor = color
            let action = SKAction.colorize(with: color, colorBlendFactor: 1, duration: colorDuration)
            mask.run(action)
        }
    }
}
