//
//  main.swift
//  test
//
//  Created by Hyeongjung on 2022/08/06.
//

import Foundation
var messages = [["2022-06-24T23:57:42", "정원", "민탁님"], ["2022-06-24T23:57:44", "정원", "생일이 얼마 안남으셨네요"], ["2022-06-24T23:57:54", "정원", "소감 한말씀 부탁드립니닼ㅋㅋㅋ"], ["2022-06-24T23:58:02", "금상", "오~ 민탁님 내일 생일이세요? 축하해요!"], ["2022-06-24T23:58:05", "민탁", "으악 감사해요 이렇게 늦은저녁까지 챙겨주시고ㅠㅠ!"], ["2022-06-24T23:58:34", "도현", "민탁님 축하드려요~~!"], ["2022-06-24T23:58:36", "도현", ""], ["2022-06-24T23:58:55", "금상", "민탁님"], ["2022-06-24T23:59:01", "금상", "생일기념 내일 뭐하시나요~"], ["2022-06-24T23:59:10", "정원", "가족과 여행?"], ["2022-06-24T23:59:12", "금상", "해외여행 가시는건가요!!"], ["2022-06-24T23:59:55", "민탁", "일주일쉬면서 가족하고 하와이갑니다~~ 축하감사해요 모두!"], ["2022-06-25T00:00:01", "정원", "이제 진짜 생일되셨네요!! 축하합니다!!"], ["2022-06-25T00:01:05", "민탁", ""]]
var message:[String] = []


var beforeName = ""
var beforeTime = ""
var date = ""
for i in messages {
    let time = i[0]
    let name = i[1]
    let text = i[2]
    let subTime = time.substring(from:0, to: 15)
    let subDate = time.substring(from:0, to:9)
    if date == "" {
        date = subDate
    }
    if date != subDate {
        date = subDate
        message.append("-- \(subDate) --")
    }
    if beforeName != name {
        if beforeTime == "" {
            beforeTime = subTime
        } else {
            message.append("(\(beforeTime.substring(from: 11, to: 15)))")
        }
        beforeName = name
        message.append("[\(name)]")
        if text == "" {
            message.append("<삭제된 메시지>")
        } else {
            message.append("\(text)")
        }
    } else {
        if beforeTime != subTime {
            beforeTime = subTime
            message.append("(\(beforeTime.substring(from: 11, to: 15)))")
        }
        if text == "" {
            message.append("<삭제된 메시지>")
        } else {
            message.append("\(text)")
        }
        if beforeTime != subTime {
            beforeTime = subTime
            message.append("(\(beforeTime.substring(from: 11, to: 15)))")
        }
    }
    
    print(message)
}
extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문
        
        // 파싱
        return String(self[startIndex ..< endIndex])
    }
}
