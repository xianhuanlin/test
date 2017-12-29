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

extension UIView{
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }

    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }

    public var top: CGFloat{
        get{
            return self.frame.origin.y;
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }

    public var left: CGFloat{
        get{
            return self.frame.origin.x;
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }

    public var bottom: CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height;
        }
        set{
            var r = self.frame
            r.origin.y = newValue - self.frame.size.height
            self.frame = r
        }
    }

    public var right: CGFloat{
        get{
            return self.frame.origin.x + self.frame.size.width;
        }
        set{
            var r = self.frame
            r.origin.x = newValue - self.frame.size.width
            self.frame = r
        }
    }

    public var centerH: CGFloat{
        get{
            return self.center.x
        }
        set{
            var p = self.center
            p.x = newValue
            self.center = p
        }
    }

    public var centerV: CGFloat{
        get{
            return self.center.y
        }
        set{
            var p = self.center
            p.y = newValue
            self.center = p
        }
    }
    
    public var cornerRadius:CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
    public var borderColor:UIColor?{
        get{
            return UIColor.init(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set{
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    public var borderWidth:CGFloat{
        get{
            return self.layer.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
        }
    }
}

extension CGFloat{
    func f()->Float{
        return Float(self)
    }
}

extension Float{
    func cf()->CGFloat{
        return CGFloat(self)
    }
}

extension Double{
    func cf()->CGFloat{
        return CGFloat(self)
    }
}

extension Int{
    func f()->Float{
        return Float(self)
    }
    
    func cf()->CGFloat{
        return CGFloat(self)
    }
    
    func d()->Double{
        return Double(self)
    }
}


