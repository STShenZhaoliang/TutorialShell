//
//  STTimerButton.swift
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

public enum STTimerButtonType: Int {
    case none  = -1   // no state
    case start = 0
    case pause
    case resume
    case ongoing
    case finish
    case invalidate
}

public class STTimerButton: UIButton {
    // MARK: 1.lift cycle

    // MARK: 2.private methods
    public func startCountDown(duration time: Int, processBlock block: ((_ button: STTimerButton, _ type: STTimerButtonType, _ timerNumer: Int) -> Void)? = nil){
        duration = time
        timerNumer = time
        processBlock = block
        type = .start
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actionCountDown), userInfo: nil, repeats: true)
        }
        processBlock?(self, type, timerNumer)
    }
    
    public func startTime(startTime time: Int = 0, processBlock block: ((_ button: STTimerButton, _ type: STTimerButtonType, _ timerNumer: Int) -> Void)? = nil){
        duration = time
        timerNumer = time
        processBlock = block
        type = .start
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actionTime), userInfo: nil, repeats: true)
        }
        processBlock?(self, type, timerNumer)
    }
    
    // MARK: 3.event response
    private func start() {
        type = .start
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actionCountDown), userInfo: nil, repeats: true)
        }
        processBlock?(self, type, timerNumer)
    }
    
    public func pause() {
        type = .pause
        timer?.fireDate = Date.distantFuture
        processBlock?(self, type, timerNumer)
    }
    
    public func resume() {
        type = .resume
        timer?.fireDate = Date.distantPast
        processBlock?(self, type, timerNumer)
    }
    
    public func invalidate() {
        type = .invalidate
        timer?.invalidate()
        timer = nil
        processBlock?(self, type, timerNumer)
    }
    
    public func finish() {
        type = .finish
        timer?.invalidate()
        timer = nil
        processBlock?(self, type, timerNumer)
    }
    
    private func ongoing() {
        type = .ongoing
        processBlock?(self, type, timerNumer)
    }
    
    @objc public func actionCountDown() {
        if timerNumer > 1 {
            timerNumer -= 1
            ongoing()
        }else{
            timerNumer = duration
            finish()
        }
    }
    
    @objc public func actionTime() {
        timerNumer += 1
        ongoing()
    }
    
    // MARK: 4.interface
    private var processBlock: ((_ button: STTimerButton, _ type: STTimerButtonType, _ timerNumer: Int) -> Void)? = nil
    private var timer:Timer?
    private var timerNumer:Int = 0
    private var duration:Int = 10
    
    public private(set) var type: STTimerButtonType = .none
    
    // MARK: 5.getter
    
}
