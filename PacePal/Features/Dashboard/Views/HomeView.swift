//
//  HomeView.swift
//  PacePal
//
//  Created by Cathleen Vu on 1/20/25.
//

import SwiftUI

struct HomeView: View {    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack {
            VStack {
                Text("Goal: 10,000") // TODO: Allow user to set their own goal
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                // STEP COUNT
                Text("7,234")
                    .font(.system(size: 53))
                    .fontWeight(.bold)

                Text("Steps")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))

                VStack {
                    LazyVGrid(columns: columns) {
                        
                        // MILES WALKED CARD
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .customCardView(width: .infinity,
                                                height: UIScreen.main.bounds.height * 0.1)
                                
                            VStack(spacing: 5) {
                                Text("1.0") // TODO
                                Text("Miles")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 16))
                            }
                        }
                        .padding(4)
                        
                        // CALORIES BURNED CARD
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .customCardView(width: .infinity,
                                                height: UIScreen.main.bounds.height * 0.1)
                            
                            VStack(spacing: 5) {
                                Text("210") // TODO
                                Text("Calories")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 16))
                            }
                        }
                        .padding(4)

                        // ACTIVE TIME CARD
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .customCardView(width: .infinity,
                                                height: UIScreen.main.bounds.height * 0.1)
                            
                            VStack(spacing: 5) {
                                Text("0h 17m") // TODO
                                Text("Active Time")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 16))
                            }
                        }
                        .padding(4)

                    }
                    .font(.system(size: 13))
                    .padding()
                }
                .padding([.top, .bottom], 15)
                
                // STEPS WALKED GRAPH VIEW
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .customCardView(width: UIScreen.main.bounds.width * 0.9,
                                        height: UIScreen.main.bounds.height * 0.3)
                    
                    // TODO: Implement steps graph
                }
            
                Spacer()
            }
            .background(Color(hex: 0xFBF7F4))
        }
    }
}

#Preview {
    HomeView()
}
