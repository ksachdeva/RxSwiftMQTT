//
//  MQTTConnectionParams.swift
//
//  Created by Kapil Sachdeva on 8/23/16.
//
//

import Foundation
import MQTTClient

public struct RxMQTTConnectionParams {
    let transport: MQTTTransport;
    let clientId: String;
    let keepAlive: UInt16;
    let cleanSession: Bool;
    
    public init(
        transport: MQTTTransport,
        clientId:String,
        keepAlive:UInt16?=nil,
        cleanSession:Bool?=nil) {
        
        self.transport = transport;
        self.clientId  = clientId;
        self.cleanSession = cleanSession ?? true;
        self.keepAlive = keepAlive ?? 60;
    }
}