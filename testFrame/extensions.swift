//
//  extensions.swift
//  testFrame
//
//  Created by xianhuanlin on 2017/12/27.
//  Copyright © 2017年 xianhuanlin. All rights reserved.
//

import Foundation


extension NSObject{
    func doAsyncAfter(second: Double, toDo:@escaping ()->Void ){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + second){
            toDo()
        }
    }
}
