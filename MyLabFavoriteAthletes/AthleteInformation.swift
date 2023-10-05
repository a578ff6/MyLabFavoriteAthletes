//
//  AthleteInformation.swift
//  MyLabFavoriteAthletes
//
//  Created by 曹家瑋 on 2023/10/5.
//

import Foundation

/// 運動員資訊
struct AthleteInforation {
    // 運動員的名字
    var name: String
    // 運動員的年齡
    var age: Int
    // 運動員所在的聯盟
    var league: String
    // 運動員所在的隊伍
    var team: String
    
    // 當`description`被呼叫時，回傳提供關於運動員的描述
    var description: String {
        return "\(name)：目前年齡 \(age) 歲，並且在 \(league) 中為 \(team) 效力。"
    }
}
