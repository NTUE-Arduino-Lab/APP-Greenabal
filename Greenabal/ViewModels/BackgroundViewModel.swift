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
    @Published var progress: CGFloat
    @Published var gradients: (Gradient,Gradient)
    @Published var canAnimate: Bool
    @Published var animateState: Bool
    @Published var maskColors: (Color,Color)
    @Published var duration: CGFloat
    
    var timer: Timer?
    @Published var state: BackgroundState
    
    enum BackgroundState: Int {
        case morning = 0
        case afternoon
        case evening
        case night
        
        func GetGradients() -> (Gradient,Gradient){
            let gradient1: Gradient
            let gradient2: Gradient
            
            switch self {
            case .night:
                gradient1 = GetGradient(rawValue: self.rawValue)
                gradient2 = GetGradient(rawValue: 0)
            default:
                gradient1 = GetGradient(rawValue: self.rawValue)
                gradient2 = GetGradient(rawValue: self.rawValue + 1)
            }
            return (gradient1,gradient2)
        }
        
        func GetMasks() -> (Color,Color){
            let mask1: Color
            let mask2: Color
            
            switch self {
            case .night:
                mask1 = GetMask(rawValue: self.rawValue)
                mask2 = GetMask(rawValue: 0)
            default:
                mask1 = GetMask(rawValue: self.rawValue)
                mask2 = GetMask(rawValue: self.rawValue + 1)
            }
            return (mask1,mask2)
        }
        
        func GetGradient(rawValue: Int) -> Gradient{
            switch rawValue {
            case BackgroundState.morning.rawValue:
                return Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8745098114013672, blue: 0.6745098233222961, alpha: 1)), Color(#colorLiteral(red: 0.9960784316062927, green: 0.9960784316062927, blue: 0.8549019694328308, alpha: 1))])
            case BackgroundState.afternoon.rawValue:
                return Gradient(colors: [Color(#colorLiteral(red: 0.6102343797683716, green: 0.7855484485626221, blue: 0.9125000238418579, alpha: 1)), Color(#colorLiteral(red: 0.915928840637207, green: 0.9526067972183228, blue: 0.9791666865348816, alpha: 1))])
            case BackgroundState.evening.rawValue:
                return Gradient(colors: [Color(#colorLiteral(red: 0.9372549057006836, green: 0.5333333611488342, blue: 0.40392157435417175, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.6980392336845398, blue: 0.5882353186607361, alpha: 1))])
            case BackgroundState.night.rawValue:
                return Gradient(colors: [Color(#colorLiteral(red: 0.24313725531101227, green: 0.3176470696926117, blue: 0.43529412150382996, alpha: 1)), Color(#colorLiteral(red: 0.3137255012989044, green: 0.3333333432674408, blue: 0.4117647111415863, alpha: 1))])
            default:
                return Gradient(colors: [.red,.purple])
            }
        }
        
        func GetGradient(type: BackgroundState) -> Gradient{
            switch type {
            case .morning:
                return Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8745098114013672, blue: 0.6745098233222961, alpha: 1)), Color(#colorLiteral(red: 0.9960784316062927, green: 0.9960784316062927, blue: 0.8549019694328308, alpha: 1))])
            case .afternoon:
                return Gradient(colors: [Color(#colorLiteral(red: 0.6102343797683716, green: 0.7855484485626221, blue: 0.9125000238418579, alpha: 1)), Color(#colorLiteral(red: 0.915928840637207, green: 0.9526067972183228, blue: 0.9791666865348816, alpha: 1))])
            case .evening:
                return Gradient(colors: [Color(#colorLiteral(red: 0.9372549057006836, green: 0.5333333611488342, blue: 0.40392157435417175, alpha: 1)), Color(#colorLiteral(red: 0.8196078538894653, green: 0.6980392336845398, blue: 0.5882353186607361, alpha: 1))])
            case .night:
                return Gradient(colors: [Color(#colorLiteral(red: 0.24313725531101227, green: 0.3176470696926117, blue: 0.43529412150382996, alpha: 1)), Color(#colorLiteral(red: 0.3137255012989044, green: 0.3333333432674408, blue: 0.4117647111415863, alpha: 1))])
            }
        }
        
        func GetMask(rawValue: Int) -> Color{
            switch rawValue {
            case BackgroundState.morning.rawValue:
                return Color(#colorLiteral(red: 1, green: 0.9586806297302246, blue: 0.8583333492279053, alpha: 1))
            case BackgroundState.afternoon.rawValue:
                return Color.white
            case BackgroundState.evening.rawValue:
                return Color(#colorLiteral(red: 0.9176470637321472, green: 0.8156862854957581, blue: 0.7921568751335144, alpha: 1))
            case BackgroundState.night.rawValue:
                return Color(#colorLiteral(red: 0.5230903029441833, green: 0.5317170023918152, blue: 0.5458333492279053, alpha: 1))
            default:
                return Color.white
            }
        }
        
        func GetNextState() -> BackgroundState{
            switch self {
            case .morning:
                return .afternoon
            case .afternoon:
                return .evening
            case .evening:
                return .night
            case .night:
                return .morning
            }
        }
    }
    
    init(){
        color = LinearGradient(
            gradient: BackgroundState.afternoon.GetGradient(type: .afternoon),
            startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
            endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999))
        
        state = BackgroundState.afternoon
        progress = 0
        canAnimate = false
        animateState = false
        duration = 5.0
        
        gradients = BackgroundState.afternoon.GetGradients()

        maskColors = BackgroundState.afternoon.GetMasks()
        
        GetInitBackground()
        
    }
    
    func StartBackgroundProcess(){
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(SetAnimateState), userInfo: nil, repeats: true)
    }
    
    func GetInitBackground(){
        let dateVM = DateViewModel()
        let nowHR = dateVM.GetHour(date: Date())
        
        if nowHR >= 4 && nowHR < 8{
            state = BackgroundState.morning
        }
        else if nowHR >= 8 && nowHR < 17{
            state = BackgroundState.afternoon
        }
        else if nowHR >= 17 && nowHR < 19{
            state = BackgroundState.evening
        }
        else if nowHR >= 19 || nowHR < 4{
            state = BackgroundState.night
        }
        else{
            state = BackgroundState.afternoon
        }
        
        gradients = state.GetGradients()
        maskColors = state.GetMasks()
    }
    
    func SetBackground(){
        state = state.GetNextState()
        gradients = state.GetGradients()
        maskColors = state.GetMasks()
    }
    
    func SetAnimate(canA: Bool, stateA: Bool){
        if canA != canAnimate { SetCanAnimate() }
        if stateA != animateState { SetAnimateState() }
        
        if !stateA {
            SetBackground()
        }
    }
    
    func SetCanAnimate(){
        canAnimate = !canAnimate
        //        print("Switch CanAnimate \(canAnimate)")
    }
    
    @objc func SetAnimateState(){
        animateState = !animateState
        //        print("Switch AnimateState \(animateState)")
    }
}

struct AnimatableGradientModifier: AnimatableModifier {
    let fromGradient: Gradient
    let toGradient: Gradient
    var progress: CGFloat = 0.0
    var canAnimate: Bool
    var animateState: Bool
    var SetAnimate: (Bool,Bool) -> Void
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        
        if animateState && canAnimate {
            var gradientColors = [Color]()
            
            for i in 0..<fromGradient.stops.count {
                let fromColor = UIColor(fromGradient.stops[i].color)
                let toColor = UIColor(toGradient.stops[i].color)
                
                gradientColors.append(colorMixer(fromColor: fromColor, toColor: toColor, progress: progress))
            }
            
            if progress == 1 {
                SetAnimate(!canAnimate,!animateState)
            }
            
            return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        else if progress <= 0.005 && !canAnimate && animateState{
            SetAnimate(!canAnimate,animateState)
        }
        
        return LinearGradient(gradient: fromGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
        guard let fromColor = fromColor.cgColor.components else { return Color(fromColor) }
        guard let toColor = toColor.cgColor.components else { return Color(toColor) }
        
        let red = fromColor[0] + (toColor[0] - fromColor[0]) * progress
        let green = fromColor[1] + (toColor[1] - fromColor[1]) * progress
        let blue = fromColor[2] + (toColor[2] - fromColor[2]) * progress
        
        return Color(red: Double(red), green: Double(green), blue: Double(blue))
    }
}

extension View {
    func animatableGradient(fromGradient: Gradient, toGradient: Gradient, progress: CGFloat,animateState: Bool,canAnimate: Bool, SetAnimate: @escaping (Bool,Bool) -> Void) -> some View {
        self.modifier(AnimatableGradientModifier(fromGradient: fromGradient, toGradient: toGradient, progress: progress,canAnimate: canAnimate, animateState: animateState, SetAnimate: SetAnimate))
    }
}
