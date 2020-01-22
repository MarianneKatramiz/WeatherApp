
# Weather iOS App

Create landing screen which navigates to the Step 1 and Step 2.

STEP I 
1. The app should accept multiple city names from the user(comma Separated) and display following attributes using api’s to fetch current temperatures. User should enter minimum 3 cities and max 7 cities. https://openweathermap.org/current
Temperature (Min and Max), 
Weather (description), 
Wind Speed  

STEP II
1. Find the current city using GPS
2. Display the weather forecast for the current city for 5 days 3 hours for current City in a list. Refer following link to get forecast for 5 days and display above mentioned attributes for 5 days 3 hours by clubbing each day. 
https://openweathermap.org/forecast5 

More details for the API can be found here
http://openweathermap.org/API#forecast

## Getting Started
Before running, you must route to the project's directory and run "~: pod install"

### App flow
-  The app will start with "func start()" in ApplicationCoordinator.swift, then from there, the app will start "func startApplication()"
- MainViewController.swift contains two items that navigate into Step 1 "Search for cities" and Step 2 "Current City" screen.

### Step 1 - Search for cities: 
    - Searching for the specific city name
    
### Step 2 - Current City: 
    - First time entering the screen, the app will ask the user for permission to access the location.
    - Allow access to the location, the app will fetch longitude and latitude of the current location.
    - Denied access to the location, the app will show an alert message that the permission is denied and the user has the option to open the mobile settings and allow access to the location.

## Design Pattern
### This project is using MVVM-C design pattern.

## This app is using the below pods as dependencies
  - SwiftLint: For Swift style and conventions
  - Alamofire: For HTTP Networking
  - IQKeyboardManagerSwift: For keyboard
  - Localize-Swift: For localization and in-app language switching
  - SwiftMessages: A very flexible message bar
  - RxSwift: Reactive Programming
  - RxCocoa: Reactive Programming
  - KeychainSwift: Helper functions for saving text in Keychain securely
  - SwiftLocation: GPS tracking

## Main features
  - Supports Light and Dark theme
  - Supports Localizable String
  - Supports access to Location
  - The API call supports language which is based on device language

## Automation
- This project is using fastlane command line to run UnitTesting classes. To run it, write "fastlane tests" on terminal
- You can configure the Fastfile -> lanes for additioanl fastlane usage, e.g: Beta Release, AppStore Release

## Documentation
- This porject is using Jazzy command line to create docs folder. To create docs folder write "jazzy --min-acl internal" on terminal
- Find docs folder under the project.
