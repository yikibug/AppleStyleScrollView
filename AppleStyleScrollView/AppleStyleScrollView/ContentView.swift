//
//  ContentView.swift
//  AppleStyleScrollView
//
//  Created by ilCode on 2025/6/3.
//

import SwiftUI

struct ContentView: View {
    @State var visibleItem: CardItem? = cardItems.first
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(cardItems) { item in
                    CardView(item: item)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                        }
                        .id(item)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $visibleItem)
        .background(.gray.opacity(0.3))
        .clipShape(.rect(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2)
                .foregroundStyle(.gray.opacity(0.3))
        }
        .frame(height: 200)
        .padding(.leading, 16).padding(.trailing, 35)
        .overlay(alignment: .trailing) {
            VStack(spacing: 12) {
                ForEach(cardItems) { item in
                    Circle()
                        .frame(width: item == visibleItem ? 10 : 6, height: item == visibleItem ? 10 : 6)
                        .foregroundStyle(item == visibleItem ? Color.primary : .gray)
                        .animation(.linear, value: visibleItem)
                }
            }.padding(.trailing, 10)
        }
    }
}

#Preview {
    ContentView()
}

struct CardItem: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}

let cardItems: [CardItem] = [
    CardItem(
        imageName: "n1",
        title: "Frozen River Valley",
        description: "A tranquil winter landscape with frosted trees and still waters."
    ),
    CardItem(
        imageName: "n2",
        title: "Mountain Shadows",
        description: "Sharp ridgelines and soft fog in a remote alpine region."
    ),
    CardItem(
        imageName: "n3",
        title: "Mont Saint-Michel",
        description: "A mystical monastery risting from the mist on a coastal plain."
    ),
    CardItem(
        imageName: "n4",
        title: "Zen Garden Bridge",
        description: "A peaceful Japanese garden scene with vibrant greens and a red bridge."
    ),
    CardItem(
        imageName: "n5",
        title: "Desert Boulders",
        description: "Massive rock formations under a crisp blue sky in the Mojave Desert."
    )
]

struct CardView: View {
    var item: CardItem
    
    var body: some View {
        Image(item.imageName)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 8))
            .overlay(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(LinearGradient(stops: [
                        .init(color: .white.opacity(0), location: 0.4),
                        .init(color: .red.opacity(0.8), location: 1)
                    ], startPoint: .top, endPoint: .bottom))
            }
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title).font(.system(size: 23).bold())
                    Text(item.description).padding(.trailing, 20).font(.system(size: 14.0))
                }
                .padding()
            }
    }
}
