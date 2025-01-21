//
//  TextFieldShapeExtension.swift
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

extension View {
    func customTextFieldShape(color: Color) -> some View {
        modifier(CustomTextFieldShape(color: color))
    }
}
