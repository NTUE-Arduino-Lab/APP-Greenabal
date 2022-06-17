//
//  Record.swift
//  Greenabal
//
//  Created by Tony on 2022/6/15.
//

import Foundation
import SwiftUI

struct RecordBlock: View {
    @Binding var data: [Double]
    @Binding var labels: [String]
    let accentColor1: Color
    let accentColor2: Color
    let axisColor: Color
    let showGrid: Bool
    let gridColor: Color
    let spacing: CGFloat
    
    private var minimum: Double { (data.min() ?? 0) * 0.95 }
    //      private var maximum: Double { (data.max() ?? 1) * 1.05 }
    private var maximum: Double { (24 ) * 1 }
    var body: some View {
        VStack{
            
            
            VStack{
                VStack {
                    HStack{Text("葉子數量統計").font(.custom("Roboto SemiBold", size: 14))
                        Spacer()
                        Button{
                            print("\(10/3)")
                        }label: {
                            Text("按鈕").font(.custom("Roboto Regular", size: 12)).tracking(0.56)
                        }
                    }
                    HStack{
                        WeekLabelStack()
                        ZStack {
                            if showGrid {
                                BarChartGrid(divisionsH: 7,divisionsY: 4)
                                    .stroke(gridColor, style: StrokeStyle(lineWidth: 0.5 , dash: [6,3]))
                            }
                            //因為條狀圖的bar無法只有右半設圓角 所以先放沒有圓角的 再疊一個有圓角的上去
                            BarStack(data: $data,
                                     labels: $labels,
                                     accentColor1: accentColor1,
                                     accentColor2: accentColor2,
                                     gridColor: gridColor,
                                     showGrid: showGrid,
                                     min: minimum,
                                     max: maximum,
                                     spacing: spacing,
                                     rounded: false
                            )
                            BarStack(data: $data,
                                     labels: $labels,
                                     accentColor1: accentColor1,
                                     accentColor2: accentColor2,
                                     gridColor: gridColor,
                                     showGrid: showGrid,
                                     min: minimum,
                                     max: maximum,
                                     spacing: spacing,
                                     rounded: true
                            )
                            
                            
                            //                        BarChartAxes()
                            //                          .stroke(Color.black, lineWidth: 2)
                            NumberStack(data: $data,
                                        min: minimum,
                                        max: maximum,
                                        spacing: spacing
                            )
                        }
                    }.padding(.top,0)
                    
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20) )
                LabelStack(labels: $labels, spacing: spacing) .padding(EdgeInsets(top: 0, leading: 36, bottom: 5, trailing: 14) )
            }.padding(.top,14).padding(.bottom,5)
            
            
        }.frame(height: 218).background( RoundedRectangle(cornerRadius: 10).fill(Color.white)).padding(.horizontal,16)
    }
}

struct BarChartGrid: Shape {
    let divisionsH: Int
    let divisionsY: Int
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let stepSizeH = rect.height / CGFloat(divisionsH)
        let stepSizeV = rect.width / CGFloat(divisionsY)
        
        (0 ... divisionsH).forEach { step in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY - stepSizeH * CGFloat(step)))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - stepSizeH * CGFloat(step)))
        }
        
        (0 ... divisionsY).forEach { step in
            path.move(to: CGPoint(x: rect.maxX - stepSizeV * CGFloat(step), y: rect.minY ))
            path.addLine(to: CGPoint(x: rect.maxX - stepSizeV * CGFloat(step), y: rect.maxY ))
        }
        
        return path
    }
}


struct BarChartAxes: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

