//
//  File.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 23.12.2022.
//

import UIKit
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct PhoneVerificationView: View {
    
    @State var phoneNumber: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
//                Color(hex: "#232175")
//                    .frame(height: 300)
                Color(hex: "F6F8FB").opacity(0.2)
            }
            
            VStack {
                //                        appbar
                //                            .padding(.top, 45)
                //                            .padding(.horizontal, 30)
                
                VStack {
                    cardForm
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top, 35)
                .padding(.bottom, 35)
            }
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationBarHidden(true)
        .onTapGesture() {
            UIApplication.shared.endEditing()
        }
    }
    
    var cardForm: some View {
        HStack {
            Text("🇮🇩 +62 ")//.foregroundColor(.black)
            
            Divider()
                .frame(height: 30)
            
            TextField("No. Telepon", text: $phoneNumber, onEditingChanged: { changed in
                print("\($phoneNumber)")
                
                //self.registerData.noTelepon = "0" + phoneNumber
            }, onCommit: {
                print("Commited")
                //self.registerData.noTelepon = "0" + phoneNumber
            })
            .keyboardType(.numberPad)
        }
    }
}
