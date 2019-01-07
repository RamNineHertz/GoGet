//
//  BookingDetailsVC.swift
//  GoGet
//
//  Created by Deepak on 1/5/19.
//  Copyright © 2019 NineHertz. All rights reserved.
//

import UIKit

struct Company  {
    
    var id: Int
    var name: String
    var description: String
    var lat: Double
    var lon: Double

}

struct Vehicle  {
    
    var id: Int
    var name: String
    var description: String
    var fuelType: String
    var capacity: Int
    var numberPlate: String
    var image: String

}


class BookingDetailsVC: UIViewController {

    var vBooking : VehicleBookings? = nil
    var bookingVehicle : Vehicle? = nil
    var bookingCompany : Company? = nil

    @IBOutlet weak var lblCompanyDescription: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblVehicleName: UILabel!
    @IBOutlet weak var lblVehicleCapacity: UILabel!
    @IBOutlet weak var lblFuelPin: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEstimateCost: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblFreeKm: UILabel!
    @IBOutlet weak var imgVehicle: UIImageView!

    @IBOutlet weak var lblVehiclePlateNo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // self.navigationController!.navigationBar.topItem!.title = "Back"

        self.title = "Booking Details"
        self.getvehicleDetails()
        self.getcompanyDetails()
        self.setupDetails()
        // Do any additional setup after loading the view.
    }

    func getvehicleDetails()
    {
        
        if let dictvehicles = loadJson(filename: "vehicles") {
            
            let arrVehicles = dictvehicles["Vehicles"] as! NSArray
            
            let predicate = NSPredicate(format: "id == %d", (self.vBooking?.vehicleId)!)
            let arrVehicle = arrVehicles.filtered(using: predicate)
            
            if (arrVehicle.count) > 0 {
                
                let dictVehicle = arrVehicle[0] as! NSDictionary
                
                let id  = dictVehicle.object(forKey: kID) as! Int
                let name = dictVehicle.object(forKey: kName) as! String
                let description = dictVehicle.object(forKey: kDescription) as! String
                let fuelType  = dictVehicle.object(forKey: kfuelType) as! String
                let capacity = dictVehicle.object(forKey: kCapacity) as! Int
                let numberPlate = dictVehicle.object(forKey: knumberPlate) as! String
                let image = dictVehicle.object(forKey: kImage) as! String
                
                self.bookingVehicle = Vehicle.init(id: id, name: name, description: description, fuelType: fuelType, capacity: capacity, numberPlate: numberPlate, image: image)
            }
        }
    }
    
    
    func getcompanyDetails()
    {
        if let dictvehicles = loadJson(filename: "pods")
        {
            let arrCompanies = dictvehicles["pods"] as! NSArray
            
            //let arrCompanies = loadJson(filename: "pods")
            
            let predicate = NSPredicate(format: "id == %d", (self.vBooking?.podId)!)
            let arrCompany = arrCompanies.filtered(using: predicate)
            
            if (arrCompany.count) > 0 {
                
                let dictCompany = arrCompany[0] as! NSDictionary
                
                let id  = dictCompany.object(forKey: kID) as! Int
                let name = dictCompany.object(forKey: kName) as! String
                let description = dictCompany.object(forKey: kDescription) as! String
                let lat  = dictCompany.object(forKey: kLat) as! Double
                let lon = dictCompany.object(forKey: kLon) as! Double
                
                self.bookingCompany = Company.init(id: id, name: name, description: description, lat: lat, lon: lon)
            }
        }
    }
    
    func setupDetails()
    {
        self.lblCompanyName.text = self.bookingCompany?.name
        self.lblCompanyDescription.text = self.bookingCompany?.description
        self.lblVehicleName.text = self.bookingVehicle?.name
        
        if let capacity = self.bookingVehicle?.capacity
        {
            self.lblVehicleCapacity.text = "\(capacity)"
        }
        self.lblVehiclePlateNo.text = self.bookingVehicle?.numberPlate
        
        self.lblStartDate.text = convertDatetoShownDate(strDate: (self.vBooking?.startTime)!, strDateformat: "EEEE dd MMM,hh:mm a")
        
        self.lblEndDate.text = convertDatetoShownDate(strDate: (self.vBooking?.endTime)!, strDateformat: "EEEE dd MMM,hh:mm a")
        
        if let estimatedCost = self.vBooking?.estimatedCost
        {
            self.lblEstimateCost.text = "$\(estimatedCost)"
        }

        self.lblFuelPin.text = self.vBooking?.fuelPin
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.lblDuration.text = getdurationbetweenDates(fromDate: dateFormatter.date(from: (self.vBooking?.startTime)!)!, toDate: dateFormatter.date(from: (self.vBooking?.endTime)!)!)
        
        if let freeKm = self.vBooking?.freeKmsTotal
        {
            self.lblFreeKm.text = "(\(freeKm) free kms included)"
        }
        
        DispatchQueue.main.async
        {
            self.imgVehicle.cacheImage(urlString: (self.bookingVehicle?.image)!)
        }
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