struct BarStack: View {
    @Binding var data: [Double]
    @Binding var labels: [String]
    let accentColor1: Color
    let accentColor2: Color
    let gridColor: Color
    let showGrid: Bool
    let min: Double
    let max: Double
    let spacing: CGFloat
    let rounded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(0 ..< data.count) { index in
                LinearGradient(
                    gradient: .init(
                        stops: [
                            .init(color: accentColor1, location: 0),
                            
                                .init(color: accentColor2, location: 1)
                        ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                    .clipShape(BarPath(data: data[index], max: max, min: min , rounded: rounded))
            }
        }
        //    .shadow(color: .black, radius: 5, x: 1, y: 1)
        .padding(.vertical, spacing/2)
    }
}


struct NumberStack: View {
    @Binding var data: [Double]
    //  @Binding var labels: [String]
    //  let accentColor1: Color
    //    let accentColor2: Color
    //  let gridColor: Color
    //  let showGrid: Bool
    let min: Double
    let max: Double
    let spacing: CGFloat
    let width = CGFloat()
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: spacing/2) {
            ForEach(0 ..< data.count) { index in
                
                
                //          Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(.red).font(.custom("Roboto SemiBold", size: 12)).offset(x:0,y:0).overlay(
                //            GeometryReader(content: { geometry in
                //                Button{
                //                    print(geometry.frame(in: .global).minX)
                //
                //                }label:{
                //                    Text("\(Int(data[index]))")
                //                }
                //
                //            })
                //        )
                
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity).overlay(
                    GeometryReader(content: { geometry in
                        let width:CGFloat = CGFloat((data[index] - min) / (max - min)) * geometry.frame(in: .global).width
                        if data[index] != 0 {
                            Text("\(Int(data[index]))").font(.custom("Roboto SemiBold", size: 12)).foregroundColor(Color(#colorLiteral(red: 0.47, green: 0.79, blue: 0.56, alpha: 1))).offset(x:width + 3,y:0)
                            
                        }
                        
                        
                    })
                )
                
                //        LinearGradient(
                //          gradient: .init(
                //            stops: [
                //              .init(color: accentColor1, location: 0),
                //
                //              .init(color: accentColor2, location: 1)
                //            ]),
                //          startPoint: .leading,
                //          endPoint: .trailing
                //        )
                //              .clipShape(BarPath(data: data[index], max: max, min: min))
            }
        }
        //    .shadow(color: .black, radius: 5, x: 1, y: 1)
        .padding(.vertical, spacing/4)
    }
}



struct BarPath: Shape {
    let data: Double
    let max: Double
    let min: Double
    let rounded:Bool
    
    func path(in rect: CGRect) -> Path {
        guard min != max else {
            return Path()
        }
        //有沒有圓角
        switch rounded{
        case true:
            let width = CGFloat((data - min) / (max - min)) * rect.width*0.5
            let bar = CGRect(x: rect.minX , y: rect.minY , width: width, height: rect.height)
            //      let bar = CGRect(x: rect.minX, y: rect.maxY - (rect.minY + height), width: rect.width, height: height)
            return Rectangle().path(in: bar)
        case false:
            let width = CGFloat((data - min) / (max - min)) * rect.width
            let bar = CGRect(x: rect.minX , y: rect.minY , width: width, height: rect.height)
            //      let bar = CGRect(x: rect.minX, y: rect.maxY - (rect.minY + height), width: rect.width, height: height)
            return RoundedRectangle(cornerRadius: 5).path(in: bar)
        }
        
        //      return RoundedRectangle(cornerRadius: 5).path(in: bar)
    }
}

struct BarPathRounded: Shape {
    let data: Double
    let max: Double
    let min: Double
    
    func path(in rect: CGRect) -> Path {
        guard min != max else {
            return Path()
        }
        
        let width = CGFloat((data - min) / (max - min)) * rect.width
        let bar = CGRect(x: rect.minX , y: rect.minY , width: width, height: rect.height)
        //      let bar = CGRect(x: rect.minX, y: rect.maxY - (rect.minY + height), width: rect.width, height: height)
        return Rectangle().path(in: bar)
        //      return RoundedRectangle(cornerRadius: 5).path(in: bar)
    }
}

struct LabelStack: View {
    @Binding var labels: [String]
    let spacing: CGFloat
    
    var body: some View {
        HStack(alignment: .center, spacing:0 ) {
            ForEach(labels, id: \.self) {label in
                if label != "0"{
                    Spacer()
                    Text(label).font(.custom("Roboto Medium", size: 12)).foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                }else{
                    Text(label).font(.custom("Roboto Medium", size: 12)).foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
                }
                
            }
        }
        
    }
}
struct WeekLabelStack: View {
    var labels: [String]=["日","ㄧ","二","三","四","五","六"]
    let spacing: CGFloat = 5
    
    var body: some View {
        VStack(alignment: .center, spacing:spacing) {
            ForEach(labels, id: \.self) { label in
                if label == "日" || label == "六"{
                    Text(label).font(.custom("Roboto Medium", size: 12)).foregroundColor(Color(#colorLiteral(red: 0.98, green: 0.48, blue: 0.48, alpha: 1)))
                }else{
                    Text(label).font(.custom("Roboto Medium", size: 12)).foregroundColor(Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5 ,alpha: 1)))
                }
                //          .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, spacing/2)
    }
}
//struct ExtractedView: View {
//    @Binding var data: [Double]
//
//      let min: Double
//      let max: Double
//      let spacing: CGFloat
//
//    let width : CGFloat
//    var body: some View {
//        Text("").frame(maxWidth: .infinity, maxHeight: .infinity).overlay(
//            GeometryReader(content: { geometry in
//                width = CGFloat((data - min) / (max - min)) * geometry.frame(in: .global).width
//                Text("\(Int(data[index]))").font(.custom("Roboto SemiBold", size: 12)).offset(x:width,y:0)
//
//            })
//        )
//    }
//}


