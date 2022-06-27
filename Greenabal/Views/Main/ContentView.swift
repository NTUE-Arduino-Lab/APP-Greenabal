//
//  ContentView.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/7.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var backgroundVM : BackgroundViewModel
    
    var body: some View {
        ZStack(alignment:.bottom){
            Rectangle()
                .animatableGradient(fromGradient: backgroundVM.gradients.0, toGradient: backgroundVM.gradients.1, progress: backgroundVM.progress, animateState: backgroundVM.animateState,canAnimate: backgroundVM.canAnimate, SetAnimate: backgroundVM.SetAnimate)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: backgroundVM.duration).repeatForever(autoreverses: false)) {
                        backgroundVM.progress = 1
                    }
                }
            
            TabBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let backgroundVM = BackgroundViewModel()
    static var islandVM = IslandViewModel(leafVM: leafVM)
    static var modalVM: ModalViewModel = ModalViewModel()
    static let leafVM = LeafViewModel(mvm: modalVM)
    
    static var previews: some View {
        ContentView()
            .environmentObject(backgroundVM)
            .environmentObject(leafVM)
            .environmentObject(islandVM)
            .environmentObject(modalVM)
    }
}
