//
//  RxMQTTPublishParams.swift
//  Pods
//
//  Created by Kapil Sachdeva on 8/23/16.
//
//

import Foundation
import MQTTClient

public struct RxMQTTPublishParams {
    var topic: String;
    var payload: NSData;
    var retain: Bool;
    var qos: MQTTQosLevel;
    
    public init(
        topic: String,
        payload: NSData,
        retain:Bool=false,
        qos:MQTTQosLevel=MQTTQosLevel.AtMostOnce) {
        
        self.topic = topic;
        self.payload = payload;
        self.retain = retain;
        self.qos = qos;
    }
}