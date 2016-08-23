#
#  Be sure to run `pod spec lint RxMQTT.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name             = "RxMQTT"
    s.version          = "0.1.0"
    s.summary          = "MQTT library for RxSwift"

    s.description      = <<-DESC
    RxMQTT is lightweight and easy to use Rx support for MQTT.
    DESC

    s.homepage         = "https://github.com/ksachdeva/RxSwiftMQTT"
    s.license          = 'MIT'
    s.author           = { "Kapil Sachdeva" => "ksachdeva17@gmail.com" }
    s.source           = { :git => "https://github.com/ksachdeva/RxSwiftMQTT.git", :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/ksachdeva'

    s.ios.deployment_target = '8.0'
    s.osx.deployment_target = '10.10'

    s.requires_arc = true

    s.source_files = 'Source/*.swift'
    s.dependency 'MQTTClient'
    s.dependency 'RxSwift', '~> 2.0'

end
