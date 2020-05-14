//
//  STView.swift
//  STFWPod
//
//  Created by 沈兆良 on 2020/5/15.
//  Copyright © 2020 沈兆良. All rights reserved.
//

import UIKit
import STKitSwift
open class STView: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionButton(){
        STAlertView.show(title: "title", message: "message", cancelTitle: "cancelTitle", otherTitle: "otherTitle")
    }
}
