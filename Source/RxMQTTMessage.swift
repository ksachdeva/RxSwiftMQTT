//
//  RxMQTTMessage.swift
//  Pods
//
//  Created by Kapil Sachdeva on 8/23/16.
//
//

import Foundation
import MQTTClient

public struct RxMQTTMessage {
    public let topic: String;
    public let payload: NSData;
    public let qos: MQTTQosLevel;
    public let retained: Bool;
    
    init(topic: String, payload:NSData, qos: MQTTQosLevel, retained: Bool) {
        self.topic = topic;
        self.payload = payload;
        self.qos = qos;
        self.retained = retained;
    }
    
}