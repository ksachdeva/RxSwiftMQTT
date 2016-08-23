//
//  ViewController.swift
//  Example
//
//  Created by Kapil Sachdeva on 8/23/16.
//  Copyright © 2016 Kapil Sachdeva. All rights reserved.
//

import UIKit
import MQTTClient
import RxMQTT

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let transport = MQTTCFSocketTransport();
        transport.host = "localhost";
        transport.port = 1883;
        
        let params = RxMQTTConnectionParams(
            transport:transport,
            clientId:"some-id")
        
        let rx_mqtt = RxMQTT(options: params)
        
        rx_mqtt.connect()
            .flatMap { status in
                return rx_mqtt.subscribe("topic/path2", qos:MQTTQosLevel.AtMostOnce)
            }
            .flatMap({ status in
                return rx_mqtt.rx_didReceiveNewMessage;
            })
            .subscribe(
                onNext: { (result: RxMQTTMessage) -> Void in
                    //
                    print(String(data:result.payload, encoding: NSUTF8StringEncoding)!)
                },
                onError: { (error) -> Void in
                    print(error)
                },
                onCompleted: { () -> Void in
                    print("completed")
                }
            )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

