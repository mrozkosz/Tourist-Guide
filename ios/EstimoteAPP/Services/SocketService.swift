//
//  SocketService.swift
//  EstimoteAPP
//
//  Created by Mateusz on 21/12/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import SocketIO
import Combine

class SocketService:ObservableObject{
    private var storage = LocalStorage()
    private var manager = SocketManager(socketURL: URL(string: baseUrl)!, config: [.log(true), .compress])
    var socket:SocketIOClient
    var id:Int = 0
    
    let didChange = PassthroughSubject<Void, Never>()
    
    @Published var messages = [commentsDataModel]() {
        didSet { didChange.send() }
    }
    
    
    init() {
        self.socket = manager.defaultSocket
    }
    
    func connect(id:Int){
        self.id = id
        self.socket = manager.defaultSocket
        socket.connect()
        socket.on(clientEvent: .connect) {data, ack in
            
            self.socket.emit("join_room", self.id)
            self.getAllComments()
        }
        
        getAllComments()
    }
    
    func getAllComments(){
        let jsonObject: [String: Any] = ["pleaceId": self.id]
        
        socket.emit("allComments", jsonObject)
        
        socket.on("comments") { data,ack in
            
            do {
                let dat = try JSONSerialization.data(withJSONObject:data)
                let messages = try JSONDecoder().decode([CommentsModel].self,from:dat)
                DispatchQueue.main.async {
                    self.messages = messages.first!.comments
                }
                
            }
            catch {return}
        }
    }
    
    func sendMsg(msg:String){
        let jsonObject: [String: Any] = [
            "token": "Bearer "+storage.token,
            "pleaceId": self.id,
            "message": msg,
        ]
        
        socket.emit("message", jsonObject)
    }
    
}
