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
    let timePerFrame:TimeInterval = 0.225
    
    var island: SKSpriteNode!
    var mask: SKSpriteNode!
    
    var cloud: SKSpriteNode!
    var maskCloud: SKSpriteNode!
    
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
        island.size.width = CGFloat(self.size.width)
        island.size.height = CGFloat(self.size.width)
        island.position = CGPoint(x: 0 , y: 0 )
        
        mask = SKSpriteNode(color: maskColor, size: self.size)
        mask.anchorPoint = island.anchorPoint
        mask.position =  CGPoint(x: 0 , y: 0 )
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
        cloud.size.width = CGFloat(self.size.width)
        cloud.size.height = CGFloat(self.size.height)
        cloud.position = CGPoint(x: 0 , y: 0 )
        
        maskCloud = SKSpriteNode(color: maskColor, size: self.size)
        maskCloud.anchorPoint = island.anchorPoint
        maskCloud.position =  CGPoint(x: 0 , y: 0 )
    }
    
    func cloudIdleAnimation() -> SKAction{
        let idleAnimation = SKAction.animate(with: cloudIdleTextures, timePerFrame: timePerFrame*1.25)
        return SKAction.repeatForever(idleAnimation)
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        view.allowsTransparency = true
        
        setupIsland()
        island.blendMode = .multiply
        
        setupCloud()
        cloud.blendMode = .multiply
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 70)
        cropNode.maskNode = island
        cropNode.addChild(mask)
        cropNode.addChild(island)
        
        let cropNodeCloud = SKCropNode()
        cropNodeCloud.position = CGPoint(x: 0, y: 90)
        cropNodeCloud.maskNode = cloud
        cropNodeCloud.addChild(maskCloud)
        cropNodeCloud.addChild(cloud)
        
        let idleAnimation = idleAnimation()
        runAnimation(actions:[idleAnimation])
        
        let cloudIdleAnimation = cloudIdleAnimation()
        cloud.run(cloudIdleAnimation)
        
        addChild(cropNodeCloud)
        addChild(cropNode)
    }
    
    func updateLevel(level: Int){
        let upgradeAnimation = upgradeAnimation()
        self.level = level
        let idleAnimation = idleAnimation()
        runAnimation(actions:[upgradeAnimation,idleAnimation])
    }
    
    func updateMaskColor(color: UIColor){
        if mask != nil && maskCloud != nil{
            maskColor = color
            let action = SKAction.colorize(with: color, colorBlendFactor: 1, duration: colorDuration)
            mask.run(action)
            maskCloud.run(action)
        }
    }
}
