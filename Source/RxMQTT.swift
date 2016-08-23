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
    private let internalDelegate = InternalDelegate()
    
    /// Observable which infroms when a new message is received
    public var rx_didReceiveNewMessage: Observable<RxMQTTMessage> {
        return internalDelegate.didReceiveNewMessageSubject;
    }
    
    public func connect(options: RxMQTTConnectionParams) -> Observable<Bool> {
        
        self.session = MQTTSession();
        self.session?.keepAliveInterval = options.keepAlive;
        self.session?.cleanSessionFlag = options.cleanSession;
        self.session?.clientId = options.clientId;
        self.session?.delegate = internalDelegate;
        
        return Observable.create({ (observer) -> Disposable in
            self.session!.connectToHost(options.host, port: options.port, usingSSL: false) {
                error in
                if (error != nil) {
                    observer.onError(error);
                } else {
                    observer.onNext(true);
                    observer.onCompleted();
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
                    observer.onError(error);
                } else {
                    observer.onNext(true);
                    observer.onCompleted();
                }
            }
            return AnonymousDisposable{
            }
        });
    }
    
    public func publish(options: RxMQTTPublishParams) -> Observable<Bool> {
        return Observable.create({ (observer) -> Disposable in
            self.session!.publishData(
                options.payload,
                onTopic: options.topic,
                retain: options.retain,
                qos: options.qos) {
                error in
                if ((error) != nil) {
                    observer.onError(error);
                } else {
                    observer.onNext(true);
                    observer.onCompleted();
                }
            }
            return AnonymousDisposable{
            }
        });
    }
    
    public func subscribe(topic:String, qos: MQTTQosLevel) -> Observable<Bool> {
        return Observable.create({ (observer) -> Disposable in
            self.session!.subscribeToTopic(topic, atLevel: qos) {
                (error, code) in
                if ((error) != nil) {
                    observer.onError(error);
                } else {
                    observer.onNext(true);
                    observer.onCompleted();
                }
            }
            return AnonymousDisposable{
            }
        });
    }
    
    public func unsubscribe(topic:String) -> Observable<Bool> {
        return Observable.create({ (observer) -> Disposable in
            self.session!.unsubscribeTopic(topic) {
                (error) in
                if ((error) != nil) {
                    observer.onError(error);
                } else {
                    observer.onNext(true);
                    observer.onCompleted();
                }
            }
            return AnonymousDisposable{
            }
        });
    }
    
    
    @objc private class InternalDelegate : NSObject, MQTTSessionDelegate {
     
        let didReceiveNewMessageSubject = PublishSubject<RxMQTTMessage>();
     
        @objc func newMessage(session: MQTTSession!, data: NSData!, onTopic topic: String!, qos: MQTTQosLevel, retained: Bool, mid: UInt32) {
            didReceiveNewMessageSubject.onNext(RxMQTTMessage(
                topic: topic!,
                payload: data!,
                qos: qos,
                retained: retained));
        }
        
    }
    
    
}