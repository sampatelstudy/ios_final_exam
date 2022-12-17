//  Description : Final examination
//  History_Controller.swift
//  MAPD714_Final_Test
//  Created by Samir Patel on 2022-12-12.
//  Author Name : Samir Patel
//  Student ID : 301286671

import UIKit
import Firebase
import FirebaseDatabase

class History_Controller: UITableViewController
{
    let database_ref = Database.database().reference()
    private var list_object: [BMI_track_model] = []
    let Identifier = "historyCell"
    
    var name_persistant: String?
    var age_persistant: String?
    var height_persistant: String?
    var mode_persistant: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.register(History_TableViewCell.self,
                           forCellReuseIdentifier: Identifier)
        tableView.rowHeight = 120
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        persistant_entry()
        add_data()
    }
    func persistant_entry()
    {
        database_ref.queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { [self] (child) in
            if
                let snapshot = child as? DataSnapshot,
                let updated_data = snapshot.value as? [String:AnyObject],
                let g_name = updated_data["name"] as? String?,
                let g_age = updated_data["age"] as? String?,
                let g_height = updated_data["height"] as? String?,
                let g_mode = updated_data["mode"] as? String? {
                
                self.name_persistant = g_name!
                self.age_persistant = g_age!
                self.height_persistant = g_height!
                self.mode_persistant = g_mode!
                
            }
        });
    }
    
    func add_data()
    {
        list_object.removeAll()
        database_ref.observeSingleEvent(of: .value) {
            snapshot  in
            var array_object: [BMI_track_model] = []
        
            for child in snapshot.children {
        
                if
                    let snapshot = child as? DataSnapshot,
                    let updated_data = snapshot.value as? [String:AnyObject],
                    let l_name = updated_data["name"] as? String?,
                    let l_age = updated_data["age"] as? String?,
                    let l_height = updated_data["height"] as? String?,
                    let l_weight = updated_data["weight"] as? String?,
                    let l_bmi = updated_data["bmi"] as? Double,
                    let l_mode = updated_data["mode"] as? String?,
                    let l_date = updated_data["date"] as? String?,
                    let l_category = updated_data["category"] as? String {
                    
                    array_object.append(BMI_track_model(name: l_name!, age: Int(l_age!)!, height: Double(l_height!)!, weight: Double(l_weight!)!, bmi: l_bmi, category: l_category, mode: l_mode!, date: l_date!))
                    
                }
            }
            self.list_object.append(contentsOf: array_object)
            self.tableView.reloadData()
            self.database_ref.removeAllObservers()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if list_object.count == 0 {
            self.tableView.setEmptyMessage("No History Available")
        } else {

        }
        return list_object.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rect = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! History_TableViewCell
        let old_data = list_object[indexPath.row]
        
        if(old_data.mode == "Metric") {
            rect.weight_table_lbl.text = "Weight: " + String(format: "%.1f", old_data.weight) + " kg"
        } else {
            rect.weight_table_lbl.text = "Weight: " + String(format: "%.1f", old_data.weight) + " lbs"
        }
        rect.bmi_table_lbl.text = "BMI: " + String(format: "%.1f", old_data.bmi)
        rect.category_table_lbl.text = old_data.category
        rect.date_table_lbl.text = old_data.date
        return rect
    }
    
}
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let empty_msg = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        empty_msg.text = message
        empty_msg.textColor = .red
        empty_msg.numberOfLines = 0
        empty_msg.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13)

        self.backgroundView = empty_msg
    }

}
