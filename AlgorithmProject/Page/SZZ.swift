//
//  SZZ.swift
//  AlgorithmProject
//
//  Created by LP. on 2022/2/28.
//  双指针

import UIKit

class SZZ: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var nums = [0,1,2,2,3,0,4,2]
        let k = 2
        print("第一题：\(self.removeElement(&nums, k))")
        
        var chArray:[Character] = ["h","e","l","l","o"]
        print("第二题：\(self.reverseString(&chArray))")

    }
    /*
     给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。

     不要使用额外的数组空间，你必须仅使用 $O(1)$ 额外空间并原地修改输入数组。

     元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

     示例 1: 给定 nums = [3,2,2,3], val = 3, 函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。 你不需要考虑数组中超出新长度后面的元素。

     示例 2: 给定 nums = [0,1,2,2,3,0,4,2], val = 2, 函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。

     你不需要考虑数组中超出新长度后面的元素。
     */
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var slowIndex = 0
            
        for fastIndex in 0..<nums.count {
            if val != nums[fastIndex] {
                if slowIndex != fastIndex {
                    nums[slowIndex] = nums[fastIndex]
                }
                slowIndex += 1
            }
        }
        return slowIndex
    }
    /*
     编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 char[] 的形式给出。

     不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 $O(1)$ 的额外空间解决这一问题。

     你可以假设数组中的所有字符都是 ASCII 码表中的可打印字符。

     示例 1：
     输入：["h","e","l","l","o"]
     输出：["o","l","l","e","h"]

     示例 2：
     输入：["H","a","n","n","a","h"]
     输出：["h","a","n","n","a","H"]
     */
    func reverseString(_ s: inout [Character]) -> [Character] {
        var left = 0
        var right = s.count - 1
        while left < right {
            (s[left], s[right]) = (s[right], s[left])
            left += 1
            right -= 1
        }
        return s
    }
    /*
     */
    
}
