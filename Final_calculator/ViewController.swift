//
//  ViewController.swift
//  Final_calculator
//
//  Created by 王卓 on 15/5/31.
//  Copyright (c) 2015年 王卓. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

        //显示数值和结果的文本标签
        @IBOutlet weak var labResult:UITextField!
        //结果
        var strResult:String = "0"
        //计算方法
        var type:CalcType = CalcType.Nil
        //声明左值
        var leftValue:Double?
        //声明右值
        var rightValue:Double?
        //是否开始计算，true表示进行右值的设置，false 处于左值阶段
        var isCalc:Bool = false

        //需要写一个而方法，来统一处理数值的输入
        //按钮0点击
    @IBAction func NUMbtnTap(sender:UIButton) {
            onAddNum(sender.currentTitle!.toInt()!)
        }
        //小数点按钮点击
        @IBAction func btnDotTap() {
            if strResult.componentsSeparatedByString(".").count < 2 {
                strResult += "."
                labResult.text=strResult
            }
            
        }
        //增加数值的方法，并随时更新左值或者右值
        //我们需要通过isCalc这个变量来进行判断，是更新左值还是右值
        func onAddNum(num:Int){
            if !isCalc {
                //当处于左值阶段，同时左值又是nil的时候，需要将文本标签的字符串变为0
                if leftValue == nil {
                    strResult = "0"
                }
                onSetNum(num)
                //更新左值
                leftValue = (strResult as NSString).doubleValue
                
            }else{
                if rightValue == nil {
                    strResult = "0"
                }
                onSetNum(num)
                //更新右值
                rightValue = (strResult as NSString).doubleValue
            }
            labResult.text=strResult
        }
        func onSetNum(num:Int){
            if strResult == "0" {
                strResult = "\(num)"
            }else{
                //不为0的时候，将字符串进行连接。
                strResult += "\(num)"
            }
        }
        //按钮清除点击
        @IBAction func btnCTap() {
            strResult = "0"
            type = CalcType.Nil
            leftValue = nil
            rightValue = nil
            labResult.text=strResult
        }
        //按钮正负反转点击
        @IBAction func btnNTap() {
            var num = (strResult as NSString).doubleValue
            strResult = "\(num * -1)"
            labResult.text=strResult
        }
        //按钮除以100点击
        @IBAction func btnHTap() {
            var num = (strResult as NSString).doubleValue
            strResult = "\(num / 100)"
            labResult.text=strResult
        }
        //按钮除点击
        @IBAction func btnDTap() {
            onToRight()
            type = CalcType.Divide
            
        }
        //按钮乘点击
        @IBAction func btnMTap() {
            onToRight()
            type = CalcType.Multiply
        }
        //按钮减点击
        @IBAction func btnSTap() {
            onToRight()
            type = CalcType.Subtract
        }
        //按钮加点击
        @IBAction func btnATap() {
            onToRight()
            type = CalcType.Add
        }
        
        //转换到右值设置
        func onToRight(){
            //当处在左值设置时，跳转到右值设置，并记录左值，同时将右值设为nil
            if !isCalc {
                leftValue = (strResult as NSString).doubleValue
                isCalc = true
                rightValue = nil
            }
        }
        //按钮等号点击
        @IBAction func btnRTap() {
            //当算式进行到右值设置时，这时候才执行运算，同时将进度恢复到左值设置
            if isCalc {
                onExecute(rightValue!)
                isCalc = false
            }
            
        }
        //计算方法
        func onExecute(newValue:Double){
            switch type
            {
            case .Add:
                leftValue! += newValue
            case .Subtract:
                leftValue! -= newValue
            case .Multiply:
                leftValue! *= newValue
            case .Divide:
                leftValue! /= newValue
            default:
                return
            }
            strResult = ("\(leftValue!)")
            labResult.text=strResult
            leftValue = nil
        }
        
    //加减乘除四则运算符号
    enum CalcType
    {
        case Divide
        case Multiply
        case Subtract
        case Add
        case Nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

