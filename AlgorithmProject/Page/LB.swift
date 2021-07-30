//
//  LB.swift
//  AlgorithmProject
//
//  Created by 王金志 on 2021/7/30.
//

import UIKit

class LB: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        
    }
    /*
     题：删除链表中等于给定值 val 的所有节点。

     示例 1：
     输入：head = [1,2,6,3,4,5,6], val = 6
     输出：[1,2,3,4,5]

     示例 2：
     输入：head = [], val = 1
     输出：[]

     示例 3：
     输入：head = [7,7,7,7], val = 7
     输出：[]
     */
    fileprivate func removeTargat() {
        
    }

}
// 链表节点
class ListNode {
  var val: Int
  var next: ListNode?
  
  init(_ val: Int) {
    self.val = val
    self.next = nil
  }
}
