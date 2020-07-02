//
//  ViewController.swift
//  StringToProperty
//
//  Created by 张鹏 on 2020/7/1.
//  Copyright © 2020 张鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fromTextView:UITextView!
    
    var button:UIButton!
    
    var toTextView:UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        fromTextView = UITextView(frame: CGRect(x: 0, y: 50, width: 2000, height: 300))
        self.view.addSubview(fromTextView)
        fromTextView?.font = UIFont.systemFont(ofSize: 20)
        
        fromTextView.becomeFirstResponder()
        
        button = UIButton(frame: CGRect(x: 0, y: fromTextView.frame.origin.y + fromTextView.frame.size.height + 20, width: 100, height: 100))
        button.backgroundColor = .blue
        button.setTitle("转换", for: .normal)
        
        self.view.addSubview(button)
        
        let clearButton = UIButton(frame: CGRect(x: 200, y: button.frame.origin.y, width: 100, height: 100))
        clearButton.backgroundColor = .red
        clearButton.setTitle("清除", for: .normal)
        
        self.view.addSubview(clearButton)
        
        let copyButton = UIButton(frame: CGRect(x: 400, y: button.frame.origin.y, width: 100, height: 100))
        copyButton.backgroundColor = .black
        copyButton.setTitle("拷贝", for: .normal)
        
        self.view.addSubview(copyButton)
        
        copyButton.addTarget(self, action: #selector(copyClick), for: .touchUpInside)
        
        clearButton.addTarget(self, action: #selector(clearClick), for: .touchUpInside)
        
        button.addTarget(self, action: #selector(changeClick), for: .touchUpInside)
        
        
    }

    
    @objc func copyClick(){
        
        let pas = UIPasteboard.general
        pas.string = toTextView?.text
        
        toTextView?.text = "拷贝成功了"
        
    }
    
    @objc func clearClick(){
        fromTextView.text = ""
        
        toTextView?.text = "清除成功了"
    }
    
    ///点击转换
    @objc func changeClick() {
        
        let pas = UIPasteboard.general
        
        if fromTextView.text.isEmpty {
            fromTextView.text = pas.string
        }
        if fromTextView.text.isEmpty || fromTextView.text == nil{
            return
        }
        
        let string = fromTextView.text
        
        let arr = string!.components(separatedBy: "\n")
        
        var totalString = ""
        
        for str in arr {
            
            let contentDictArr = str.components(separatedBy: "\":")
            
            if contentDictArr.count > 1 {
                var toProperty = ""
                ///首先看有没有注释
                
                let descArr = contentDictArr[1].components(separatedBy: ",")
                
                let descStr = descArr[1].trimmingCharacters(in: .whitespacesAndNewlines)
                
                if descStr != nil && descStr.count > 0  {
                    toProperty += "/\(descStr)\nvar "
                }else{
                    ///首先写一个var
                    toProperty = "var "
                }
                
                ///先获取到的是带冒号的key 之后将冒号去掉
                var keyAndMao = contentDictArr[0].trimmingCharacters(in: .whitespacesAndNewlines) as NSString
                
                keyAndMao = keyAndMao.substring(from: 1) as NSString
                
                print(keyAndMao)
                
                toProperty = toProperty + (keyAndMao as String) + " :"
                
                let valueAndDesc = contentDictArr[1].trimmingCharacters(in: .whitespacesAndNewlines)
                
                let valueAndDescDictArr = valueAndDesc.components(separatedBy: ",")
                
                if valueAndDescDictArr.count != 0 {
                    let value = valueAndDescDictArr[0]
                    
                    if value.hasPrefix("\"") {
                        toProperty += " String!"
                    }else if value == " null" || value == "nil"{
                        toProperty += " String?"
                    }else if value.contains("."){
                        toProperty += " float?"
                    }else{
                        toProperty += " Int?"
                    }
                    
                }
                
                toProperty += "\n"
                
                totalString += toProperty
            }
            
        }
        print(totalString)
        
        toTextView = UITextView(frame: CGRect(x: 0, y: button.frame.origin.y + button.frame.size.height + 20, width: 2000, height: 1000))
        toTextView?.backgroundColor = .white
        toTextView?.textColor = .black
        toTextView?.font = UIFont.systemFont(ofSize: 20)
        toTextView?.text = totalString
        self.view.addSubview(toTextView!)
    }


}

