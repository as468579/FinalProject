//
//  record.swift
//  FinalProject
//
//  Created by User02 on 2018/12/26.
//  Copyright © 2018 User02. All rights reserved.
//

import Foundation
struct traderesult:Codable{
    var Exrate: Double
    var UTC : String
}
struct tradeInfo:Codable{
    
    var USDTWD : traderesult
    var USDJPY : traderesult
    var USDCNY : traderesult
}


struct Record:Codable
{
    var time: String
    var event: String
    static func save(records: [Record])
    {
        let Encoder = PropertyListEncoder()
        if let data = try? Encoder.encode(records)
        {
            UserDefaults.standard.set(data, forKey: "records")
        }
        
    }
    static func read() -> [Record]? {
        if let data = UserDefaults.standard.data(forKey: "records"), let records = try? PropertyListDecoder().decode([Record].self, from: data) {
            return records
        }
        else {
            return nil
        }
    }
}



