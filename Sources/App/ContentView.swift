//
//  ContentView.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 14.12.2021.
//

import SwiftUI
import Charts
import OSLog

let logger = Logger(subsystem: "Sandbox", category: "main")


struct ContentView: View {
    
    @State var selectedIndex: Int = 0
    var items: [String] = [
            "Years",
            "Months",
            "Days",
            "All Photos"
        ]
    
    @State var tags: [PinTag] = [
        PinTag(id: UUID(), name: "Hello"),
        PinTag(id: UUID(), name: "World")
    ]
    
    init() {
        let obj = "Test"
        logger.info("Logging \(obj.description, privacy: .public)")
        os_log("foo", log: OSLog.default, type: .debug)
    }
    
    var body: some View {
        //        Text("Sandbox!")
        //            .padding()
        //ListItemActions()
        //PopupSample1()
        //ChipsSample1_ContentView()
        //OTPVerificationView()
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [.blue, .green, .yellow, .red],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            SegmentedControl(
                items: items,
                selectedIndex: $selectedIndex
            )
            .padding()
        }
        //ShapeDragging_ContentView()
        //FormSample()
        //TagsField(tags: $tags)
        //   .frame(width: .infinity, height: 48, alignment: .leading)
        //        HomeCustomGridsAndAnimations()
        //        BarChartSample(entries: [
        //            //x - position of a bar, y - height of a bar
        //            BarChartDataEntry(x: 1, y: 1),
        //            BarChartDataEntry(x: 2, y: 2),
        //            BarChartDataEntry(x: 3, y: 1),
        //            BarChartDataEntry(x: 4, y: 4),
        //            BarChartDataEntry(x: 5, y: 1)
        //
        //        ])
        // Catches soft close
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            print("Catched willResignActiveNotification")
        }
        // Catches total destruction
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
            print("Catched willTerminateNotification")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            print("Catched didBecomeActiveNotification")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Encodable {
    func jsonFormatted() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try! JSONEncoder().encode(self)
        return String(data: data, encoding: .utf8)!
    }
}
