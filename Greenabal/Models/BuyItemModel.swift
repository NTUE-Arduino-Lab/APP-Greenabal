//
//  Buytem.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/14.
//

import Foundation

enum Seal: String{
    case 環保標章 = "環保標章"
    case 省電標章 = "省電標章"
    case 有機農產品標章 = "有機農產品標章"
    
}

class BuyItem: Identifiable{
    //    載具消費紀錄
    let id = UUID()
    let seal: String
    let name: String
    let gift: Any
    let badge: String
    var openGift: Bool
    
    init(name: String, gift: Any, seal: String = Seal.環保標章.rawValue , badge: String = BadgeType.youbike.rawValue){
        self.name = name
        self.seal = seal
        self.badge = badge
        self.gift = gift
        self.openGift = false
    }
    
    func OpenGift(){
        openGift = true
    }
}

class BuyList: Identifiable{
    //    載具消費紀錄
    let id = UUID()
    let date: String
    let shop: String
    let items: [BuyItem]
    
    init(date: String, shop: String , items: [BuyItem]){
        self.date = date
        self.shop = shop
        self.items = items
    }
}


enum GiftType{
    case leaf
    case island
}

struct GiftLeaf{
    let leaf: Int
    let type: GiftType = GiftType.leaf
}

struct GiftIsland{
    let type: GiftType = GiftType.island
}
