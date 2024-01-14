//
//  ContentView.swift
//  Pinch
//
//  Created by Ivan Romero on 11/01/2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    // MARK: - FUNCTION
    func resetImageState() {
        withAnimation(.spring) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    // MARK: - CONTENT
    var body: some View {
        NavigationStack {
            ZStack(content: {
                Color.clear
                //MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                // Corner radius deprecated in future, replace with 👇🏻
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                //MARK: - 1. TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring) {
                                imageScale = 5
                            }
                        } else {
                            withAnimation(.spring) {
                                resetImageState()
                            }
                        }
                    })
                //MARK: - 2. DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
            })
            .navigationTitle("Pich & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            .overlay(alignment: .top) {
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
            }
            .overlay(alignment: .bottom) {
                Group {
                    HStack {
                        // SCALE DOWN
                        Button(action: {
                            withAnimation(.spring) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                }
                                
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        }, label: {
                            ControlImageView(iconName: "minus.magnifyingglass")
                        })
                        // RESET
                        Button(action: {
                            resetImageState()
                        }, label: {
                            ControlImageView(iconName: "arrow.up.left.and.down.right.magnifyingglass")
                        })
                        // SCALE UP
                        Button(action: {
                            withAnimation(.spring) {
                                if imageScale < 5 {
                                    imageScale += 1
                                }
                                
                                if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        }, label: {
                            ControlImageView(iconName: "plus.magnifyingglass")
                        })
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 12))
                    .opacity(isAnimating ? 1 : 0)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    ContentView()
}
