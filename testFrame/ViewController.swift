//
//  ViewController.swift
//  testFrame
//
//  Created by xianhuanlin on 2017/8/30.
//  Copyright © 2017年 xianhuanlin. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import Alamofire
import SnapKit

//extension NSObject{
//    func doAsynAfter(time:Double, action: ( ()->Void )?){
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time){
//            action?()
//        }
//    }
//}

class ViewController: UIViewController {
    
    let textField = UITextField()
    let textField2 = UITextField()
    let button = UIButton()
    let button2 = UIButton()
    let disposeBag = DisposeBag()
    let viewChange = UIView()
    let textEvent = PublishSubject<String>()
    var c = Variable("test")

    //let text:Observable<String> = Observable.s
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
//        self.doAsyncAfter(second: 3) {
//            let vc = wxViewController()
//            self.addChildViewController(vc)
//            self.view.addSubview(vc.view)
//            //self.present(vc, animated: true, completion: nil)
//        }
        ObjcBridge().zipFile()
        
        //let textIsOk = textField.rx.text.orEmpty

        self.view.backgroundColor = UIColor.gray
        button.backgroundColor = UIColor.red
        button.setTitleColor(UIColor.gray, for: .disabled)
        button2.backgroundColor = UIColor.red
        button2.setTitleColor(UIColor.gray, for: .disabled)
        
        self.view.addSubview(button)
        self.view.addSubview(textField)
        self.view.addSubview(textField2)
        self.view.addSubview(button2)
        self.view.addSubview(viewChange)
        button.setTitle("打开1", for: .normal)
        button2.setTitle("打开2", for: .normal)
        
        textField.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(self.view.snp.width).offset(-30)
            maker.height.equalTo(30)
            maker.top.equalTo(100)
        }
        
        textField2.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(self.view.snp.width).offset(-30)
            maker.height.equalTo(30)
            maker.top.equalTo(150)
        }
        button.snp.makeConstraints { (maker) in
            maker.center.equalTo(self.view.snp.center)
            maker.width.equalTo(100)
            maker.height.equalTo(100)
            
        }
        button2.snp.makeConstraints { (maker) in
            maker.top.equalTo(button.snp.bottom).offset(10)
            maker.width.equalTo(100)
            maker.height.equalTo(100)
            maker.centerX.equalTo(button)
        }
        textField.placeholder = "输入端口号"
        textField2.placeholder = "输入链接"
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 0.5
        
        textField2.backgroundColor = UIColor.white
        textField2.layer.borderColor = UIColor.black.cgColor
        textField2.layer.cornerRadius = 4
        textField2.layer.borderWidth = 0.5

        //textEvent.onNext("onnext")
//        c.asObservable().bind(to: button.rx.title(for: .normal))
//        c.value = "test2"
        
        //c.asObservable().bind(to: textField.rx.text.orEmpty)
        
        //textField.text = "1122"
        textField.text = "http://10.66.48.126:8081/dist/test1.js"
        textField2.text = "http://192.168.0.105:8081/dist/test1.js"
        let lenthValid = textField.rx.text.orEmpty.asDriver().map{
           //return $0.count > 5
            return $0.count > 1
        }
        
        button.rx.tap.subscribe { _ in
            self.navToUrl(self.textField.text!)
        }
        button2.rx.tap.subscribe { _ in
            self.navToUrl(self.textField2.text!)
        }
//        let valid = Observable.combineLatest(textField.rx.text.orEmpty, textField2.rx.text.orEmpty).map {
//            return $0.count > 0 || $1.count > 0
//            }.bind(to: button.rx.isEnabled)
        

        //lenthValid
        print(c.value)
        //textField.rx.text.orEmpty.bind(to: button.rx.title(for: .normal)).addDisposableTo(disposeBag)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navToPort(_ port:String){
        let vc = wxViewController();
        vc.url = "http://10.66.48.126:" + port + "/examples/build/vue/index.js";
        
        let nav = UINavigationController.init(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
         
    }
    
    func navToUrl(_ url:String){
        let vc = wxViewController();
        vc.url = url
        
//        let nav = UINavigationController.init(rootViewController: vc)
//        self.present(nav, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

