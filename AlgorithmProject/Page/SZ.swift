//
//  SZ.swift
//  AlgorithmProject
//
//  Created by 王金志 on 2021/7/30.
//

import UIKit

class SZ: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .cyan
        /*****数组******/
        // 二分法
        let num = [-1,0,3,5,9,12]
        let target = 3
        print("二分法\(searchTargetTwo(num: num, target: target))")
        
        // 双指针
        var num1 = [0,1,2,2,3,0,4,2]
        let target1 = 2
        print("移除相同的数\(removeTargrt(num: &num1, targrt: target1))")
        
        var num2 = [44,-7,-3,2,3,11,7,0]
        print("平方后的新数组 方法1 \(getNewArray(num: &num2))")
        
        let num3 = [-7,-3,2,3,7,11]
        print("平方后的新数组 方法2 \(getNewArrayTwo(num: num3))")
        
        let num4 = [2,3,1,2,4,3]
        let s = 7
        print("长度最小的子数组1 \(getLessThanArray(num: num4, target: s))")
        print("长度最小的子数组2 \(getLessThanArrayTwo(num: num4, target: s))")

        let s1 = 4
        print("矩阵数组 \(generateMatrix(target: s1))")
    }
    
    // MARK:- 数组
    /*
     数组
     给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。
     
     示例 1:

     输入: nums = [-1,0,3,5,9,12], target = 9
     输出: 4
     解释: 9 出现在 nums 中并且下标为 4
     示例 2:

     输入: nums = [-1,0,3,5,9,12], target = 2
     输出: -1
     解释: 2 不存在 nums 中因此返回 -1
     提示：

     你可以假设 nums 中的所有元素是不重复的。 n 将在 [1, 10000]之间。 nums 的每个元素都将在 [-9999, 9999]之间
     
     由于该题目是 有序的 且没有重复的数组 所以 采用 二分法进行 解答
     */
    fileprivate func searchTargetOne(num: [Int], target: Int) -> Int{
        // 方法一 target在 左闭右闭区间
        var left = 0
        var right = num.count - 1
        
        while left <= right {
            let mid = left + (right - left)/2
            if target < num[mid]{
                right = mid - 1
            } else if target > num[mid]{
                left = mid + 1
            } else {
                return mid
            }
        }
        return -1
    }
    fileprivate func searchTargetTwo(num: [Int], target: Int) -> Int{
        // 方法二 target在 左闭右开区间
        var left = 0
        var right = num.count - 1
        
        while left < right {
            let mid = left + (right - left)/2
            if target < num[mid]{
                right = mid
            } else if target > num[mid]{
                left = mid + 1
            } else {
                return mid
            }
        }
        return -1
    }

    /*
     给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。

     不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并原地修改输入数组。

     元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

     示例 1: 给定 nums = [3,2,2,3], val = 3, 函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。 你不需要考虑数组中超出新长度后面的元素。

     示例 2: 给定 nums = [0,1,2,2,3,0,4,2], val = 2, 函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。你不需要考虑数组中超出新长度后面的元素。
     */
    fileprivate func removeTargrt(num: inout [Int], targrt: Int)-> Int{
        var slowIndex = 0
        for item in num {
            if targrt != item {
                num[slowIndex] = item
                slowIndex += 1
            }
        }
        return slowIndex
    }
    /*
     给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

     示例 1： 输入：nums = [-4,-1,0,3,10] 输出：[0,1,9,16,100] 解释：平方后，数组变为 [16,1,0,9,100]，排序后，数组变为 [0,1,9,16,100]

     示例 2： 输入：nums = [44，-7,-3,2,3,11,7,0,] 输出：[0, 4, 9, 9, 49, 49, 121, 1936]
     */
    fileprivate func getNewArray(num: inout [Int]) -> [Int] {
        for (index,item) in num.enumerated() {
            num[index] = item*item
        }
        // 快速排序
        return qucikSort(&num, 0, num.count - 1)
    }
    // 快速排序 *****特别关注******
    public func qucikSort(_ array: inout [Int], _ p: Int, _ r: Int) -> [Int] {
        // 需要排序的区间只包含一个数字，则不需要重排数组，直接返回
        if p >= r { return array }
        let i = partition(&array, p, r)
        // 分界左边排序
        let num1 = qucikSort(&array, p, i-1)
        // 分界右边排序
        let num2 = qucikSort(&array, i+1, r)
        print("  i  ----- \(i) \n  左边------ \(num1) \n  右边------ \(num2)")
        return array
    }
    // 原地分区函数(array: 待分区数组, p: 起始下标, r: 结束下标) 分界点选取最后一个元素
    // [1936, 49, 9, 4, 9, 121, 49, 0]
    private func partition(_ array: inout [Int], _ p: Int, _ r: Int) -> Int {
        let pivot = array[r]
        var i = p
        for j in p...r-1 {
            if array[j] < pivot {
                // 交换数组下标为 i、j 的元素
                array.swapAt(i, j)
                i += 1
            }
        }
        array.swapAt(i, r);
        return i
    }
    // 双指针
    fileprivate func getNewArrayTwo(num: [Int]) -> [Int] {
        let size = num.count
        var newNum = Array<Int?>(repeating: 0, count: size)

        var left = 0
        var right = size - 1
        var temRight = size - 1

        while left <= right {
            if num[left]*num[left] < num[right]*num[right] {
                newNum[temRight] = num[right]*num[right]
                right -= 1
            } else {
                newNum[temRight] = num[left]*num[left]
                left += 1
            }
            temRight -= 1
        }
        if let resultNum = newNum as? [Int] {
            return resultNum
        } else {
            return num
        }
    }
    /*
     给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的 连续 子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。
     示例：
     输入：s = 7, nums = [2,3,1,2,4,3] 输出：2 解释：子数组 [4,3] 是该条件下的长度最小的子数组。
     */
    // 方法一：
    fileprivate func getLessThanArray(num: [Int], target: Int) ->Int {
        let numMaxIndex = num.count - 1
        var length1 = 0
        var length2 = num.count
        for i in 0...numMaxIndex {
            var sum = 0
            for j in i...numMaxIndex {
                sum += num[j]
                if sum >= target {
                    length1 = j - i + 1
                    length2 = length2 > length1 ? length1: length2
                    break
                }
            }
        }
        return length2
    }
    // 方法二： 滑动窗口
    fileprivate func getLessThanArrayTwo(num: [Int], target: Int) ->Int {
        var left = 0
        var length1 = num.count
        var length2 = 0
        var sum = 0
        
        for i in 0...(length1 - 1) {
            sum += num[i]
            while sum >= target {
                length2 = i - left + 1
                length1 = length2 > length1 ? length1 : length2
                sum -= num[left]
                left += 1
            }
        }
        return length1
    }
    /*
     给定一个正整数 n，生成一个包含 1 到 n2 所有元素，且元素按顺时针顺序螺旋排列的正方形矩阵
     示例:
     输入: 3 输出: [ [ 1, 2, 3 ], [ 8, 9, 4 ], [ 7, 6, 5 ] ]
      ——————
     ｜1 2 3｜
     ｜8 9 4｜
     ｜7 6 5｜
      ——————
     
     ———————————
    ｜ 1  2  3 4｜
    ｜12 13 14 5｜
    ｜11 16 15 6｜
    ｜10  9  8 7｜
     ———————————
     */
    // 左闭右开
    fileprivate func generateMatrix(target: Int) -> [[Int]] {
        var num = [[Int]](repeating: [Int](repeating: 0, count: target), count: target)
        var startX = 0
        var startY = 0
        var count = target/2
        // 偏移量
        var offSet = 1
        var a = 1
        
        while count > 0 {
            var temi = startX
            var temj = startY
            // 上面一行
            for i in startY...(startY+target-offSet)  {
                temj = i
                if i !=  startY+target-offSet{
                    num[temi][temj] = a
                    a += 1
                }
            }
            // 右边一列
            for i in startX...(startX+target-offSet)  {
                temi = i
                if i !=  startX+target-offSet{
                    num[temi][temj] = a
                    a += 1
                }
            }
            // 下面一行
            for i in (startY...temj).reversed()  {
                temj = i
                if i != startY {
                    num[temi][temj] = a
                    a += 1
                }
            }
            // 左面一列
            for i in (startX...temi).reversed() {
                temi = i
                if i != startX {
                    num[temi][temj] = a
                    a += 1
                }
            }
            startX += 1
            startY += 1
            offSet += 2
            count -= 1
        }
        if ((target % 2) != 0) {
            num[target/2][target/2] = a;
        }
        return num
    }

}
