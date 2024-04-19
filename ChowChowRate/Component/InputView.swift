//
//  InputView.swift
//  GrubRate
//
//  Created by Andres Made on 4/14/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    var title: String
    var placeholder: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecure == false {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "example@example.com")
}
