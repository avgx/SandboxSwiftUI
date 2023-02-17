//
//  NavBarSampleView1.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 25.01.2022.
//

import SwiftUI

struct NavBarSampleView1: View {
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                Text("text")
                    .navigationTitle(Text(""))
                    .navigationBarTitleDisplayMode(.inline)
                //.navigationBarHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                //self.showSheetView = true
                            }) {
                                //Label("Send", systemImage: "paperplane.fill")
                                Text("accountName")
                                    .lineLimit(1).frame(maxWidth: geo.size.width / 2)
                                Image(systemName: "chevron.down").imageScale(.small)
                            }
                        }
                        ToolbarItem(placement: .principal) { // <3>
                            VStack {
                                Text("Title").font(.headline)
                                Text("Subtitle").font(.subheadline)
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(action: {
                                print("Refresh")
                            }) {
                                Label("Refresh", systemImage: "plus.square")
                            }
                            actionButton
                        }
                        
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: {
                                //showActionSheet = true
                            }, label: {
                                Image(systemName: "camera.filters")
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "square.and.arrow.up")
                            })
                        }
                    }
            }.navigationViewStyle(.stack)
            //                .actionSheet(isPresented: self.$showSheetView, content: {
            //                    let sepia = ActionSheet.Button.default(Text("Sepia")) {
            //                    }
            //                    let mono = ActionSheet.Button.default(Text("Mono")) {
            //                    }
            //                    let blur = ActionSheet.Button.default(Text("Blur")) {
            //                    }
            //                    let remove = ActionSheet.Button.destructive(Text("Remove filter")) {
            //                    }
            //                    let cancel = ActionSheet.Button.cancel(Text("Cancel")) {
            //                        showSheetView = false
            //                    }
            //
            //                    return ActionSheet(title: Text("Filters"), message: nil, buttons: [sepia, mono, blur, remove, cancel])
            //                })
            //.popover(isPresented: self.$showSheetView) {
            //HelloView(showSheetView: self.$showSheetView)
            //}
            //                .sheet(isPresented: self.$showSheetView) {
            //                    HelloView(showSheetView: self.$showSheetView)
            //                }
                .onAppear {
                    //           DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    //               self.showSheetView = false
                    //           }
                }
        }
    }
    
    @ViewBuilder
    private var actionButton: some View {
        Menu(content: {
            
            Section {
                Button(action: {  }) {
                    Label("Share as Document", systemImage: "square.and.arrow.up")
                }
                Button(action: {
                    //viewModel.isAuthorized = false
                }) {
                    Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }
            
            Section {
                Button(action: {}) {
                    Label("Share as Text File", systemImage: "square.and.arrow.up")
                }
            }
        }, label: {
            Image(systemName: "ellipsis.circle")
        })
    }
    
    
    var body2: some View {
        NavigationView {
            Text("text")
                .safeAreaInset(edge: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack() {
                            Text("Custom Nav Bar")
                                .font(.largeTitle.weight(.bold))
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "wifi")
                            }
                        }
                        Text("With safeAreaInset you can create your own custom nav bar.")
                            .font(.caption)
                    }
                    .padding()
                    .background(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                                               startPoint: .topLeading, endPoint: .bottomTrailing)
                        .overlay(.ultraThinMaterial)
                    )
                }
                .navigationBarHidden(true)
                .tint(.orange)
        }
    }
    
    var body1: some View {
        NavigationView {
            ZStack {
                Color.green
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                VStack {
                    Rectangle()
                        .frame(height: 0)
                        .background(Color.green.opacity(0.2))
                    Text("Have the style touching the safe area edge.")
                        .padding()
                    Spacer()
                }
                .navigationTitle("Profile")
                .font(.title2)
            }
        }
    }
}

#if DEBUG
@available(iOS 13.0, tvOS 14.0, *)
struct NavBarSampleView1_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            NavBarSampleView1()
            NavBarSampleView1()
                .preferredColorScheme(.dark)
            //.environment(\.colorScheme, .dark)
        }
    }
}

#endif
