//: Playground - noun: a place where people can play
import XCPlayground
import UIKit

let view = UIView()
view.frame = CGRectMake(0, 0, 400, 400)
view.backgroundColor = UIColor.redColor()
let view2 = UIView()
view2.frame = CGRectMake(100, 100, 100, 100)
view2.backgroundColor = UIColor.whiteColor()
view.addSubview(view2)
print("view2.frame:\(view2.frame)")
let view3 = UIView()
view3.frame = CGRectMake(50, 50, 50, 50)
view3.backgroundColor = UIColor.yellowColor()
view2.addSubview(view3)
view3.layer.frame
//view3.transform = CGAffineTransformMakeScale(1,2)
print("view3.frame:\(view3.frame)")
let view4 = UIView()
view4.frame = CGRectMake(0, 25, 50, 50)
view4.backgroundColor = UIColor.brownColor()
view2.addSubview(view4)
print("view4.frame:\(view4.frame)")
print("view4.frame:\(view4.convertRect(view4.bounds, toView: view))")


//view.bounds = CGRectMake(-10, -10, 200, 200)
view2.bounds = CGRectMake(0, 0, 190, 190)


XCPlaygroundPage.currentPage.liveView = view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let url = NSURL(string: "http://httpbin.org/image/png")!
let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
    data, _, _ in
    let image = UIImage(data: data!)
    
    XCPlaygroundPage.currentPage.finishExecution()
}
task.resume()
let marray1 = NSMutableArray()
marray1.addObject(NSMutableString(string: "1"))
marray1.addObject(NSMutableString(string: "2"))
marray1.addObject(NSMutableString(string: "3"))
marray1.addObject(NSMutableString(string: "4"))
let marray2 = marray1.mutableCopy()
let array1 = marray1.copy() as! NSArray
let array2 = marray1.mutableCopy() as! NSArray
marray1[0].appendString("append")
marray1.addObject(NSMutableString(string: "5"))
marray1
marray2
array1
array2
let arr2 = [10 ... 14] + [1 ... 24]
arr2



