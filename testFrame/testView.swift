//
//  testView.swift
//  testFrame
//
//  Created by xianhuanlin on 2018/4/2.
//  Copyright © 2018年 xianhuanlin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class testView: UIView {

    let btn1 = UIButton()
    let btn2 = UIButton()
    let scroll1 = UIWebView()
    let scroll2 = UIWebView()
    //    let scroll1 = UIScrollView()
    //    let scroll2 = UIScrollView()
    let view1 = UIView.init()
    let view2 = UIView.init()
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let viewHit = super.hitTest(point, with: event)
        if viewHit == scroll2.subviews[0].subviews[0]{
            return scroll1.subviews[0].subviews[0];
        }
        return viewHit;
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initScroll()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        self.backgroundColor = UIColor.gray
        self.addSubview(btn1)
        self.addSubview(btn2)
        btn1.backgroundColor = UIColor.red
        btn2.backgroundColor = UIColor.green
        
        btn1.snp.makeConstraints { (maker) in
            maker.center.equalTo(self.snp.center)
            maker.width.equalTo(100)
            maker.height.equalTo(100)
            
        }
        btn2.snp.makeConstraints { (maker) in
            maker.top.equalTo(btn1.snp.bottom).offset(10)
            maker.width.equalTo(100)
            maker.height.equalTo(100)
            maker.centerX.equalTo(btn1)
        }
        
        
        btn1.rx.tap.subscribe { _ in
            //            self.navToUrl(self.textField.text!)
            NSLog("btn1")
        }
        btn2.rx.tap.subscribe { _ in
            NSLog("btn2")
        }
    }

    
    func initScroll(){
        scroll1.frame = self.bounds
        scroll1.height = self.height/2
        scroll1.scrollView.contentSize = self.bounds.size;
        scroll2.frame = self.bounds
        scroll2.height = self.height/2
        scroll2.scrollView.contentSize = self.bounds.size;
        scroll2.top = scroll1.height
        view1.frame = self.bounds
        view2.frame = self.bounds

        view1.backgroundColor = UIColor.red
        view2.backgroundColor = UIColor.green
        
        self.addSubview(scroll1)
        self.addSubview(scroll2)
//        scroll1.addSubview(view1)
//        scroll2.addSubview(view2)
        
        scroll1.loadRequest(URLRequest.init(url: URL.init(string: "http://www.baidu.com")!))
        
        scroll2.loadRequest(URLRequest.init(url: URL.init(string: "http://www.baidu.com")!))
        
//        scroll1.backgroundColor = UIColor.red
//        scroll2.backgroundColor = UIColor.green
        
    }
}
