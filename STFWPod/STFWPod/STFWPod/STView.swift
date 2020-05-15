//
//  STView.swift
//  STFWPod
//
//  Created by 沈兆良 on 2020/5/15.
//  Copyright © 2020 沈兆良. All rights reserved.
//

import UIKit
import SnapKit
open class STView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        let label = UILabel()
        label.text = "TEST"
        label.backgroundColor = .red
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
