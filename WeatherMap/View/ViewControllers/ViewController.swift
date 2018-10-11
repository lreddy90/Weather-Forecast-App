//
//  ViewController.swift
//  WeatherMap
//
//  Created by Lokesh on 09/10/18.
//

import UIKit
import SVProgressHUD
class ViewController: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    let cellReuseIdentifier = "weathercell"
    var list = [List?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard Reachability.isConnectedToNetwork() else {
            Utility.showAlert(message: Constants.noInternet)
            return }
        
        Utility.showProgress()
        WeatherHandler.getWeatherData { (result: Any?, error : NSError?) in
            Utility.dissmissProgress()
            if (error != nil){
                if error?.code == 429 {
                    Utility.showAlert(message:error?.localizedDescription ?? Constants.limitExceed)
                }else {
                    Utility.showAlert(message:Constants.TryAgain)
                }
            }else {
                if let weather = result as? WeatherData, let city = weather.city?.name{
                    DispatchQueue.main.async {
                        self.cityNameLbl.text = city
                        self.timeLbl.text = self.getDate()
                        self.list = weather.list
                        self.tabelView.reloadData()
                    }
                    
                }
                //TODO: show UI and reload contant with refresh button
            }
        }
    }

    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
}

extension ViewController: UITabBarDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WeatherTableViewCell = self.tabelView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! WeatherTableViewCell
        cell.dateLbl.text = self.list[indexPath.row]?.dt_txt
        cell.tempLbl.text = self.getCelsiusTemp(kelvin: self.list[indexPath.row]?.main?.temp)
        cell.minTempLbl.text = self.getCelsiusTemp(kelvin: self.list[indexPath.row]?.main?.temp_min)
        cell.maxTempLbl.text = self.getCelsiusTemp(kelvin:self.list[indexPath.row]?.main?.temp_max)
        cell.descriptionLbl.text = "\(self.list[indexPath.row]?.weather[0]?.main ?? "")- \(self.list[indexPath.row]?.weather[0]?.description ?? "")"
        return cell
        
    }
    
    func getCelsiusTemp(kelvin:Float?)-> String {
        return String(format: "%.0f", (kelvin ?? 0) - 273.15)
    }
    
}
