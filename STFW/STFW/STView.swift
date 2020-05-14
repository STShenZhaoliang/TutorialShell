//
//  STView.swift
//  STFW
//
//  Created by 沈兆良 on 2020/5/14.
//  Copyright © 2020 沈兆良. All rights reserved.
//

import UIKit

open class STView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
