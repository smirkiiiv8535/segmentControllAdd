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
    var defaultSize = 50

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateHelper(_ sender: UISegmentedControl) {
        
        var sumNumber :Double? = 0
        let firstNumber = Double(firstNum.text!)
        let secondNumber = Double(secondNum.text!)
        
    if (firstNumber != nil && secondNumber != nil){
        
          if (sender.selectedSegmentIndex == 0){
           sumNumber = firstNumber! + secondNumber!
          }else if(sender.selectedSegmentIndex == 1){
            sumNumber = firstNumber! - secondNumber!
          }else if(sender.selectedSegmentIndex == 2){
            sumNumber = firstNumber! * secondNumber!
           }else{
            sumNumber = firstNumber! / secondNumber!
             resultNum.text = String(format: "%.2f", sumNumber!)
            }
        }else{
            let alertView = UIAlertController(title: "未輸入數字", message: "請在文字框輸入數字", preferredStyle: .alert)
            let alertViewButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertView.addAction(alertViewButton)
            present(alertView,animated: true,completion: nil)
            resultNum.text = ""
        }
    resultNum.text = String(format: "%.2f", sumNumber!)
    numberTurn()
    renderSmallerNum ()
    renderBiggerNum ()
  }

     func numberTurn(){
    
     let turnBack = CAKeyframeAnimation(keyPath: "transform.rotation")
         turnBack.values = [CGFloat.pi*2,CGFloat.pi,0,0,CGFloat.pi,CGFloat.pi*2]
         turnBack.keyTimes = [0,NSNumber(value: 0.2),NSNumber(value:0.4),NSNumber(value: 0.6),NSNumber(value: 0.8),NSNumber(value: 1.0)]
         turnBack.duration = 8
         turnBack.repeatCount = 0
         turnBack.fillMode = CAMediaTimingFillMode.forwards
         resultNum.layer.add(turnBack,forKey: nil)
     }
    

    func renderBiggerNum (){
        biggerTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (biggerTimer) in
            let sizeExchanger :CGFloat = (CGFloat(self.defaultSize)+CGFloat(20))
            let font = self.resultNum.font
            self.resultNum.font = font?.withSize(sizeExchanger)
        })
    }
    
    func renderSmallerNum (){
        smallerTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (smallerTimer) in
            let sizeExchanger :CGFloat = (CGFloat(self.defaultSize)-CGFloat(5))
            let font = self.resultNum.font
            self.resultNum.font = font?.withSize(sizeExchanger)
        })
    }
        
}
