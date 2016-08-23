//
//  MQTTConnectionParams.swift
//
//  Created by Kapil Sachdeva on 8/23/16.
//
//

import Foundation

public struct RxMQTTConnectionParams {
    var host: String;
    var port: UInt32;
    var clientId: String;
    var keepAlive: UInt16;
    var cleanSession: Bool;
    
    public init(
        host:String,
        port:UInt32,
        clientId:String,
        keepAlive:UInt16?=nil,
        cleanSession:Bool?=nil) {
        
        self.host = host;
        self.port = port;
        self.clientId = clientId;
        self.cleanSession = cleanSession ?? true;
        self.keepAlive = keepAlive ?? 60;
    }
}