//
//  MybookingVC.swift
//  GoGetMobile
//
//  Created by Deepak on 1/5/19.
//  Copyright © 2019 Deepak. All rights reserved.
//

import UIKit


struct VehicleBookings  {
    
    var id: Int
    var startTime: String
    var endTime: String
    var vehicleId: Int
    var podId: Int
    var estimatedCost: Float
    var fuelPin: String
    var freeKmsTotal: Int
    

    
}


class MybookingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblBookings: UITableView!
    var bookings: [VehicleBookings] = []

    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        self.tblBookings.tableFooterView = UIView()
        
        self.getBookingdata()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.title = "My Bookings"

    }
    
    func getBookingdata()  {
        
       // let dictVehicleBooking = loadJson(filename: "vehicleBookings")
        
        if let dictVehicleBooking = loadJson(filename: "vehicleBookings") {
            
            let arrBooking = dictVehicleBooking["vehicleBookings"] as! NSArray
            
            for dict in arrBooking {
                
                let strId = (dict as! NSDictionary).object(forKey: kID)
                let strstartTime = (dict as! NSDictionary).object(forKey: kstartTime)
                let strendTime = (dict as! NSDictionary).object(forKey: kendTime)
                let strvehicleId = (dict as! NSDictionary).object(forKey: kvehicleId)
                let strpodId = (dict as! NSDictionary).object(forKey: kpodId)
                let strestimatedCost = Float((dict as! NSDictionary).object(forKey: kestimatedCost) as! Double)
                let strfuelPin = (dict as! NSDictionary).object(forKey: kfuelPin)
                let strfreeKmsTotal = (dict as! NSDictionary).object(forKey: kfreeKmsTotal)
                
                let vBooking = VehicleBookings(id: strId as! Int, startTime: strstartTime as! String, endTime: strendTime as! String, vehicleId: strvehicleId as! Int, podId: strpodId as! Int, estimatedCost: strestimatedCost , fuelPin: strfuelPin as! String, freeKmsTotal: strfreeKmsTotal as! Int)
                
                self.bookings.append(vBooking)
                
            }
            
            self.tblBookings.reloadData()
        }
        
       
        
    }

    //MARK: UITableView Datasource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let indentifier:String = "MybookingCell"
        var cell : MybookingCell? = tableView.dequeueReusableCell(withIdentifier: indentifier) as? MybookingCell
        
        if (cell == nil)
        {
            let nib:Array = Bundle.main.loadNibNamed("MybookingCell", owner: nil, options: nil)! as [Any]
            cell = nib[0] as? MybookingCell
            cell?.selectionStyle = UITableViewCell.SelectionStyle.none
            cell?.backgroundColor = (UIColor.clear)
        }
        
        if convertDatetoShownDate(strDate: self.bookings[indexPath.row].startTime, strDateformat: "EEE dd MMM") == convertDatetoShownDate(strDate: self.bookings[indexPath.row].endTime, strDateformat: "EEE dd MMM")
        {
            cell?.lblBookingDate.text = convertDatetoShownDate(strDate: self.bookings[indexPath.row].startTime, strDateformat: "EEE dd MMM")
        }
        else
        {
            cell?.lblBookingDate.text = convertDatetoShownDate(strDate: self.bookings[indexPath.row].startTime, strDateformat: "EEE dd MMM") + " - " + convertDatetoShownDate(strDate: self.bookings[indexPath.row].endTime, strDateformat: "EEE dd MMM")
        }

        
        cell?.lblBookingTime.text = convertDatetoShownTime(strDate: self.bookings[indexPath.row].startTime) + " - " + convertDatetoShownTime(strDate: self.bookings[indexPath.row].endTime)

       // cell?.lblBookingTime.text =
        
        return cell!
    }
    
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let vHeader = UIView.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 60.0))
        
        let lblHeading = UILabel.init(frame: CGRect(x: 20.0, y: 0.0, width: UIScreen.main.bounds.size.width - 20, height: 60.0))
        
        lblHeading.font = UIFont.init(name: kGlobalFontname, size: 15.0)
        lblHeading.text = "Upcoming"
        lblHeading.textColor = UIColor.lightGray
        
        vHeader.addSubview(lblHeading)
        
        return vHeader
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    //MARK: UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let bDetailsVC : BookingDetailsVC  = BookingDetailsVC.init(nibName: "BookingDetailsVC", bundle: nil)
        bDetailsVC.vBooking = self.bookings[indexPath.row]
        self.navigationController?.pushViewController(bDetailsVC, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
