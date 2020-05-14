//
//  STAreaPickerView.swift
//  STKitSwiftDemo
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 沈兆良. All rights reserved.
//

import UIKit
import SnapKit

struct STChinaRegionsModel: Codable {
    var code:String?
    var name:String?
    var children:[STChinaRegionsModel]?
}

public class STAreaPickerView: UIButton {
    // MARK: 1.lift cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        addTarget(self, action: #selector(hidden), for: .touchUpInside)
        
        provinceRegion = models.first
        cityModels = provinceRegion?.children ?? []
        cityRegion = cityModels.first
        areaModels = cityRegion?.children ?? []
        areaRegion = areaModels.first
        
        contentView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.height.equalTo(260)
            maker.bottom.equalTo(260)
        }
        
        pickerView.snp.makeConstraints { (maker) in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(216)
        }
        
        topView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.height.equalTo(44)
            maker.bottom.equalTo(pickerView.snp.top)
        }
        
        buttonCancel.snp.makeConstraints { (maker) in
            maker.left.top.bottom.equalToSuperview()
            maker.width.equalTo(66)
        }
        
        buttonOK.snp.makeConstraints { (maker) in
            maker.right.top.bottom.equalToSuperview()
            maker.width.equalTo(66)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 2.private methods
    public class func show(inView view:UIView, selectedBlock block:((String?, String?, String?, String?, String?, String?) -> ())?){
        let pickerView = STAreaPickerView()
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        pickerView.selectedBlock = block
        pickerView.show()
    }
    
    @objc func show(){
        UIView.animate(withDuration: 0.3) {
            self.contentView.snp.updateConstraints({ (maker) in
                maker.bottom.equalTo(0)
            })
        }
    }
    
    @objc func hidden(){
        contentView.snp.updateConstraints({ (maker) in
            maker.bottom.equalTo(260)
        })
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    // MARK: 3.event response
    @objc func actionOK(){
        selectedBlock?(provinceRegion?.name, provinceRegion?.code, cityRegion?.name, cityRegion?.code, areaRegion?.name, areaRegion?.code)
        hidden()
    }
    
    // MARK: 4.interface
    private lazy var models: [STChinaRegionsModel] = {
        let models:[STChinaRegionsModel]? = try? JSONDecoder().decode([STChinaRegionsModel].self, from: Data.st_data(named: "pca-code"))
        return models ?? []
    }()
    
    private var cityModels:[STChinaRegionsModel] = []
    private var areaModels:[STChinaRegionsModel] = []
    private var provinceRegion:STChinaRegionsModel?
    private var cityRegion:STChinaRegionsModel?
    private var areaRegion:STChinaRegionsModel?
    private var selectedBlock:((String?, String?, String?, String?, String?, String?) -> ())?
    
    // MARK: 5.getter
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        addSubview(contentView)
        return contentView
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.dataSource = self
        pickerView.delegate = self
        contentView.addSubview(pickerView)
        return pickerView
    }()
    
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.init(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1)
        contentView.addSubview(topView)
        return topView
    }()
    
    private lazy var buttonCancel: UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor( UIColor.init(red: 0/255, green: 122.0/255, blue: 255.0/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(hidden), for: .touchUpInside)
        topView.addSubview(button)
        return button
    }()
    
    private lazy var buttonOK: UIButton = {
        let button = UIButton()
        button.setTitle("完成", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor( UIColor.init(red: 0/255, green: 122.0/255, blue: 255.0/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(actionOK), for: .touchUpInside)
        topView.addSubview(button)
        return button
    }()
}

extension STAreaPickerView: UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return models.count
        case 1:
            return cityModels.count
        default:
            return areaModels.count
        }
    }
}

extension STAreaPickerView: UIPickerViewDelegate{
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var text = ""
        switch component {
        case 0:
            text = models[row].name ?? ""
        case 1:
            text = cityModels[row].name ?? ""
        default:
            text = areaModels[row].name ?? ""
        }
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 19)
        label.adjustsFontSizeToFitWidth = true
        label.text = text
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            provinceRegion = models[row]
            cityModels = provinceRegion?.children ?? []
            cityRegion = cityModels.first
            areaModels = cityRegion?.children ?? []
            areaRegion = areaModels.first
            
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        case 1:
            cityRegion = cityModels[row]
            areaModels = cityRegion?.children ?? []
            areaRegion = areaModels.first
            
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        default:
            areaRegion = areaModels[row]
            break
        }
    }
}
