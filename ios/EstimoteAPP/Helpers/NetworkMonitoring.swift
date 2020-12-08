//
//  NetworkMonitoring.swift
//  EstimoteAPP
//
//  Created by Mateusz on 04/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Network
import SwiftUI

class NetworkMonitoring:ObservableObject{
    
    static let shared = NetworkMonitoring()
    
    
    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true
    @Published var isVisible:Bool = false
    @Published var isConnected:Bool = false
    
    init() {
        self.startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
            
            DispatchQueue.main.async {
                self?.isVisible = true
            }
            
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self?.isConnected = true
                }
            } else {
                DispatchQueue.main.async {
                    self?.isConnected = false
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.isVisible = false
            }
            
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}


struct ConnectionStatus: View {
    @ObservedObject var network = NetworkMonitoring.shared
    
    var body: some View {
        VStack{
            Spacer()
            
            if(network.isConnected && network.isVisible){
                
                Text("Połączono")
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
            }else if(!network.isConnected && network.isVisible){
                
                Text("Utracono połączenie")
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
            }
        }.animation(.easeOut)
        
    }
}


struct ConnectionStatus_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionStatus()
    }
}
