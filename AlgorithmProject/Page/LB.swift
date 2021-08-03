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
        
        // 删除链表中等于给定值 val 的所有节点
        var node0 = Node(6)
        let node1 = Node(2)
        let node2 = Node(6)
        let node3 = Node(3)
        let node4 = Node(4)
        let node5 = Node(5)
        let node6 = Node(6)

        node0.next = node1
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6

//        removeTargat1(6, headNode: &node0)
//        removeTargat2(6, headNode: &node0)

        // 反转一个单链表
        print("反转一个单链表---\(reverseList(headNode: &node0))")
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
    // 常规方法
    fileprivate func removeTargat1(_ target: Int, headNode: inout Node) {
        // 头节点 处理
        while headNode.val == target {
            if let node = headNode.next {
                headNode = node
            }
        }
        // 非头节点 处理
        var currentNode = headNode
        while currentNode.next != nil {
            if currentNode.next?.val == target {
                currentNode.next = currentNode.next?.next
            } else {
                if let node = currentNode.next {
                    currentNode = node
                }
            }
        }
        
        print("删除链表中等于给定值---\(headNode)")
    }
    // 虚拟头节点
    fileprivate func removeTargat2(_ target: Int, headNode: inout Node) {
        let temHeaderNode = Node(0)
        temHeaderNode.next = headNode
        
        var currentNode = temHeaderNode
        while currentNode.next != nil {
            if currentNode.next?.val == target {
                currentNode.next = currentNode.next?.next
            } else {
                if let node = currentNode.next {
                    currentNode = node
                }
            }
        }
        if let node = temHeaderNode.next {
            headNode = node
        }
        print("删除链表中等于给定值---\(headNode)")
    }
    /*
     题意：反转一个单链表。

     示例: 输入: 1->2->3->4->5->NULL 输出: 5->4->3->2->1->NULL
     */
    // 双指针
    fileprivate func reverseList(headNode: inout Node) -> Node{
        var cur = headNode
        var pre: Node?
        var tem: Node?
        while cur.next != nil {
            tem = cur.next
            cur.next = pre
            pre = cur
            cur = tem!
        }
        if cur.next == nil {
            tem = cur.next
            cur.next = pre
            pre = cur
            if tem != nil {
                cur = tem!
            }
        }
        return pre!
    }
}
// 链表节点
class Node {
  var val: Int
  var next: Node?
  
  init(_ val: Int) {
    self.val = val
    self.next = nil
  }
}
