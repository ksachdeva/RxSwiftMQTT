//
//  RxMQTT.swift
//
//  Created by Kapil Sachdeva on 8/23/16.
//
//

import Foundation
import RxSwift
import MQTTClient

public class RxMQTT : NSObject {
    
    private var session : MQTTSession?;
    
    public func connect(options: RxMQTTConnectionParams) -> Observable<Bool> {
        
        self.session = MQTTSession();
        self.session?.keepAliveInterval = options.keepAlive;
        self.session?.cleanSessionFlag = options.cleanSession;
        self.session?.clientId = options.clientId;
        
        return Observable.create({ (observer) -> Disposable in
            self.session!.connectToHost(options.host, port: options.port, usingSSL: false) {
                error in
                if (error != nil) {
                    observer.onError(error)
                } else {
                    observer.onNext(true)
                    observer.onCompleted()
                }
            }
            return AnonymousDisposable{
            }
        });
    }
    
    public func disconnect() -> Observable<Bool> {
        return Observable.create({ (observer) -> Disposable in
            self.session!.closeWithDisconnectHandler() {
                error in
                if (error != nil) {
                    observer.onError(error)
                } else {
                    observer.onNext(true)
                    observer.onCompleted()
                }
            }
            return AnonymousDisposable{
            }
        });
    }
}