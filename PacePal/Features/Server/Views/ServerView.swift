//
//  ServerView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/27/25.
//

import SwiftUI

struct ServerView: View {
    @State private var showCreateServerSheet = false
    @State private var showJoinServerSheet = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Servers")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                // MARK: Create Server Row
                Button(action: {
                    showCreateServerSheet = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(hex: 0x53A57D))
                        
                        Text("Create Server")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.18), radius: 12)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .contentShape(RoundedRectangle(cornerRadius: 12))

                // MARK: Join Server Row
                Button(action: {
                    showJoinServerSheet = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(hex: 0x53A57D))
                        
                        Text("Join Server")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.18), radius: 12)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .contentShape(RoundedRectangle(cornerRadius: 12))

                // MARK: Server list
                // TODO: Implement erver list
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 70)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: 0xFBF7F4))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ServerView()
}
