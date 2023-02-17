//
//  SettingsSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 13.07.2022.
//

import SwiftUI
import StoreKit

struct SettingsSample: View {
    
    @Environment(\.dismiss) var dismiss
    
    //    @State private var birthDate = Date()
    
    
    
    var body: some View {
        NavigationView {
            Root()
            //            Section {
            //                applyButton//.buttonStyle(OutlineButton())
            //                    .listRowInsets(EdgeInsets())
            //            }
                .navigationTitle(LocalizedStringKey("Settings"))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    //    private var applyButton: some View {
    //        Button(action: {
    //            print("apply")
    //        }) {
    //            Text("Apply")
    //                .frame(height: 48)
    //                .frame(maxWidth: .infinity, maxHeight: 48)
    //        }
    //        .buttonStyle(SwitchColorButtonStyle())
    //    }
    
//    struct SwitchColorButtonStyle: ButtonStyle {
//        func makeBody(configuration: Self.Configuration) -> some View {
//            configuration.label
//                .foregroundColor(configuration.isPressed ? Color.accentColor : Color.white)
//                .background(configuration.isPressed ? Color.white : Color.accentColor)
//        }
//    }
    
}

extension SettingsSample {
    struct Root: View {
        var body: some View {
            Form {
                Section(header: Text(LocalizedStringKey("General"))) {
                    NavigationLink(HelpAndFeedback.title, destination: {
                        HelpAndFeedback()
                    })
                }
                
                Section(header: Text(LocalizedStringKey("Accounts"))) {
                    NavigationLink(destination: { Account() }) {
                        HStack(spacing: 8){
                            Image(systemName: "cloud")
                            VStack(alignment: .leading, spacing: 8) {
                                Text(verbatim: "a@ru.com")
                                    .lineLimit(1)
                                    .textContentType(.username)
                                    .font(.headline)
                                Text(verbatim: "https://vmscloud.local")
                                    .lineLimit(1)
                                    .textContentType(.URL)
                                    .font(.subheadline)
                            }
                            Spacer()
                        }
                    }
                    Button(action: { }) {
                        Text("Add Account")
                    }
                }
                
                Section(header: Text("Preferences")) {
                    NavigationLink(Cloud.title, destination: {
                        Cloud()
                    })
                    NavigationLink(Ui.title, destination: {
                        Ui()
                    })
                    NavigationLink(Security.title, destination: {
                        Security()
                    })
                    NavigationLink("Notifications", destination: {
                        Notifications()
                    })
                }
                
                Section(header: Text("More")) {
                    
                }
            }
        }
    }
    
}

extension SettingsSample {
    struct HelpAndFeedback: View {
        static let title = "Help & Feedback"
        
        let buildVersion = Bundle.main.buildVersion
        let buildNumber = Bundle.main.buildNumber
        
        var body: some View {
            Form {
                Section(header: Text(HelpAndFeedback.title)) {
                    Link("Contact support", destination: URL(string: "https://yandex.com")!)
                    Link("Privacy policy", destination: URL(string: "https://yandex.com")!)
                    //Link("AppStore rating", destination: URL(string: "https://yandex.com")!)
                    Button(action: {
                        SKStoreReviewController.requestReview()
                    }) {
                        Text("AppStore rating")
                    }
                }
                
                Section(header: Text("Troubleshooting")) {
                    NavigationLink("Debug", destination: {
                        Debug()
                    })
//                    Button(action: { }) {
//                        Text("Logs")
//                    }
                    NavigationLink(destination: DebugView.LogsView()) {
                        Text("Logs")
                    }
                }
                
                Section(header: Text("About"), footer: HStack {
                    Spacer()
                    Text("Version: \(buildVersion) (\(buildNumber))")
                    Spacer()
                }) {
                    Link("Privacy policy", destination: URL(string: "https://yandex.com")!)
                }
                
                Section {
                    
                    
                }
            }
            .navigationTitle(HelpAndFeedback.title)
        }
    }
}

extension SettingsSample {
    struct Account: View {
        
        var body: some View {
            Form {
                
                Section {
                    
                }
            }
        }
    }
}

extension SettingsSample {
    struct Ui: View {
        static let title = "UI"
        
        var body: some View {
            Form {
                
                Section {
                    
                    NavigationLink("Video player", destination: {
                        VideoPlayer()
                    })
                    NavigationLink("Camera list", destination: {
                        CameraList()
                    })
                    NavigationLink("Camera", destination: {
                        Camera()
                    })
                }
            }
            .navigationTitle(Ui.title)
        }
    }
    
    struct Security: View {
        static let title = "Security"
        
        @AppStorage("ssl_enable_selfsigned_cert")
        var ssl_enable_selfsigned_cert: Bool = true
        @AppStorage("ssl_enable_silent_redirect")
        var ssl_enable_silent_redirect: Bool = true
        
        @State var requireTouchId: Bool = false
        var body: some View {
            Form {
                Section(header:  Text("SSL")) {
                    Toggle(isOn: $ssl_enable_selfsigned_cert) {
                        Text("Enable self-signed certificates")
                    }
                    Toggle(isOn: $ssl_enable_silent_redirect) {
                        Text("Enable redirect http->https")
                    }
                }
                Section {
                    Toggle(isOn: $requireTouchId) {
                        Text("Require Touch ID")
                    }
                }
            }
            .navigationTitle(Security.title)
        }
    }
    
    struct VideoPlayer: View {
        enum Mode: Int, CaseIterable {
            case H264 = 0
            case MJPEG = 1
        }
        
        enum StreamMode: Int, CaseIterable {
            case first = 0
            case light = 1
            case best = 2
        }
        
        enum ResolutionMode: Int, CaseIterable {
            case _1080 = 1080
            case _720 = 720
            case _576 = 576
            case _288 = 288
        }
        
        enum FpsMode: Int, CaseIterable {
            case _30 = 30
            case _12 = 12
            case _6 = 6
            case _3 = 3
        }
        
        @AppStorage("video_player")
        var video_player: Int = 0
        
        @AppStorage("video_stream")
        var video_stream: Int = 0
        
        @AppStorage("quality_video_resolution")
        var quality_video_resolution = 720
        
        @AppStorage("quality_video_fps")
        var quality_video_fps = 6
        
        var body: some View {
            Form {
                
                Section {
                    Picker(LocalizedStringKey("Mode"), selection: $video_player) {
                        Text("H264").tag(Mode.H264.rawValue)
                        Text("MJPEG").tag(Mode.MJPEG.rawValue)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker(LocalizedStringKey("Stream"), selection: $video_stream) {
                        Text("First").tag(StreamMode.first.rawValue)
                        Text("Light (lowest bitrate)").tag(StreamMode.light.rawValue)
                        Text("Best quality").tag(StreamMode.best.rawValue)                        
                    }
                    //.pickerStyle(MenuPickerStyle())
                    if video_player == Mode.MJPEG.rawValue {
                        Picker(LocalizedStringKey("Quality"), selection: $quality_video_resolution) {
                            Text("1080p HD").tag(ResolutionMode._1080.rawValue)
                            Text("720p HD").tag(ResolutionMode._720.rawValue)
                            Text("576p 4CIF").tag(ResolutionMode._576.rawValue)
                            Text("288p CIF").tag(ResolutionMode._288.rawValue)
                        }
                        //.pickerStyle(MenuPickerStyle())
                        Picker(LocalizedStringKey("Fps"), selection: $quality_video_fps) {
                            Text("Max").tag(FpsMode._30.rawValue)
                            Text("12").tag(FpsMode._12.rawValue)
                            Text("6").tag(FpsMode._6.rawValue)
                            Text("3").tag(FpsMode._3.rawValue)
                        }
                        //.pickerStyle(MenuPickerStyle())
                    }
                }
            }
        }
    }
    
    struct Notifications: View {
        @AppStorage("notification_include_snapshot")
        var notification_include_snapshot: Bool = false
        
        var body: some View {
            Form {
                Section {
                    Toggle(isOn: $notification_include_snapshot) {
                        Text("Include snapshot")    //TODO: replace with picker none/image/video
                    }
                }
            }
        }
    }
    struct Cloud: View {
        static let title = "Cloud"
        
        private static let defaultUrl: String = "https://yandex.ru"
        @AppStorage("settings.cloud.api.debug")
        var cloudUrl: String = Cloud.defaultUrl
        
        @State var cloudUrlEdit = ""
        
        private func validateUrl() {
            print(#function)
            print(cloudUrlEdit)
            print(cloudUrl)
            cloudUrl = cloudUrlEdit
        }
        
        var body: some View {
            Form {
                
                Section(header: Text(Cloud.title)) {
                    TextField("URL", text: $cloudUrlEdit)
                        .textInputAutocapitalization(.never)
                        .textContentType(.URL)
                        .disableAutocorrection(true)
                        .keyboardType(.URL)
                        .submitLabel(.done)
                        .onAppear {
                            cloudUrlEdit = cloudUrl
                        }
                        .onChange(of: cloudUrlEdit) { newValue in
                            print(newValue)
//                            if validation(newValue) {
//                                self.sourceText = newValue
//                            } else {
//                              self.text = sourceText
//                            }
                        }
                        .onSubmit {
                            validateUrl()
                        }
                    if cloudUrl != Cloud.defaultUrl {
                        Button(action: {
                            cloudUrl = Cloud.defaultUrl
                            cloudUrlEdit = Cloud.defaultUrl
                        }) {
                            Text("Set Default")
                        }
                    }
                }
            }
            .navigationTitle(Cloud.title)
        }
    }
    
    struct Debug: View {
        
        @AppStorage("debug_apns_enabled.cloud.api.debug")
        var debug_apns_enabled: Bool = false
        
        @AppStorage("netfox_enabled.cloud.api.debug")
        var netfox_enabled: Bool = false
        
        var body: some View {
            Form {
                
                Section {
                    Toggle(isOn: $netfox_enabled) {
                        Text("Shake to view logs")
                    }
                    Toggle(isOn: $debug_apns_enabled) {
                        Text("APNS debug button")
                    }
                }
            }
        }
    }
    
}

extension SettingsSample.Ui {
    struct CameraList: View {
        enum ResolutionMode: Int, CaseIterable {
            case _720 = 720
            case _576 = 576
            case _288 = 288
            case _144 = 144
        }
        
        enum FpsModeX10: Int, CaseIterable {
            case _30 = 30
            case _10 = 10
            case _3 = 3
            case _1 = 1
        }
        
        @AppStorage("quality_video_livepreview")
        var quality_video_livepreview: Bool = true
        
        @AppStorage("quality_preview_resolution")
        var quality_preview_resolution = 288
        
        @AppStorage("quality_preview_fps_x10")
        var quality_preview_fps_x10 = 10
        
        var body: some View {
            Form {
                
                Section(header: Text("Cell")) {
                    Picker(LocalizedStringKey("Quality"), selection: $quality_preview_resolution) {
                        Text("720p HD").tag(ResolutionMode._720.rawValue)
                        Text("576p 4CIF").tag(ResolutionMode._576.rawValue)
                        Text("288p CIF").tag(ResolutionMode._288.rawValue)
                        Text("144p QCIF").tag(ResolutionMode._144.rawValue)
                    }
                    //.pickerStyle(MenuPickerStyle())
                    
                    Toggle(isOn: $quality_video_livepreview) {
                        Text("Live MJPEG stream")
                    }
                    
                    Picker(LocalizedStringKey("Fps"), selection: $quality_preview_fps_x10) {
                        Text("3").tag(FpsModeX10._30.rawValue)
                        Text("1").tag(FpsModeX10._10.rawValue)
                        Text("1/3").tag(FpsModeX10._3.rawValue)
                        Text("1/10").tag(FpsModeX10._1.rawValue)
                    }
                    //.pickerStyle(MenuPickerStyle())
                }
            }
        }
    }
    
    struct Camera: View {
        
        var body: some View {
            Form {
                
                Section {
                    Text("aaa")
                }
            }
        }
    }
}
