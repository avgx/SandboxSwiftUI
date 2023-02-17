//
//  FormSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 25.03.2022.
//

import SwiftUI

struct FormSample: View {
    
    @State var notifyMeAbout: NotifyMeAboutType = .directMessages
    
    enum NotifyMeAboutType: Int, CaseIterable {
        case directMessages, mentions, anything
    }
    
    @State var burgerOptionTag: Int = 0
    var burgerOption = ["Single Patty", "Double Patty"]
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    
                    
                    Picker("Notify Me About", selection: $notifyMeAbout) {
                        Text("Direct Messages").tag(NotifyMeAboutType.directMessages)
                        Text("Mentions").tag(NotifyMeAboutType.mentions)
                        Text("Anything").tag(NotifyMeAboutType.anything)
                    }
                    
                    Picker("Options", selection: $burgerOptionTag) {
                        Text("Single Patty").tag(0)
                        Text("Double Patty").tag(1)
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section {
                    applyButton//.buttonStyle(OutlineButton())
                        .listRowInsets(EdgeInsets())
                }
                //.background(Color.red)
            }
        }
    }
    
    private var applyButton: some View {
        Button(action: {
            print("apply")
        }) {
            Text("Apply")
                .frame(height: 48)
                .frame(maxWidth: .infinity, maxHeight: 48)
        }
        .buttonStyle(SwitchColorButtonStyle())
    }
    
    struct SwitchColorButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(configuration.isPressed ? Color.accentColor : Color.white)
                .background(configuration.isPressed ? Color.white : Color.accentColor)
        }
    }
    
}

