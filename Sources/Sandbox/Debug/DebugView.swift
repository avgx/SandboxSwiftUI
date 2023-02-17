//
//  DebugView.swift
//  Sandbox
//
//  https://github.com/rrroyal/Harbour/blob/main/Harbour/Views/DebugView.swift
//




import SwiftUI
import OSLog
import UIKit
//import Indicators
import BackgroundTasks
import WidgetKit

#if DEBUG

struct DebugView: View {
//    @EnvironmentObject var sceneState: SceneState
    @State private var pendingBackgroundTasks: [BGTaskRequest] = []
    
    var body: some View {
        List {
            Section("Build") {
//                Labeled(label: "Bundle ID", content: Bundle.main.mainBundleIdentifier, monospace: true, hideIfEmpty: false)
//                Labeled(label: "AppIdentifierPrefix", content: Bundle.main.appIdentifierPrefix, monospace: true, hideIfEmpty: false)
            }
            
//            Section("Background Tasks") {
//                Labeled(label: "Last task", content: Preferences.shared.lastBackgroundTaskDate?.formatted(), hideIfEmpty: false)
//
//                DisclosureGroup("Scheduled tasks") {
//                    ForEach(pendingBackgroundTasks, id: \.identifier) { task in
//                        Text(task.identifier)
//                    }
//                }
//            }
//            .onAppear {
//                Task { pendingBackgroundTasks = await BGTaskScheduler.shared.pendingTaskRequests() }
//            }
            
            Section("UserDefaults") {
                Button("Reset finishedSetup") {
                    UIDevice.generateHaptic(.light)
//                    Preferences.shared.finishedSetup = false
                }
                
                Button("Reset all") {
                    UIDevice.generateHaptic(.heavy)
//                    Preferences.Key.allCases.forEach { Preferences.ud.removeObject(forKey: $0.rawValue) }
                    exit(0)
                }
                .foregroundStyle(.red)
            }
            
            Section {
                NavigationLink(destination: LogsView()) {
                    Text("Logs")
                }
             }
        }
        .navigationTitle("🤫")
    }
}

extension DebugView {
    struct LogsView: View {
        @State private var logs: [LogEntry] = []
        
        var body: some View {
            List(logs, id: \.self) { entry in
                Section(content: {
                    Text(entry.message)
                        .font(.system(.callout, design: .monospaced))
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .textSelection(.enabled)
                }, header: {
                    Text("\(entry.category ?? "<none>") - \(entry.date?.ISO8601Format() ?? "<none>") [\(entry.level?.rawValue ?? -1)]")
                        .font(.system(.footnote, design: .monospaced))
                        .textCase(.none)
                })
            }
            .navigationTitle("Logs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button(action: {
                            UIDevice.generateHaptic(.selectionChanged)
                            UIPasteboard.general.string = logs.map(\.debugDescription).joined(separator: "\n")
                        }) {
                            Label("Copy", systemImage: "doc.on.doc")
                        }
                        
                        Divider()
                        
                        Button(action: {
                            UIDevice.generateHaptic(.light)
                            getLogs()
                        }) {
                            Label("Refresh", systemImage: "arrow.clockwise")
                        }
                    }, label: {
                        Image(systemName: "ellipsis")
                            .symbolVariant(.circle)
                    })
                }
            }
            .onAppear(perform: getLogs)
        }
        
        func getLogs() {
            
            DispatchQueue.main.async {
                do {
                    let logStore = try OSLogStore(scope: .currentProcessIdentifier)
                    let position = logStore.position(date: Date().addingTimeInterval(-(6 * 60 * 60)))
                    let entries = try logStore.getEntries(with: [], at: position, matching: NSPredicate(format: "subsystem CONTAINS[c] %@", Bundle.main.mainBundleIdentifier))
                    logs = entries
                        .compactMap { $0 as? OSLogEntryLog }
                        .map { LogEntry(message: $0.composedMessage, level: $0.level, date: $0.date, category: $0.category) }
                    print("\(logs.count)")
                } catch {
                    logs = [LogEntry(message: error.readableDescription, level: nil, date: nil, category: nil)]
                }
            }
        }
        
        struct LogEntry: Hashable, CustomDebugStringConvertible {
            let message: String
            let level: OSLogEntryLog.Level?
            let date: Date?
            let category: String?
            
            var debugDescription: String {
                "(\(level?.rawValue ?? -1)) \(date?.ISO8601Format() ?? "<none>") [\(category ?? "<none>")] \(message)"
            }
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}

#endif

extension UIDevice {
    enum FeedbackStyle {
        case error, success, warning, light, medium, heavy, soft, rigid, selectionChanged
    }

    /// Generates a haptic feedback/vibration.
    /// - Parameter style: Style of the feedback
    static func generateHaptic(_ style: FeedbackStyle) {
//        guard Preferences.shared.enableHaptics else {
//            return
//        }
//
//        let supportsHaptics = CHHapticEngine.capabilitiesForHardware().supportsHaptics
//        if supportsHaptics {
//            // Haptic Feedback
//            switch style {
//                case .error:    UINotificationFeedbackGenerator().notificationOccurred(.error)
//                case .success:    UINotificationFeedbackGenerator().notificationOccurred(.success)
//                case .warning:    UINotificationFeedbackGenerator().notificationOccurred(.warning)
//                case .light:    UIImpactFeedbackGenerator(style: .light).impactOccurred()
//                case .medium:    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
//                case .heavy:    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
//                case .soft:        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
//                case .rigid:    UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
//                case .selectionChanged: UISelectionFeedbackGenerator().selectionChanged()
//            }
//        } else {
//            // Older devices
//            switch style {
//                case .error:    AudioServicesPlaySystemSound(1521)
//                case .success:    break
//                case .warning:    break
//                case .light:    AudioServicesPlaySystemSound(1519)
//                case .medium:    break
//                case .heavy:    AudioServicesPlaySystemSound(1520)
//                case .soft:        break
//                case .rigid:    break
//                case .selectionChanged: AudioServicesPlaySystemSound(1519)
//            }
//        }
    }
}

public extension Bundle {
    var buildVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }
    
    var mainBundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? "Unknown" // //"xyz.shameful.Harbour"
    }
    
    var appIdentifierPrefix: String? {
        Bundle.main.infoDictionary?["AppIdentifierPrefix"] as? String
    }
}

extension Error {
    var readableDescription: String {
        (self as? LocalizedError)?.errorDescription ?? self.localizedDescription
    }
}

