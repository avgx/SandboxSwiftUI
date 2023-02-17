//
//  AsyncTest.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 20.04.2022.
//

import Foundation

//            #if targetEnvironment(simulator)
//            return true
//            #else
//return account != nil
//            #endif

class AsyncTest {
    func testAsync() {
//            let client = APIClient(baseUrl: URL(string:"http://try.com:8000/asip-api")!) {
//                $0.sessionConfiguration.httpAdditionalHeaders = ["Authorization": "Basic cm9vdDpyb290"]
//                $0.sessionDelegate = PulseCore.URLSessionProxyDelegate()
//            }
        //let user: User = try await client.send(.get("/user")).value
        
//            Task {
////                async let detail1 = client.send(Paths.productVersion.getString).value
////                async let detail2 = client.send(Paths.cameraList.get).value
////
////                let v = try await detail1
////                let v2 = try await detail2
////                print(v)
////                print(v2)
//                //                 let details = try await [detail1, detail2]
//                //                print(details)
//            }
        
        //            // When
        //            let task = Task {
        //                try await client.send(.get("/users/kean"))
        //            }
        //
        //            DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(100)) {
        //                task.cancel()
        //            }
        //
        //            // Then
        //            do {
        //                let _ = try await task.value
        //            } catch {
        //                XCTAssertTrue(error is URLError)
        //                XCTAssertEqual((error as? URLError)?.code, .cancelled)
        //            }
        //
        //            Task {  //Task(priority: .background)
        //                let v = try await client.send(Paths.productVersion.getString).value
        //                print(v)
        //                let v2 = try await client.send(Paths.cameraList.get).value
        //                print(v2)
        //            }
    }
}
