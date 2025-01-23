//
//  ViewExtension.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/17/25.
//

import SwiftUI

struct CustomTextFieldShape: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding([.leading, .trailing], 25)
            .padding([.top, .bottom], 30)
            .frame(width: 350, height: 60)
            .background(color)
            .clipShape(.capsule)
            .font(.system(size: 12))
    }
}

struct CustomCardView: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width,
                   height: height)
            .cornerRadius(13)
            .shadow(color: Color.gray.opacity(0.18), radius: 12)
    }
}

extension View {
    func customTextFieldShape(color: Color) -> some View {
        modifier(CustomTextFieldShape(color: color))
    }
    
    func customCardView(width: CGFloat, height: CGFloat) -> some View {
        modifier(CustomCardView(width: width, height: height))
    }
}
