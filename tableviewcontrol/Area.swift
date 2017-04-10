//
//  Area.swift
//  tableviewcontrol
//
//  Created by GeorgeMao on 2017/3/24.
//  Copyright © 2017年 GeorgeMao. All rights reserved.
//

struct Area {
    var name : String
    var province : String
    var part : String
    var areasimage : String
    var visited : Bool
    var rating = ""

    init(name: String, province: String, part: String, areasimage: String, visited: Bool) {
        
        self.name = name
        self.province = province
        self.part = part
        self.areasimage = areasimage
        self.visited = visited
        
    }

    
}

/*
Area(name: "上海交通大学电子信息与电气工程学院",province: "上海",part: "闵行",areasimage: "seiee60",visited: false),

Area(name: "上海交通大学机动学院",province: "上海",part: "闵行",areasimage: "O-Campus60",visited: false),

Area(name: "上海交通大学医学院",province: "上海",part: "卢湾",areasimage: "medicine60",visited: false)
 
 */
