//
//  BaseController.swift
//  AlgorithmProject
//
//  Created by LP. on 2022/2/28.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.brown
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        button.center = self.view.center
        button.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        button.setTitle("返回", for: .normal)
        self.view.addSubview(button)
    }
    
    @objc func backClick() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
