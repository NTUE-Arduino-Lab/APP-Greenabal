//
//  Background.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/9.
//

import Foundation
import SwiftUI

class BackgroundViewModel: ObservableObject {
    @Published var color: LinearGradient
    
    init(){
        color = LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.6102343797683716, green: 0.7855484485626221, blue: 0.9125000238418579, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.915928840637207, green: 0.9526067972183228, blue: 0.9791666865348816, alpha: 1)), location: 1)]),
            startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
            endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999))
    }
}
