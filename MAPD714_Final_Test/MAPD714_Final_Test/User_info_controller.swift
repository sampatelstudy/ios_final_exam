//  Description : Final examination
//  User_info_controller.swift
//  MAPD714_Final_Test
//  Created by Samir Patel on 2022-12-12.
//  Author Name : Samir Patel
//  Student ID : 301286671

import UIKit
import Firebase
import FirebaseDatabase

class User_info_controller: UIViewController
{
    let database_ref = Database.database().reference()
    var mode = "Metric"
    private var bmiscore: [BMI_track_model] = []
    
    @IBOutlet weak var Name_text_field: UITextField!
    @IBOutlet weak var Age_text_field: UITextField!
    @IBOutlet weak var Height_text_field: UITextField!
    @IBOutlet weak var weight_text_field: UITextField!
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var height_subpart: UILabel!
    @IBOutlet weak var weight_subpart: UILabel!
    
    @IBOutlet weak var bmi_result_label: UILabel!
    @IBOutlet weak var category_result_label: UILabel!
    
    @IBOutlet weak var result_view: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        bmi_result_label.text = ""
        category_result_label.text = ""
        unit_changes()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        persistant_entry()
    }
    func unit_changes()
    {
        if(mode == "Metric")
        {
            height_subpart.text = "(in m)"
            weight_subpart.text = "(in kg)"
        }
        else
        {
            height_subpart.text = "(in inch)"
            weight_subpart.text = "(in lbs)"
        }
    }
    
    @IBAction func switch_change(_ sender: UISwitch)
    {
        if(sender.isOn)
        {
            mode = "Metric"
        }
        else
        {
            mode = "Imperial"
        }
        self.Height_text_field.text = ""
        self.weight_text_field.text = ""
        unit_changes()
    }

    @IBAction func BMI_Calculate(_ sender: Any)
    {
        if(!Height_text_field.text!.isEmpty && !weight_text_field.text!.isEmpty)
        {
            if(Double(Height_text_field.text!) != nil && Double(weight_text_field.text!) != nil)
            {
                let result = bmi_ans(weight: Double(weight_text_field.text!)!, height: Double(Height_text_field.text!)!, mode: mode)
                var c_bmi = result.bmi
                bmi_result_label.text = String(format: "%.1f", c_bmi)
                category_result_label.text = result.Category
                let date = Date()
                let date_obj = DateFormatter()
                date_obj.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = date_obj.string(from: date)
                let c_name = Name_text_field.text
                let c_age = Age_text_field.text
                let c_height = Height_text_field.text
                let c_weight = weight_text_field.text
                let c_category = category_result_label.text
                
               
                self.database_ref.child(dateString).setValue([
                    "name": c_name!,
                    "age": c_age!,
                    "height": c_height!,
                    "weight": c_weight!,
                    "bmi": c_bmi,
                    "category": c_category!,
                    "mode": mode,
                    "date": dateString
                ])
                }
        }
        else
        {
            bmi_result_label.text = ""
            category_result_label.text = ""
        }
    }

    @IBAction func Done(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }
    
    func persistant_entry()
    {
        database_ref.queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { [self] (child) in
            if
                let snapshot = child as? DataSnapshot,
                let dataChange = snapshot.value as? [String:AnyObject],
                let p_name = dataChange["name"] as? String?,
                let p_age = dataChange["age"] as? String?,
                let p_height = dataChange["height"] as? String?,
                let p_weight = dataChange["weight"] as? String?,
                let mode = dataChange["mode"] as? String?,
                let p_bmi = dataChange["bmi"] as? Double?,
                let p_category = dataChange["category"] as? String {
                
                self.Name_text_field.text = p_name
                self.Age_text_field.text = p_age
                self.Height_text_field.text = p_height
                self.weight_text_field.text = p_weight
                self.bmi_result_label.text = String(format: "%.1f", p_bmi!)
                self.category_result_label.text = p_category
                self.mode = mode!
                result_view.backgroundColor = UIColor(red: (232/255.0), green: (203/255.0), blue: (146/255.0), alpha: 1.0)
                self.unit_changes()
            }
        });
    }
}
