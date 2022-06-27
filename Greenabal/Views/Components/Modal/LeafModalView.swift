//
//  LeafModalView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/27.
//

import SwiftUI

struct LeafModalView: View {
    @EnvironmentObject var modalVM: ModalViewModel
    
    var body: some View {
        Text(modalVM.titleSmall)
            .font(.custom("Roboto Medium", size: 14))
            .foregroundColor(Color(#colorLiteral(red: 0.06, green: 0.91, blue: 0.69, alpha: 1)))
            .tracking(0.56)
            .multilineTextAlignment(.center)
            .background(
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.9700000286102295, green: 0.9700000286102295, blue: 0.9700000286102295, alpha: 1)))
                    .frame(width: 222, height: 36)
                    .shadow(color: Color(#colorLiteral(red: 0.0625, green: 0.0625, blue: 0.0625, alpha: 0.15000000596046448)), radius:5, x:0, y:3)
            )
    }
}

struct LeafModalView_Previews: PreviewProvider {
    static var previews: some View {
        LeafModalView()
    }
}
