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
    let disposeBag = DisposeBag()
    let viewChange = UIView()
    let textEvent = PublishSubject<String>()
    var c = Variable("test")

    //let text:Observable<String> = Observable.s
    override func viewDidLoad() {
        
        ObjcBridge().zipFile()
        
        //let textIsOk = textField.rx.text.orEmpty
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        button.backgroundColor = UIColor.red


        self.view.addSubview(button)
        self.view.addSubview(textField)
        self.view.addSubview(textField2)

        self.view.addSubview(viewChange)
        
        textField.placeholder = "input"
        textField.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(100)
            maker.height.equalTo(100)
        }
        
        textField2.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(100)
            maker.height.equalTo(100)
            maker.top.equalTo(100)
        }
        button.snp.makeConstraints { (maker) in
            maker.center.equalTo(self.view.snp.center)
            maker.width.equalTo(100)
            maker.height.equalTo(100)
            
        }
        
        //b.bind(to:button.rx.title(for: .normal))
        textEvent.bind(to: button.rx.title(for: .normal))
        
        textEvent.onNext("onnext")
//        c.asObservable().bind(to: button.rx.title(for: .normal))
//        c.value = "test2"
        
        c.asObservable().bind(to: textField.rx.text.orEmpty)
        
        textField.text = "1122"
        
//        let lenthValid = textField.rx.text.orEmpty.asDriver().map{
//           //return $0.count > 5
//            return $0 + "11"
//        }
        
        textField.rx.text.orEmpty.asDriver().map{
            
            print("log"+$0)
        }
        //lenthValid.drive(button.rx.title(for: .normal)).disposed(by: disposeBag)
        button.rx.tap.asDriver().do{
            print("test")
        }
        
        let btnSub = button.rx.tap.throttle(1, scheduler: MainScheduler.instance).subscribe {_ in
            //self.button.setTitle("test", for: .normal)
            print("test")
        }

        Observable.zip(textField.rx.text.orEmpty, textField2.rx.text.orEmpty).subscribe { (a) in
            print(a)
 
            print("zip")
        }
        
        //lenthValid
        print(c.value)
        //textField.rx.text.orEmpty.bind(to: button.rx.title(for: .normal)).addDisposableTo(disposeBag)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

