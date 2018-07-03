//
//  ViewController.swift
//  TouchID
//
//  Created by Spring on 2018/7/2.
//  Copyright © 2018年 MOKO. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.verification()
    }

    func verification() -> Void {
        let context = LAContext()
        context.localizedFallbackTitle = "忘记密码"
        var error:NSError?
        if(context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)){
            print("支持指纹识别")
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请按home键指纹解锁") { (success, err) in
                if(success){
                    print("验证成功 刷新主界面")
                    DispatchQueue.main.async(execute: {
                        self.view.backgroundColor = UIColor.red
                    })
                }else{
                    let tmpError = err! as NSError
                    print(tmpError.code)
                    if(tmpError.code == LAError.authenticationFailed.rawValue){
                        print("authenticationFailed")//用户未提供有效证书,(3次机会失败 --身份验证失败)
                    }else if(tmpError.code == LAError.userCancel.rawValue){
                        print("userCancel")//认证被取消,(用户点击取消按钮)
                    }else if(tmpError.code == LAError.userFallback.rawValue){
                        print("userFallback")//认证被取消,用户点击回退按钮(输入密码
                    }else if(tmpError.code == LAError.systemCancel.rawValue){
                        print("systemCancel")//身份验证被系统取消,(比如另一个应用程序去前台,切换到其他 APP)
                    }else if(tmpError.code == LAError.passcodeNotSet.rawValue){
                        print("passcodeNotSet")//身份验证无法启动,因为密码在设备上没有设置
                    }else if(tmpError.code == LAError.touchIDNotAvailable.rawValue){
                        print("touchIDNotAvailable")//身份验证无法启动,因为触摸ID在设备上不可用
                    }else if(tmpError.code == LAError.touchIDNotEnrolled.rawValue){
                        print("touchIDNotEnrolled")//身份验证无法启动,因为没有登记的手指触摸ID。 没有设置指纹密码时
                    }else if(tmpError.code == LAError.notInteractive.rawValue){
                        print("notInteractive")
                    }
                    //iOS 9.0之后
                    else if(tmpError.code == LAError.touchIDLockout.rawValue){
                        print("touchIDLockout")
                    }else if(tmpError.code == LAError.appCancel.rawValue){
                        print("appCancel")
                    }else if(tmpError.code == LAError.invalidContext.rawValue){
                        print("invalidContext")
                    }else if(tmpError.code == LAError.invalidContext.rawValue){
                        print("invalidContext")
                    }else if(tmpError.code == LAError.invalidContext.rawValue){
                        print("invalidContext")
                    }
                    //iOS11.0 之后
                    else if(tmpError.code == LAError.biometryNotAvailable.rawValue){
                        print("biometryNotAvailable")
                    }else if(tmpError.code == LAError.biometryNotEnrolled.rawValue){
                        print("biometryNotEnrolled")
                    }else if(tmpError.code == LAError.biometryLockout.rawValue){
                        print("biometryLockout")
                    }
                }
            }
        }else{
            print("不支持指纹识别")
            print(error?.code as Any)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

