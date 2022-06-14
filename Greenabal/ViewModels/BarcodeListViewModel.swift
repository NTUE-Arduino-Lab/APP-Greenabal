//
//  BarcodeListViewModel.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/14.
//

import Foundation

class BarcodeListViewModel: ObservableObject{
    @Published var buyList: [BuyList]
    
    init(){
        let testList: [BuyList] = [
            BuyList(date: "2022/05/05", shop: "全聯實業", items: [
                BuyItem(name: "蒲公英環保抽取衛生紙", gift: GiftLeaf(leaf: 3), seal: Seal.環保標章.rawValue, badge: BudgeType.seal_環保.rawValue)
                ]
            ),
            BuyList(date: "2022/05/19", shop: "全聯實業", items: [
                BuyItem(name: "蒲公英環保抽取衛生紙", gift: GiftLeaf(leaf: 3), seal: Seal.環保標章.rawValue, badge: BudgeType.seal_環保.rawValue),
                BuyItem(name: "部落小農系列高麗菜", gift: GiftLeaf(leaf: 3), seal: Seal.有機農產品標章.rawValue, badge: BudgeType.seal_有機.rawValue)
                ]
            ),
        ]
        
        buyList = testList
        
        print(GetList(year: 2022, startMonth: 5,endMonth: 6))
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
        return result
    }
}

