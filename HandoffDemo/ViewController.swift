//
//  ViewController.swift
//  HandoffDemo
//
//  Created by chenyufeng on 15/10/16.
//  Copyright © 2015年 nbdpc. All rights reserved.
//

import UIKit

class ViewController: UIViewController,NSUserActivityDelegate {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var switchButton: UISwitch!
  
  var str:String!
  var isOn:String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let myActivity:NSUserActivity! = NSUserActivity(activityType: "com.chenyufengweb.HandoffDemo.sync")
    
    str = textField.text
    isOn = switchButton.on ? "on" : "off"
    
    //定义一个字典；
    let items = ["text":str,"switch":isOn]
    
    //配置活动参数；
    myActivity.userInfo = items
    myActivity.title = "sync"
    myActivity.becomeCurrent()
    myActivity.delegate = self
    myActivity.needsSave = true
    
    self.userActivity = myActivity
    
    //以代码的方式进行消息响应；
    //    self.textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.ValueChanged)
    //    self.switchButton.addTarget(self, action: "onChanged", forControlEvents: UIControlEvents.ValueChanged)
    
  }
  
  func textFieldDidChange() -> Void{
    
    print("Text changed")
    self.userActivity?.becomeCurrent()
    self.userActivity?.needsSave = true
    
  }
  
  func onChanged() -> Void{
    
    print("Switch changed")
    self.userActivity?.becomeCurrent()
    self.userActivity?.needsSave = true
    
  }
  
  //以segue的方式进行控件响应，个人比较喜欢；
  @IBAction func textFieldDidChange(sender: AnyObject) {
    
    print("Text changed")
    self.userActivity?.becomeCurrent()
    self.userActivity?.needsSave = true
    
  }
  
  
  @IBAction func onChanged(sender: AnyObject) {
    
    print("Switch changed")
    self.userActivity?.becomeCurrent()
    self.userActivity?.needsSave = true
    
  }
  
  
  //MARK: - Handoff
  /*
  注意：userActivityWillSave（）方法和userActivityWasContinued（）这两个方法在当前进行操作的设备A上执行；
  
  
  restoreUserActivityState（）方法在打开另一个设备B上执行；
  */
  
  //把当前的数据存储到字典中；
  func userActivityWillSave(userActivity: NSUserActivity) {
    print("ViewController userActivityWillSave")
    
    str = textField.text
    isOn = switchButton.on ? "on" : "off"
    
    let items = ["text" : str,"switch" : isOn]
    userActivity.addUserInfoEntriesFromDictionary(items)
    
    print("userActivityWillSave:\(str),  \(isOn)")
    
  }
  
  
  
  func userActivityWasContinued(userActivity: NSUserActivity) {
    print("ViewController userActivityWasContinued")
//    
//    let dictionary:NSDictionary = (userActivity.userInfo)!
//    let textForKey = dictionary.objectForKey("text") as! String
//    let switchForKey = dictionary.objectForKey("switch") as! String
//    print("text = \(textForKey),switch = \(switchForKey)")
//    
  }
  
  
  //从字典中读出数据；
  override func restoreUserActivityState(activity: NSUserActivity) {
    print("ViewCOntroller restoreUserActivityState")
    let dictionary:NSDictionary = (activity.userInfo)!
    let textForKey = dictionary.objectForKey("text") as! String
    let switchForKey = dictionary.objectForKey("switch") as! String
    print("text = \(textForKey),switch = \(switchForKey)")
    
    self.textField.text = textForKey
    
    if (switchForKey == "on"){
      
      self.switchButton.on = true
      print("ononononon")
      
    }else{
      
      self.switchButton.on = false
      print("offoffoffoffoff")
      
    }
    
  }
  
}
















