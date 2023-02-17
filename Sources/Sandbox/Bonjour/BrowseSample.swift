//
//  BrowseSample.swift
//  Sandbox
//
//  Created by Alexey Govorovsky on 18.08.2022.
//

import SwiftUI

struct BrowseSample: View {
    
    @State var model = Model()
    
    var body: some View {
        Text("Browse services")
            .onAppear {
                model.startSearch()
            }
            .onDisappear {
                model.stopSearch()
            }
    }
}

extension BrowseSample {
    class Model: NSObject, NetServiceBrowserDelegate, NetServiceDelegate {
        private let netServiceBrowser = NetServiceBrowser()
        let type = "_vms_client_auth._tcp."
        
        var    isSearching = false
        private var servicesBeingResolved = Set<NetService>()
        
        func startSearch() {
            // Check if searching
            if self.isSearching {
                // Stop
                self.netServiceBrowser.stop()
            }
            
            print("NetServiceBrowser starting service search for \(self.type)")
            
            // Start search
            self.netServiceBrowser.delegate = self
            self.netServiceBrowser.searchForServices(ofType: self.type, inDomain: "local.")
            self.isSearching = true
        }
        
        func stopSearch() {
            guard self.isSearching else { return }
            
            print("NetServiceSubscriber: stopping service search for \(self.type)")
            self.netServiceBrowser.stop()
            self.isSearching = false
            self.servicesBeingResolved.removeAll()
        }
        
        func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
            print("\(#function) \(service.name) \(service.port) \(service.debugDescription)")
            
            servicesBeingResolved.insert(service)
            service.delegate = self
            service.resolve(withTimeout: 10.0)
        }
        
        func netServiceBrowser(_ browser :NetServiceBrowser, didRemove service :NetService, moreComing :Bool) {
            print("\(#function) '\(service.name)' \(service.port) \(service.debugDescription)")
        }
        
        func netServiceDidResolveAddress(_ service :NetService) {
            self.servicesBeingResolved.remove(service)
            let addresses = service.addresses!
            print("NetServiceSubscriber: service \(service.type) '\(service.name)' resolved to \(service.hostName ?? "<UNKNOWN>"):\(service.port)")
            //print(addresses)
            let a = service.addresses?
                .compactMap ({ InternetAddress(data: $0) })
                .filter({ $0.isIpv4 })
                .map({ $0.host })
                .filter({ $0 != "127.0.0.1"}) ?? []
            print(a)
            
            if let txtRecord = service.txtRecordData() {
                let potentialServiceDict = NetService.dictionary(fromTXTRecord: txtRecord) as NSDictionary
                print(potentialServiceDict)
                // This fixes a crash in 0.110, the root cause is the dictionary returned
                // above contains NSNull instead of NSData, which Swift will crash trying
                // to cast to the Swift dictionary. So we do it the hard way.
                let serviceDict = (potentialServiceDict as? [String: Any])?
                    .compactMapValues( {
                        return $0 as? Data != nil
                            ? String(data: $0 as! Data, encoding: .utf8)
                            : nil
                    }) ?? [:]
                
                print(serviceDict)
            }
        }
        func netService(_ service :NetService, didNotResolve errorDict :[String : NSNumber]) {
            self.servicesBeingResolved.remove(service)
            print("NetServiceSubscriber: service \(service.type) '\(service.name)' could not be resolved")
        }
    }
    
    
}
