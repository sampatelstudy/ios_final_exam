//  Description : Final examination
//  History_TableViewCell.swift
//  MAPD714_Final_Test
//  Created by Samir Patel on 2022-12-12.
//  Author Name : Samir Patel
//  Student ID : 301286671

import UIKit

class History_TableViewCell: UITableViewCell {
    var weight_table_lbl: UILabel!
    var bmi_table_lbl: UILabel!
    var category_table_lbl: UILabel!
    var date_table_lbl: UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
                
        let weight_position = CGRect(x:10, y:0, width: 100, height: 60)
        weight_table_lbl = UILabel(frame: weight_position)
        weight_table_lbl.font = UIFont(name: weight_table_lbl.font.fontName, size: 16)
        contentView.addSubview(weight_table_lbl)
        
        let bmi_position = CGRect(x:10, y:15, width: 100, height: 60)
        bmi_table_lbl = UILabel(frame: bmi_position)
        bmi_table_lbl.font = UIFont(name: bmi_table_lbl.font.fontName, size: 16)
        contentView.addSubview(bmi_table_lbl)
        
        let category_position = CGRect(x:10, y:30, width: 100, height: 60)
        category_table_lbl = UILabel(frame: category_position)
        category_table_lbl.font = UIFont(name: category_table_lbl.font.fontName, size: 16)
        contentView.addSubview(category_table_lbl)
        
        let date_position = CGRect(x:10, y:45, width: 100, height: 60)
        date_table_lbl = UILabel(frame: date_position)
        date_table_lbl.font = UIFont(name: date_table_lbl.font.fontName, size: 11)
        contentView.addSubview(date_table_lbl)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 30, bottom: 5, right: 30))
        contentView.backgroundColor = UIColor(red: (232/255.0), green: (203/255.0), blue: (146/255.0), alpha: 0.8)
    }

}
