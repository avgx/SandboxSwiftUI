//
//  WebsocketTestView.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 20.04.2022.
//

import SwiftUI

struct WebsocketTestView: View {
    
    private let stream = WebSocketStream(url: "wss://test2.axxoncloud.com/dc2-c1/2_0/webclient/events?authToken=123456&proxyPrefix=undefined")
    
    
    private let json = """
    {
        "include": [
            "hosts/Node-HHiiwQwlLd-2-6/DeviceIpint.2/SourceEndpoint.video:0:0",
            "hosts/Node-izeUrYpQTW-2-4/DeviceIpint.1/SourceEndpoint.video:0:0",
            "hosts/Node-izeUrYpQTW-2-4/DeviceIpint.2/SourceEndpoint.video:0:0"
        ]
    }
    """
    
    var body: some View {
        NavigationView {
            List {
                Text("WebsocketTestView")
            }
            .navigationTitle("Courses")
        }
        .task {
            do {
                stream.sendString(json)
                for try await message in stream {
                    //print(message)
                    switch message {
                    case .string(let s):
                        print(s)
                    case .data(let d):
                        print("data \(d.count)")
                    }
                }
            } catch {
                debugPrint("Oops something didn't go right")
            }
//            do {
//                for try await message in stream {
//                    let updateDevice = try message.device()
//                    devices = devices.map({ device in
//                        device.id == updateDevice.id ? updateDevice : device
//                    })
//                }
//            } catch {
//                debugPrint("Oops something didn't go right")
//            }
        }
    }
}

//enum WebSocketError: Error {
//    case invalidFormat
//}
//
//extension URLSessionWebSocketTask.Message {
//    func device() throws -> Device {
//        switch self {
//        case .string(let json):
//            let decoder = JSONDecoder()
//            guard let data = json.data(using: .utf8) else {
//                throw WebSocketError.invalidFormat
//            }
//            let message = try decoder.decode(Message.self, from: data)
//            return message.device
//        case .data:
//            throw WebSocketError.invalidFormat
//        @unknown default:
//            throw WebSocketError.invalidFormat
//        }
//    }
//}
