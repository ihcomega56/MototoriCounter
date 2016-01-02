//
//  RealmModel.swift
//  MototoriCounter
//
//  Created by Ayana Yokota on 2016/01/02.
//  Copyright © 2016年 ihcomega. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSwift: Object {
    dynamic var date = ""
    dynamic var times = 0
    dynamic var monthlyFee = 0
    dynamic var eachTimeFee = 0
    
    override static func primaryKey() -> String? {
        return "date"
    }
}

func readAllData() {
}
func writeAllData() {
}