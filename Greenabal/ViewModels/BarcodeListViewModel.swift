//
//  BarcodeListViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/14.
//

import Foundation

class BarcodeListViewModel: ObservableObject{
    @Published var buyList: [BuyList]
    let leafVM: LeafViewModel
    let badgeVM: BadgeViewModel
    
    init(leafVM: LeafViewModel,badgeVM: BadgeViewModel){
        self.leafVM = leafVM
        self.badgeVM = badgeVM
        
        let testList: [BuyList] = [
            BuyList(date: "2022/05/05", shop: "全聯實業", items: [
                BuyItem(name: "蒲公英環保抽取衛生紙", gift: GiftLeaf(leaf: 3), seal: Seal.環保標章.rawValue, badge: BadgeType.seal_環保.rawValue)
            ]
                   ),
            BuyList(date: "2022/05/19", shop: "全聯實業", items: [
                BuyItem(name: "蒲公英環保抽取衛生紙", gift: GiftLeaf(leaf: 3), seal: Seal.環保標章.rawValue, badge: BadgeType.seal_環保.rawValue),
                BuyItem(name: "部落小農系列高麗菜", gift: GiftIsland(), seal: Seal.有機農產品標章.rawValue, badge: BadgeType.seal_有機.rawValue)
            ]
                   )
        ]
        
        self.buyList = testList
        
//        AddItem(date: "2022/06/19", shop: "全聯實業", items: [
//            BuyItem(name: "蒲公英環保抽取衛生紙", gift: GiftLeaf(leaf: 3), seal: Seal.環保標章.rawValue, badge: BadgeType.seal_環保.rawValue),
//            BuyItem(name: "部落小農系列高麗菜", gift: GiftLeaf(leaf: 3), seal: Seal.有機農產品標章.rawValue, badge: BadgeType.seal_有機.rawValue)
//        ])
        
        print("--------------barcode list init-----------------")
        print(buyList)
    }
    
    func GetList(year: Int, startMonth: Int,endMonth: Int) -> [BuyList]{
        //        取得列表
        var result: [BuyList] = []
        buyList.forEach { item in
            let date = item.date.split(separator: "/")
            let startMonthString = startMonth < 10 ? "0\(startMonth)" : String(startMonth)
            let endMonthString = endMonth < 10 ? "0\(endMonth)" : String(endMonth)
            if date[0] == String(year) && (date[1] == startMonthString || date[1] == endMonthString) {
                result.append(item)
            }
        }
        result = result.sorted(by: {
            $0.date > $1.date
        })
        
        print("--------------get barcode list-----------------")
        print(result)
        
        return result
    }
    
    func AddItem(date: String, shop: String, items: [BuyItem]){
        buyList.append(BuyList(date: date, shop: shop, items: items))
        
        print("--------------add barcode item-----------------")
        print(buyList)
        
        
        items.forEach { item in
            switch item.gift {
            case is GiftLeaf:
                let gift: GiftLeaf = item.gift as! GiftLeaf
                leafVM.AddCount(num: gift.leaf, record: true)
            default:
                break
            }
            
            badgeVM.RefreshBadge(name: item.badge)
        }
    }
    
    func OpenGift(item: BuyItem){
        switch item.gift {
        case is GiftLeaf:
            let gift: GiftLeaf = item.gift as! GiftLeaf
            leafVM.AddCount(num: gift.leaf, record: true)
        case is GiftIsland:
            print("get island")
        default:
            break
        }
        item.OpenGift()
    }
}

