//
//  ZFC.swift
//  AlgorithmProject
//
//  Created by LP. on 2022/2/23.
//

import UIKit

class ZFC: BaseController {

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
        
        let s3 = "lrloseumgh"
        let k1 = 6
        print("第五题：\(self.reverseString1(s3, k1))")
        
        let s4 = "hello"
        let s5 = "ll"
        print("第六题：\(self.strStr(s4, s5))")
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
    /*
     字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。请定义一个函数实现字符串左旋转操作的功能。比如，输入字符串"abcdefg"和数字2，该函数将返回左旋转两位得到的结果"cdefgab"。

     示例 1：
     输入: s = "abcdefg", k = 2
     输出: "cdefgab"

     示例 2：
     输入: s = "lrloseumgh", k = 6
     输出: "umghlrlose"

     限制：
     1 <= k < s.length <= 10000
     */
    func reverseString1(_ s: String, _ k: NSInteger) -> String{
        var chArray = Array(s)
        /// 为了 不额外申请 空间 可以这么做
        /// 1、反转区间为前n的子串 2、反转区间为n到末尾的子串 3、反转整个字符串
        var left1 = 0
        var right1 = k - 1
        while left1 < right1 {
            (chArray[left1], chArray[right1]) = (chArray[right1], chArray[left1])
            left1 += 1
            right1 -= 1
        }
        
        var left2 = k
        var right2 = s.count - 1
        while left2 < right2 {
            (chArray[left2], chArray[right2]) = (chArray[right2], chArray[left2])
            left2 += 1
            right2 -= 1
        }
        
        var left3 = 0
        var right3 = s.count - 1
        while left3 < right3 {
            (chArray[left3], chArray[right3]) = (chArray[right3], chArray[left3])
            left3 += 1
            right3 -= 1
        }
        
        return String(chArray)
    }
    /*
     实现 strStr() 函数。

     给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。

     示例 1: 输入: haystack = "hello", needle = "ll" 输出: 2

     示例 2: 输入: haystack = "aaaaa", needle = "bba" 输出: -1

     说明: 当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。 对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与C语言的 strstr() 以及 Java的 indexOf() 定义相符。
     
     涉及 KMP
     */
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        let s = Array(haystack), p = Array(needle)
        guard p.count != 0 else { return 0 }
        
        // 2 pointer
        var j = -1
        var next = [Int](repeating: -1, count: needle.count)
        // KMP
        getNext(&next, needle: p)
        for i in 0 ..< s.count {
            while j >= 0 && s[i] != p[j + 1] {
                //不匹配之后寻找之前匹配的位置
                j = next[j]
            }
            if s[i] == p[j + 1] {
                //匹配，双指针同时后移
                j += 1
            }
            if j == (p.count - 1) {
                //出现匹配字符串
                return i - p.count + 1
            }
        }
        return -1
    }

    //前缀表统一减一
    func getNext(_ next: inout [Int], needle: [Character]) {
        
        var j: Int = -1
        next[0] = j
        
        // i 从 1 开始
        for i in 1 ..< needle.count {
            while j >= 0 && needle[i] != needle[j + 1] {
                j = next[j]
            }
            if needle[i] == needle[j + 1] {
                j += 1;
            }
            next[i] = j
        }
        print(next)
    }
    /*
     给定一个非空的字符串，判断它是否可以由它的一个子串重复多次构成。给定的字符串只含有小写英文字母，并且长度不超过10000。

     示例 1:
     输入: "abab"
     输出: True
     解释: 可由子字符串 "ab" 重复两次构成。

     示例 2:
     输入: "aba"
     输出: False

     示例 3:
     输入: "abcabcabcabc"
     输出: True
     解释: 可由子字符串 "abc" 重复四次构成。 (或者子字符串 "abcabc" 重复两次构成。)
     */
    
}
