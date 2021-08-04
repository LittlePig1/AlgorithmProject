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

        node0.next = node1
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5

//        removeTargat1(6, headNode: &node0)
//        removeTargat2(6, headNode: &node0)

        // 反转一个单链表
//        print("反转一个单链表---\(reverseList(headNode: &node0))")
        
        // 交换其中相邻的节点
//        print("交换其中相邻的节点---\(getNewExchangeListNode(headNode: &node0))")
        
        // 两个链表是否有交点
        let node6 = Node(2)
        let node7 = Node(8)
        
        node6.next = node7
        node7.next = node1
        print("两个链表是否有交点---\(getIntersectionNode(firstNode: node1, secondNode: node6))")
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
    /*
     给定一个链表，两两交换其中相邻的节点，并返回交换后的链表
     示例: 输入: 1->2->3->4->NULL 输出: 2->1->4->3->NULL
     */
    fileprivate func getNewExchangeListNode(headNode: inout Node) -> Node{
        // 添加虚拟头节点
        let temHeaderNode = Node(0)
        temHeaderNode.next = headNode
        
        var cur = temHeaderNode
        while cur.next != nil {
            let temNode1 = cur.next
            let temNode2 = cur.next?.next?.next

            cur.next = cur.next?.next         // 步骤一
            cur.next?.next = temNode1         // 步骤二
            cur.next?.next?.next = temNode2   // 步骤三

            if let node = cur.next?.next{
                cur = node
            }
        }
        return temHeaderNode.next!
    }
    /*
     给定两个（单向）链表，判定它们是否相交并返回交点。请注意相交的定义基于节点的引用，而不是基于节点的值。换句话说，如果一个链表的第k个节点与另一个链表的第j个节点是同一节点（引用完全相同），则这两个链表相交。

     示例 1：

     输入：listA = [4,1,8,4,5], listB = [5,0,1,8,4,5]

     输出：Reference of the node with value = 8

     输入解释：相交节点的值为 8 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [4,1,8,4,5]，链表 B 为 [5,0,1,8,4,5]。在 A 中，相交节点前有 2 个节点；在 B 中，相交节点前有 3 个节点。
     */
    fileprivate func getIntersectionNode(firstNode: Node, secondNode: Node) -> Node?{
        // 获取连个链表的长度
        var firstLength = 0
        var secondLength = 0
        var offSet = 0
        
        var first = firstNode
        var second = secondNode
        
        while first.next != nil {
            if let node = first.next {
                first = node
            }
            firstLength += 1
        }
        while second.next != nil {
            if let node = second.next {
                second = node
            }
            secondLength += 1
        }
        offSet = abs(firstLength - secondLength)
        
        if firstLength >= secondLength {
            // 先移动firstNode 至 firstNode 剩余长度和secondNode一致 再逐一对比
            
            var temNode = firstNode
            while offSet > 0 {
                if let node = temNode.next {
                    temNode = node
                }
                offSet -= 1
            }
            var temFirstNode = temNode
            var temSecondNode = secondNode
            while secondLength > 0 {
                if sg_equateableAnyObject(object1: temFirstNode, object2: temSecondNode) {
                    return temFirstNode
                } else {
                    if let node1 = temFirstNode.next, let node2 = temSecondNode.next {
                        temFirstNode = node1
                        temSecondNode = node2
                    }
                }
                secondLength -= 1
            }
        } else {
            var temNode = secondNode
            while offSet > 0 {
                if let node = temNode.next {
                    temNode = node
                }
                offSet -= 1
            }
            var temFirstNode = firstNode
            var temSecondNode = temNode
            while firstLength > 0 {
                if sg_equateableAnyObject(object1: temFirstNode, object2: temSecondNode) {
                    return temFirstNode
                } else {
                    if let node1 = temFirstNode.next, let node2 = temSecondNode.next {
                        temFirstNode = node1
                        temSecondNode = node2
                    }
                }
                firstLength -= 1
            }
        }
        
        return nil
    }
    
    // 取出某个对象的地址
    func sg_getAnyObjectMemoryAddress(object: AnyObject) -> String {
        let str = Unmanaged<AnyObject>.passUnretained(object).toOpaque()
        return String(describing: str)
    }
     
    // 对比两个对象的地址是否相同
    func sg_equateableAnyObject(object1: AnyObject, object2: AnyObject) -> Bool {
        let str1 = sg_getAnyObjectMemoryAddress(object: object1)
        let str2 = sg_getAnyObjectMemoryAddress(object: object2)
        
        if str1 == str2 {
            return true
        } else {
            return false
        }
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
