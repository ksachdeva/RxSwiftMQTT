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

        let rx_mqtt = RxMQTT()
        let params = RxMQTTConnectionParams(
            host:"localhost",
            port:1883,
            clientId:"some-id")
        
        rx_mqtt.connect(params)
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

