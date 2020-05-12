//
//  ViewController.swift
//  segmentControllAdd
//
//  Created by 林祐辰 on 2020/5/11.
//  Copyright © 2020 smirkiiiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNum: UITextField!
    @IBOutlet weak var secondNum: UITextField!
    @IBOutlet weak var calculateSegment: UISegmentedControl!
    @IBOutlet weak var resultNum: UILabel!
    
    var biggerTimer = Timer()
    var smallerTimer = Timer()
    
    // 預設字體大小
    var defaultSize = 50

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateHelper(_ sender: UISegmentedControl) {
        
        // 將計算後的數值存入此變數裡
        var sumNumber :Double? = 0
        
        // 將文字輸入框的字串轉換為浮點數
        let firstNumber = Double(firstNum.text!)
        let secondNumber = Double(secondNum.text!)
        
        
      // 如果文字輸入框有輸入數字才做計算, 不然就會跳出提示訊息
        
        if (firstNumber != nil && secondNumber != nil){
        
           if (sender.selectedSegmentIndex == 0){
              sumNumber = firstNumber! + secondNumber!
              numberTurn()
          }else if(sender.selectedSegmentIndex == 1){
            sumNumber = firstNumber! - secondNumber!
            numberTurn()
          }else if(sender.selectedSegmentIndex == 2){
            sumNumber = firstNumber! * secondNumber!
            numberTurn()
           }else{
            sumNumber = firstNumber! / secondNumber!
            numberTurn()
            }
      }else{
            let alertView = UIAlertController(title: "未輸入數字", message: "請在文字框輸入數字", preferredStyle: .alert)
            let alertViewButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertView.addAction(alertViewButton)
            present(alertView,animated: true,completion: nil)
            biggerTimer.invalidate()
            smallerTimer.invalidate()
        }
    resultNum.text = String(format: "%.2f", sumNumber!)
    renderSmallerNum ()
    renderBiggerNum ()
    
  }
    
    
// 透過 KeyframeAnimation 實現字體 順時針/逆時針 旋轉
     func numberTurn(){
      let turnBack = CAKeyframeAnimation(keyPath: "transform.rotation")
         turnBack.values = [CGFloat.pi*2,CGFloat.pi,0,0,CGFloat.pi,CGFloat.pi*2]
         turnBack.keyTimes = [0,NSNumber(value: 0.2),NSNumber(value:0.4),NSNumber(value: 0.6),NSNumber(value: 0.8),NSNumber(value: 1.0)]
         turnBack.duration = 12
         turnBack.repeatCount = 0
         turnBack.fillMode = CAMediaTimingFillMode.forwards
        
         resultNum.layer.add(turnBack,forKey: nil)
     }

    
    // 設定將字體放大的計時器
    func renderBiggerNum (){
        biggerTimer = Timer.scheduledTimer(withTimeInterval: 7, repeats: true, block: { (biggerTimer) in
            let sizeExchanger :CGFloat = (CGFloat(self.defaultSize)+CGFloat(20))
            let font = self.resultNum.font
            self.resultNum.font = font?.withSize(sizeExchanger)
        })
    }
    
    // 設定將字體縮小的計時器
    func renderSmallerNum (){
        smallerTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (smallerTimer) in
            let sizeExchanger :CGFloat = (CGFloat(self.defaultSize)-CGFloat(5))
            let font = self.resultNum.font
            self.resultNum.font = font?.withSize(sizeExchanger)
        })
    }
        
}
