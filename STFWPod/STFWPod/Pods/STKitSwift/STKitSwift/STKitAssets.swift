//
//  STKitAssets.swift
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

extension UIImage {
    class func st_image(named name: String) -> UIImage{
        return STKitAssets.bundledImage(named: name)
    }
}

extension Data {
    static func st_data(named name: String) -> Data{
        return STKitAssets.bundledData(named: name).data
    }
}

open class STKitAssets: NSObject {
    internal class func bundledImage(named name: String) -> UIImage {
        let primaryBundle = Bundle(for: STKitAssets.self)
        if let image = UIImage(named: name, in: primaryBundle, compatibleWith: nil) {
            return image
        } else if
            let subBundleUrl = primaryBundle.url(forResource: "STKitSwift_bundles", withExtension: "bundle"),
            let subBundle = Bundle(url: subBundleUrl),
            let image = UIImage(named: name, in: subBundle, compatibleWith: nil){
            return image
        }
        return UIImage()
    }
    
    internal class func bundledData(named name: String) -> NSDataAsset {
        let primaryBundle = Bundle(for: STKitAssets.self)
        if let dataAsset =  NSDataAsset.init(name: name, bundle: primaryBundle) {
            return dataAsset
        } else if
            let subBundleUrl = primaryBundle.url(forResource: "STKitSwift_bundles", withExtension: "bundle"),
            let subBundle = Bundle(url: subBundleUrl),
            let dataAsset =  NSDataAsset.init(name: name, bundle: subBundle){
            return dataAsset
        }
        return NSDataAsset.init(name: "")!
    }
}
