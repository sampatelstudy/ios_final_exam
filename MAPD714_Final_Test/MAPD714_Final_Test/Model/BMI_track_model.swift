//  Description : Final examination
//  BMI_track_model.swift
//  MAPD714_Final_Test
//  Created by Samir Patel on 2022-12-12.
//  Author Name : Samir Patel
//  Student ID : 301286671

import Foundation

class BMI_track_model
{
    var name: String
    var age: Int
    var height: Double
    var weight: Double
    var bmi: Double
    var category: String
    var mode: String
    var date: String
        
    init( name: String, age:Int = 1, height: Double = 0.0, weight: Double = 0.0, bmi: Double = 0.0, category: String = "", mode: String = "", date: String = "")
    {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.bmi = bmi
        self.category = category
        self.mode = mode
        self.date = date
    }
}
