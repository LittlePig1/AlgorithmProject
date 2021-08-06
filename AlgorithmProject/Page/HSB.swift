//
//  HSB.swift
//  AlgorithmProject
//
//  Created by 王金志 on 2021/8/5.
/*  当我们遇到了要快速判断一个元素是否出现集合里的时候，就要考虑哈希法。
但是哈希法也是牺牲了空间换取了时间，因为我们要使用额外的数组，set或者是map来存放数据，才能实现快速的查找
 如果在做面试题目的时候遇到需要判断一个元素是否出现过的场景也应该第一时间想到哈希法！
*/
import UIKit

class HSB: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
       
        let a = "anagrama", b = "nagaram"
        print("是否是字母异位词\(isSameCharInString(a, b))")
        
        let stringArray = ["bella","label","rbboller"]
        print("返回列表中的每个字符串中都显示的全部字\(getShowSameCharArray(stringArray))")
        
        let aa = [1,2,2,1], bb = [2,2]
        print("交集\(getSameObjectFromTwoArray(aa, bb))")

        let target = 19
        print("是否是快乐数\(isHappyNum(target))")
        
        let nums = [2, 7, 11, 15], target1 = 9
        print("下标\(twoSum(nums, target1))")

    }
    /*
     给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。

     示例 1: 输入: s = "anagram", t = "nagaram" 输出: true

     示例 2: 输入: s = "rat", t = "car" 输出: false

     说明: 你可以假设字符串只包含小写字母。
     */
    fileprivate func isSameCharInString(_ a: String, _ b: String) -> Bool {
        var newNum = Array<Int>(repeating: 0, count: 26)
        var origin = 0
        for char in "a".unicodeScalars {
            origin = Int(char.value)
        }
        for char in a.unicodeScalars {
            newNum[Int(char.value) - origin] += 1
        }
        for char in b.unicodeScalars {
            newNum[Int(char.value) - origin] -= 1
        }
        for item in newNum {
            if item != 0 {
                return false
            }
        }
        return true
    }
    /*
     给定仅有小写字母组成的字符串数组A，返回列表中的每个字符串中都显示的全部字符(包括重复字符)组成的列表。例如，如果一个字符在每个字符串中出现 3 次，但不是 4 次，则需要在最终答案中包含该字符3次。
     你可以按任意顺序返回答案。
     【示例一】 输入：["bella","label","roller"] 输出：["e","l","l"]
     【示例二】 输入：["cool","lock","cook"] 输出：["c","o"]
     */

    fileprivate func getShowSameCharArray(_ array: [String]) -> [Character] {
        var origin = 0
        for char in "a".unicodeScalars {
            origin = Int(char.value)
        }
        var lastArray = Array<Int>(repeating: 0, count: 26)
        var charArray = [Character]()

        for (index, item) in array.enumerated() {
            var newNum = Array<Int>(repeating: 0, count: 26)
            for char in item.unicodeScalars {
                newNum[Int(char.value) - origin] += 1
            }
            if index > 0 {
                for i in 0..<26 {
                    lastArray[i] = min(lastArray[i], newNum[i])
                }
            } else {
                lastArray = newNum
            }
        }
        for (index,item) in lastArray.enumerated() {
            if item > 0 {
                var currentItem = item
                while currentItem > 0 {
                    charArray.append(Character(UnicodeScalar(index+origin)!))
                    currentItem -= 1
                }
            }
        }
        return charArray
    }
    /*
     题意：给定两个数组，编写一个函数来计算它们的交集。
     【示例一】 输入：a = [1，2，2，1] b = [2,2]输出：[2]
     【示例二】 输入：a = [4，5，9] b = [9,4,9,8,4] 输出：[9,4]
     说明： 输出结果中的每个元素一定是唯一的。 我们可以不考虑输出结果的顺序。
     */
    fileprivate func getSameObjectFromTwoArray(_ a: [Int], _ b: [Int]) -> [Int] {
       var lastArray = [Int]()
        for item in a {
            for deepItem in b {
                if item == deepItem && !lastArray.contains(item){
                    lastArray.append(item)
                }
            }
        }
        // 这个题目也可以用 集合的特性来做 没有重复元素
        return lastArray
    }
    /*
     编写一个算法来判断一个数 n 是不是快乐数。

     「快乐数」定义为：对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和，然后重复这个过程直到这个数变为 1，也可能是 无限循环 但始终变不到 1。如果 可以变为  1，那么这个数就是快乐数。

     如果 n 是快乐数就返回 True ；不是，则返回 False 。

     示例：

     输入：19
     输出：true
     解释：
     1^2 + 9^2 = 82
     8^2 + 2^2 = 68
     6^2 + 8^2 = 100
     1^2 + 0^2 + 0^2 = 1
     */
    fileprivate func isHappyNum(_ a: Int) -> Bool {
        
        return false
    }
    /*
     给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。

     示例:

     给定 nums = [2, 7, 11, 15], target = 9

     因为 nums[0] + nums[1] = 2 + 7 = 9

     所以返回 [0, 1]
     */
    fileprivate func twoSum(_ array: [Int], _ target: Int) -> [Int] {
        var indexArray = [Int]()
        for (index, item) in array.enumerated() {
            for index1 in index ..< array.count {
                if item + array[index1] == target {
                    indexArray.append(index)
                    indexArray.append(index1)
                }
            }
        }
        return indexArray
    }
}
