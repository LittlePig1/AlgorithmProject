//
//  ZFC.swift
//  AlgorithmProject
//
//  Created by LP. on 2022/2/23.
//

import UIKit

class ZFC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var num1: [Character] = ["H","a","n","n","a","h"]
        self.reverseString(&num1)
        print("第一题：\(num1)")
        
        let s = "abcdefg"
        let k = 2
        print("第二题：\(self.reverseStr(s, k))")
        
        let s1 = "We are happy."
        print("第三题：\(self.replaceSpace(s1))")
        
        let s2 = "   We     are happy.  "
        print("第四题：\(self.reverseWords(s2))")
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
    func reverseString(_ s: inout [Character]) {
        var l = 0
        var r = s.count - 1
        while l < r {
            // 使用元祖
            (s[l], s[r]) = (s[r], s[l])
            l += 1
            r -= 1
        }
    }
    /*
     给定一个字符串 s 和一个整数 k，你需要对从字符串开头算起的每隔 2k 个字符的前 k 个字符进行反转。

     如果剩余字符少于 k 个，则将剩余字符全部反转。

     如果剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符，其余字符保持原样。

     示例:

     输入: s = "abcdefg", k = 2
     输出: "bacdfeg"
     */
    func reverseStr(_ s: String, _ k: Int) -> String {
        /// 由于 String是其Characters 的集合 所以 Array(s) 可以直接转化为 字符 数组
        var ch = Array(s)
        ///  stride 函数 ：by 值为正数 则表示  最后一个值小于to的值 步伐 为 by 值  反之  by 值为负数 则表示 最后一个值大于to的值  如果 to改为 through 则表示 包含等于
        ///  其中 stride(from: 0, to: ch.count, by: 2 * k) ==  [0,4]
        for i in stride(from: 0, to: ch.count, by: 2 * k) {
            var left = i
            var right = min(s.count - 1, left + k - 1)
              
            while left < right {
                (ch[left], ch[right]) = (ch[right], ch[left])
                left += 1
                right -= 1
            }
        }
        return String(ch)
    }
    /*
     请实现一个函数，把字符串 s 中的每个空格替换成"%20"。

     示例 1： 输入：s = "We are happy."
     输出："We%20are%20happy."
     */
    func replaceSpace(_ s: String) -> String {
        var strArr = Array(s)
        var count = 0
        // 统计空格的个数
        for i in strArr {
            if i == " " {
                count += 1
            }
        }
        // left 指向旧数组的最后一个元素
        var left = strArr.count - 1
        // right 指向扩容后数组的最后一个元素（这里还没对数组进行实际上的扩容）
        var right = strArr.count + count * 2 - 1
        
        // 实际对数组扩容
        for _ in 0..<(count * 2) {
            strArr.append(" ")
        }
        while left < right {
            if strArr[left] == " " {
                strArr[right] = "0"
                strArr[right - 1] = "2"
                strArr[right - 2] = "%"
                left -= 1
                right -= 3
            } else {
                strArr[right] = strArr[left]
                left -= 1
                right -= 1
            }
        }
        return String(strArr)
    }
    /*
     给定一个字符串，逐个翻转字符串中的每个单词。

     示例 1：
     输入: "the sky is blue"
     输出: "blue is sky the"

     示例 2：
     输入: "  hello world!  "
     输出: "world! hello"
     解释: 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。

     示例 3：
     输入: "a good   example"
     输出: "example good a"
     解释: 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。
     思路：
     移除多余空格
     将整个字符串反转
     将每个单词反转
     */
    func reverseWords(_ s: String) -> String {
        var stringArr = removeSpace(s)
        reverseString(&stringArr, startIndex: 0, endIndex: stringArr.count - 1)
        reverseWord(&stringArr)
        return String(stringArr)
    }
    /// 1、移除多余的空格（前后所有的空格，中间只留一个空格）
    func removeSpace(_ s: String) -> [Character] {
        let ch = Array(s)
        var left = 0
        var right = ch.count - 1
        // 忽略字符串前面的所有空格
        while ch[left] == " " {
            left += 1
        }
        // 忽略字符串后面的所有空格
        while ch[right] == " " {
            right -= 1
        }

        // 接下来就是要处理中间的多余空格
        var lastArr = Array<Character>()
        while left <= right {
            // 准备加到新字符串当中的字符
            let char = ch[left]
            // 新的字符串的最后一个字符；或者原字符串中，准备加到新字符串的那个字符；这两个字符当中，只要有一个不是空格，就可以加到新的字符串当中
            if char != " " || lastArr[lastArr.count - 1] != " "  {
                lastArr.append(char)
            }
          
            left += 1
        }
        return lastArr
    }
    /// 2、反转整个字符串
    func reverseString(_ s: inout [Character], startIndex: Int, endIndex: Int)  {
        var start = startIndex
        var end = endIndex
        while start < end {
            (s[start], s[end]) = (s[end], s[start])
            start += 1
            end -= 1
        }
    }

    /// 3、再次将字符串里面的单词反转
    func reverseWord(_ s: inout [Character]) {
        /// 反转的单词在字符串里起始位置
        var start = 0
        /// 反转的单词在字符串里终止位置
        var end = 0
        /// 标记枚举字符串的过程中是否已经进入了单词区间
        var entry = false

        for i in 0..<s.count {
            if !entry {
                /// 确定单词起始位置
                start = i
                /// 进入单词区间
                entry = true
            }
            /// 单词后面有空格的情况，空格就是分词符
            if entry && s[i] == " " && s[i - 1] != " " {
                end = i - 1
                entry = false
                reverseString(&s, startIndex: start, endIndex: end)
            }
            /// 最后一个结尾单词之后没有空格的情况
            if entry && (i == s.count - 1) && s[i] != " " {
                end = i
                entry = false
                reverseString(&s, startIndex: start, endIndex: end)
            }
        }
    }
}
