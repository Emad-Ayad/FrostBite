# 🌨️ FrostBite
 
A clean, native iOS weather app built with SwiftUI that shows real-time weather, hourly forecasts, and lets you save favourite cities.
 
---
 
## Features
 
- 🌍 **Live Location** — automatically detects your city using CoreLocation
- 🌤️ **Current Weather** — temperature, condition, feels like, humidity, visibility, and pressure
- 📅 **3-Day Forecast** — tap any day to see an hourly breakdown
- 🔍 **City Search** — search any city with live autocomplete suggestions
- ⭐ **Favourites** — save cities and swipe to delete, tap to navigate
- 🌅 **Day/Night Theme** — background and colors adapt based on time of day
- 💾 **Persistent Storage** — favourites saved locally using SwiftData
- ✨ **Splash Screen** — Lottie animation on launch
---
 
## Tech Stack
 
| Layer | Technology |
|---|---|
| UI | SwiftUI |
| Architecture | MVVM |
| Networking | Alamofire |
| Persistence | SwiftData |
| Location | CoreLocation |
| Animation | Lottie |
| Weather Data | [WeatherAPI.com](https://www.weatherapi.com) |
 
--- 
## Getting Started
 
### Prerequisites
 
- Xcode 16+
- iOS 17+
- A free API key from [weatherapi.com](https://www.weatherapi.com)
### Installation
 
1. Clone the repo
```bash
git clone https://github.com/Emad-Ayad/FrostBite.git
cd FrostBite
```
 
2. Open `FrostBite.xcodeproj` in Xcode
3. Add your API key in `WeatherService.swift`
```swift
private let apiKey = "YOUR_API_KEY_HERE"
```
 
4. Add a Lottie JSON animation named `weather_animation.json` to the project (get one free from [lottiefiles.com](https://lottiefiles.com))
5. Add dependencies via Swift Package Manager:
   - [Alamofire](https://github.com/Alamofire/Alamofire)
   - [Lottie](https://github.com/airbnb/lottie-ios)
6. Build and run on simulator or device
---
 
## Permissions
 
The app requires location permission to show weather for your current city. Add the following key to your `Info.plist`:
 
```
NSLocationWhenInUseUsageDescription
We use your location to show local weather.
```
 
---
 
## Architecture
 
FrostBite follows **MVVM** (Model-View-ViewModel):
 
- **Models** — `WeatherResponse`, `SavedLocation` (SwiftData model)
- **ViewModels** — handle business logic, API calls, and state
- **Views** — purely declarative SwiftUI, no logic
- **Services** — `WeatherService` for API calls, `LocationManager` for location
---
 
## API
 
Weather data is powered by [WeatherAPI.com](https://www.weatherapi.com). The free tier includes:
 
- Current weather
- 3-day forecast with hourly data
- City search/autocomplete
---
 
Made with ❤️ and SwiftUI
