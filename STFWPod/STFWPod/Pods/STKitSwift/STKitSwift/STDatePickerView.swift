//
//  STDatePickerView.swift
//  STKitSwift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 沈天
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import SnapKit
public class STDatePickerView: UIView{
    // MARK: 1.lift cycle
    
    public class func show(minimumDateStr:String, maximumDateStr:String, currentDateStr:String, selectDateInfo:@escaping (_ year: String, _ month: String, _ day: String) -> Void){
        let dateView = STDatePickerView.init(frame: UIScreen.main.bounds)
        dateView.setupUI()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let minimumDate = formatter.date(from: minimumDateStr)
        if (minimumDate != nil) {
            dateView.datePicker.minimumDate = minimumDate
        }else{
            dateView.datePicker.minimumDate = formatter.date(from: "1900-01-01")
        }
        
        let maximumDate = formatter.date(from: maximumDateStr)
        if (maximumDate != nil) {
            dateView.datePicker.maximumDate = maximumDate
        }else{
            dateView.datePicker.maximumDate = Date()
        }
        
        var currentDate = formatter.date(from: currentDateStr)
        if (currentDate == nil) {
            currentDate = Date()
        }
        dateView.datePicker.setDate(currentDate!, animated: true)
        
        let window = UIApplication.shared.keyWindow!
        window.addSubview(dateView)
        dateView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        UIView.animate(withDuration: 0.3) {
            dateView.contentView.alpha = 0.7
        }
        dateView.selectDateInfo = selectDateInfo
    }
    
    public class func show(selectDateInfo:@escaping (_ year: String, _ month: String, _ day: String) -> Void){
        show(minimumDateStr: "", maximumDateStr: "", currentDateStr: "", selectDateInfo: selectDateInfo)
    }
    
    @objc private func dismiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    private func setupUI(){
        backgroundColor = .clear
        
        contentView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(190)
        }
        
        buttonBG.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(45)
            make.bottom.equalTo(datePicker.snp.top)
        }
        
        buttonCancel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(32)
        }
        
        buttonOK.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalTo(44)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(32)
        }
        
        lineUp.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // MARK: 2.private methods
    
    // MARK: 3.event response
    @objc func cancelAction(_ button: UIButton) {
        dismiss()
    }
    
    @objc func okAction(_ button: UIButton) {
        selectDateInfo?(datePicker.date.year.description, datePicker.date.month.description, datePicker.date.day.description)
        dismiss()
    }
    
    @objc func dateChanged(_ datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日"
        print(formatter.string(from: datePicker.date))
    }
    // MARK: 4.interface
    
    var selectDateInfo: ((_ year: String, _ month: String, _ day: String) -> ())?
    
    private lazy var contentView: UIControl = {
        let contentView = UIControl.init(frame: UIScreen.main.bounds)
        contentView.alpha = 0
        contentView.backgroundColor = .black
        contentView.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        addSubview(contentView)
        return contentView
    }()
    
    
    private lazy var buttonBG: UIControl = {
        let buttonBG = UIControl()
        buttonBG.backgroundColor = .white
        addSubview(buttonBG)
        return buttonBG
    }()
    
    private lazy var buttonCancel: UIButton = {
        let buttonCancel = UIButton()
        buttonCancel.setTitle("取消", for: .normal)
        buttonCancel.setTitleColor(UIColor.init(red: 128.0/255, green: 128.0/255, blue: 128.0/255, alpha: 1), for: .normal)
        buttonCancel.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        buttonCancel.addTarget(self,  action: #selector(cancelAction(_:)), for: .touchUpInside)
        buttonBG.addSubview(buttonCancel)
        return buttonCancel
    }()
    
    private lazy var buttonOK: UIButton = {
        let buttonOK = UIButton()
        buttonOK.setTitle("确定", for: .normal)
        buttonOK.setTitleColor(UIColor.init(red: 86.0/255, green: 117.0/255, blue: 236.0/255, alpha: 1), for: .normal)
        buttonOK.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        buttonOK.addTarget(self,  action: #selector(okAction(_:)), for: .touchUpInside)
        buttonBG.addSubview(buttonOK)
        return buttonOK
    }()
    
    private lazy var lineUp: UIView = {
        let lineUp = UIView()
        lineUp.backgroundColor = UIColor.init(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1)
        buttonBG.addSubview(lineUp)
        return lineUp
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        addSubview(datePicker)
        return datePicker
    }()
}
