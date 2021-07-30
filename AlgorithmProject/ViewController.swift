//
//  ViewController.swift
//  AlgorithmProject
//
//  Created by 王金志 on 2021/7/8.
//

import UIKit

class ViewController: UIViewController {
    let dataSource = ["数组", "链表", "哈希表", "字符串", "双指针法", "栈与队列", "二叉树", "回溯算法", "贪心算法", "动态规划", "单调栈", "补充题目"]
    let nameDataSource = ["SZ", "LB", "HSB", "ZFC", "SZZ", "ZYDL", "ECS", "HSSF", "TXSF", "DTGH", "DDZ", "BCTM"]
    lazy var list: UITableView = {
        let list = UITableView(frame:UIScreen.main.bounds,
                               style: .plain)
        list.delegate = self
        list.dataSource = self
        list.register(ListCell.self, forCellReuseIdentifier: "cellId")
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.list)
    
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ListCell
        cell.titleLabel.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcClass = NSClassFromString("AlgorithmProject."+nameDataSource[indexPath.row]) as! UIViewController.Type
        let vc = vcClass.init()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
class ListCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    // MARK: - UI
    fileprivate func setupUI() {
        self.contentView.addSubview(self.titleLabel)
        
        titleLabel.frame = CGRect(x: 30, y: 0, width: self.contentView.frame.size.width, height: 76)
    }
}
