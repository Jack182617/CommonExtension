//
//  ViewController.swift
//  CommonExtension
//
//  Created by 550936272@qq.com on 11/09/2022.
//  Copyright (c) 2022 550936272@qq.com. All rights reserved.
//

import UIKit
import CommonExtension

class ViewController: UIViewController {

    lazy var bottomView = UIView.init(backgroundColor: .red)
    
    lazy var commonLb = UILabel.init(font: .pfRegular(15), color: .orange, alignment: .center, titleString: "测试label")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func initView(){
        commonLb.frame = CGRect.init(x: 200, y: 200, width: 100, height: 50)
        view.addSubview(commonLb)
    }
}

