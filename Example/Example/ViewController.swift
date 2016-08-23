//
//  ViewController.swift
//  Example
//
//  Created by Kapil Sachdeva on 8/23/16.
//  Copyright © 2016 Kapil Sachdeva. All rights reserved.
//

import UIKit
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
            .subscribe(
                onNext: { (result) -> Void in
                    print(result)
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

