//
//  HXB.swift
//  AlgorithmProject
//
//  Created by 王金志 on 2021/8/5.
/*  当我们遇到了要快速判断一个元素是否出现集合里的时候，就要考虑哈希法。
但是哈希法也是牺牲了空间换取了时间，因为我们要使用额外的数组，set或者是map来存放数据，才能实现快速的查找
 如果在做面试题目的时候遇到需要判断一个元素是否出现过的场景也应该第一时间想到哈希法！
*/
import UIKit

class HXB: UIViewController {

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
        
        let threeSums = [-6, 1, 2, 4, 5]
        print("三元组集合\(threeSum(threeSums))")

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
    fileprivate func getSum(_ number: Int) -> Int {
        var sum = 0
        var num = number
        while num > 0 {
            let temp = num % 10
            sum += (temp * temp)
            num /= 10
        }
        return sum
    }
    fileprivate func isHappyNum(_ n: Int) -> Bool {
        var set = Set<Int>()
        var num = n
        while true {
            let sum = self.getSum(num)
            if sum == 1 {
                return true
            }
            // 如果这个sum曾经出现过，说明已经陷入了无限循环了
            if set.contains(sum) {
                return false
            } else {
                set.insert(sum)
            }
            num = sum
        }
    }
    /*
     给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。

     示例:

     给定 nums = [2, 7, 11, 15], target = 9

     因为 nums[0] + nums[1] = 2 + 7 = 9

     所以返回 [0, 1]
     */
    fileprivate func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // 值: 下标
        var map = [Int: Int]()
        for (i, e) in nums.enumerated() {
            if let v = map[target - e] {
                return [v, i]
            } else {
                map[e] = i
            }
        }
        return []
    }
    /*
     给定四个包含整数的数组列表 A , B , C , D ,计算有多少个元组 (i, j, k, l) ，使得 A[i] + B[j] + C[k] + D[l] = 0。

     为了使问题简单化，所有的 A, B, C, D 具有相同的长度 N，且 0 ≤ N ≤ 500 。所有整数的范围在 -2^28 到 2^28 - 1 之间，最终结果不会超过 2^31 - 1 。

     例如:

     输入: A = [ 1, 2] B = [-2,-1] C = [-1, 2] D = [ 0, 2] 输出: 2 解释: 两个元组如下:

     (0, 0, 0, 1) -> A[0] + B[0] + C[0] + D[1] = 1 + (-2) + (-1) + 2 = 0
     (1, 1, 0, 0) -> A[1] + B[1] + C[0] + D[0] = 2 + (-1) + (-1) + 0 = 0
     */
    fileprivate func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
        // 字典解释 [ab和: ab和出现次数]
        var countDic = [Int: Int]()
        for a in nums1 {
            for b in nums2 {
                let key = a + b
                countDic[key] = countDic[key, default: 0] + 1
            }
        }
        // 通过-(c + d)作为key，去累加ab和出现的次数
        var result = 0
        for c in nums3 {
            for d in nums4 {
                let key = -(c + d)
                result += countDic[key, default: 0]
            }
        }
        return result
    }
    /*
     给定一个赎金信 (ransom) 字符串和一个杂志(magazine)字符串，判断第一个字符串 ransom 能不能由第二个字符串 magazines 里面的字符构成。如果可以构成，返回 true ；否则返回 false。

     (题目说明：为了不暴露赎金信字迹，要从杂志上搜索各个需要的字母，组成单词来表达意思。杂志字符串中的每个字符只能在赎金信字符串中使用一次。)

     注意：

     你可以假设两个字符串均只含有小写字母。

     canConstruct("a", "b") -> false
     canConstruct("aa", "ab") -> false
     canConstruct("aa", "aab") -> true
     */
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var record = Array(repeating: 0, count: 26);
        let aUnicodeScalarValue = "a".unicodeScalars.first!.value
        for unicodeScalar in magazine.unicodeScalars {
            // 通过record 记录 magazine 里各个字符出现的次数
            let idx: Int = Int(unicodeScalar.value - aUnicodeScalarValue)
            record[idx] += 1
        }
            
        for unicodeScalar in ransomNote.unicodeScalars {
            // 遍历 ransomNote,在record里对应的字符个数做 -- 操作
            let idx: Int = Int(unicodeScalar.value - aUnicodeScalarValue)
            record[idx] -= 1
            // 如果小于零说明在magazine没有
            if record[idx] < 0 {
                return false
            }
        }
        return true
    }
    /* 重点
     给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。

     注意： 答案中不可以包含重复的三元组。

     示例：

     给定数组 nums = [-1, 0, 1, 2, -1, -4]，

     满足要求的三元组集合为： [ [-1, 0, 1], [-1, -1, 2] ]
     */
    // 双指针法
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        var sorted = nums
        sorted.sort()
        for i in 0 ..< sorted.count {
            if sorted[i] > 0 {
                return res
            }
            if i > 0 && sorted[i] == sorted[i - 1] {
                continue
            }
            var left = i + 1
            var right = sorted.count - 1
            while left < right {
                let sum = sorted[i] + sorted[left] + sorted[right]
                if sum < 0 {
                    left += 1
                } else if sum > 0 {
                    right -= 1
                } else {
                    res.append([sorted[i], sorted[left], sorted[right]])
                        
                    while left < right && sorted[left] == sorted[left + 1] {
                        left += 1
                    }
                    while left < right && sorted[right] == sorted[right - 1] {
                        right -= 1
                    }
                        
                    left += 1
                    right -= 1
                }
            }
        }
        return res
    }
    /*  重点
     题意：给定一个包含 n 个整数的数组 nums 和一个目标值 target，判断 nums 中是否存在四个元素 a，b，c 和 d ，使得 a + b + c + d 的值与 target 相等？找出所有满足条件且不重复的四元组。

     注意：

     答案中不可以包含重复的四元组。

     示例： 给定数组 nums = [1, 0, -1, 0, -2, 2]，和 target = 0。 满足要求的四元组集合为： [ [-1, 0, 0, 1], [-2, -1, 1, 2], [-2, 0, 0, 2] ]
     */
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var res = [[Int]]()
        var sorted = nums
        sorted.sort()
        for k in 0 ..< sorted.count {
            // 这种剪枝不行,target可能是负数
            // if sorted[k] > target {
            //      return res
            // }
                
            // 去重
            if k > 0 && sorted[k] == sorted[k - 1] {
                continue
            }
                
            let target2 = target - sorted[k]
            for i in (k + 1) ..< sorted.count {
                if i > (k + 1) && sorted[i] == sorted[i - 1] {
                    continue
                }
                var left = i + 1
                var right = sorted.count - 1
                while left < right {
                    let sum = sorted[i] + sorted[left] + sorted[right]
                    if sum < target2 {
                        left += 1
                    } else if sum > target2 {
                        right -= 1
                    } else {
                        res.append([sorted[k], sorted[i], sorted[left], sorted[right]])
                        while left < right && sorted[left] == sorted[left + 1] {
                            left += 1
                        }
                        while left < right && sorted[right] == sorted[right - 1]  {
                            right -= 1
                        }
                        // 找到答案 双指针同时收缩
                        left += 1
                        right -= 1
                    }
                }
            }
        }
        return res
    }
}
