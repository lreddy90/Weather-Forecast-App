# Weather-Forecast-App

Weather-Forecast-App is native iOS app to display 5 days weather forecasts with City name and current date.
Data fetched from [OpenWeatherMap](http://openweathermap.org/forecast5).

## Install

Prerequisites:

* Create Account and generate OpenWeatherMap API Key(https://openweathermap.org/) 
* [XCode](https://developer.apple.com/xcode/)  
* [Cocoapods](http://cocoapods.org/) 

1. Open `app` folder in Terminal and run Cocoapods install:

    ```sh
    $ pod install
    ```
   
2. Update the OpenWeatherMap API Key in info plist file next to AppID key.

3. Open the WeatherMap.xcworkspace in XCode.

## Run

Use XCode to run, build and test the code:
* Choose `Run` to run the app on a Simulator or device;
* Select `Product > Build` from the menu to build the app

## MoreInfo

* Followed MVVM design patter for better understaing.
* Thirdparty libraries like 'Alamofire' and 'SVProgressHUD' used.
* Weather forecasts is hardcoded to single city as of now.

