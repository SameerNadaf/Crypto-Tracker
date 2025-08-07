# Crypto‑Tracker 🪙

A SwiftUI-based iOS app built in Swift, **Crypto‑Tracker** displays real-time cryptocurrency data with charts, coin details, portfolio tracking, and rich visual interactions.

---

## 🚀 Features

📈 Live Cryptocurrency Market Data  
🔍 Coin Search with Real-Time Filtering  
📊 Interactive Coin Detail Charts  
💼 Portfolio Tracking & Holdings Overview  
⚡ Local Caching for Faster Performance  
🎨 Custom SwiftUI Design & Theming  
📱 Responsive Layout for iPhone & iPad  
🧭 MVVM Architecture  
🧩 Reusable Components (Buttons, Views, Cards)  
🪝 Smooth Animations & Haptic Feedback  
🌙 Dark Mode Support  
🧪 Clean Code Structure for Scalability  

---

## 🧰 Tech Stack

🧑‍💻 Language: Swift  
🖼️ UI Framework: SwiftUI  
🗺️ Charts: Swift Charts  
📦 Architecture: MVVM  
📡 Networking: URLSession  
🛠️ State Management: Combine  
🧪 Local Cache: FileManager
💻 IDE: Xcode  
🚀 Deployment Target: iOS 15+

---

## 📁 Project Structure
```
├── CryptoTracker.xcodeproj
│   ├── project.pbxproj
├── project.xcworkspace
├── xcuserdata
├── CryptoTracker
│   ├── Assets.xcassets
│   │   ├── AppIcon.appiconset
│   │   ├── Contents.json
│   │   ├── Images
│   │   ├── LaunchColors
│   │   └── ThemeColors
│   │       
│   ├── Core
│   │   ├── Components
│   │   │   ├── CircleButton
│   │   │   │   ├── CircleButtonAnimationView.swift
│   │   │   │   └── CircleButtonView.swift
│   │   │   ├── CoinImage
│   │   │   │   ├── CoinImageView.swift
│   │   │   │   ├── CoinImageViewModel.swift
│   │   │   │   └── CoinLogoView.swift
│   │   │   ├── SearchBarView.swift
│   │   │   └── StatisticView.swift
│   │   ├── Detail
│   │   │   ├── ViewModels
│   │   │   │   └── DetailViewModel.swift
│   │   │   └── Views
│   │   │       ├── ChartView.swift
│   │   │       └── DetailView.swift
│   │   ├── Home
│   │   │   ├── ViewModels
│   │   │   │   └── HomeViewModel.swift
│   │   │   └── Views
│   │   │       ├── CoinRowView.swift
│   │   │       ├── HomeStatView.swift
│   │   │       ├── HomeView.swift
│   │   │       └── PortfolioView.swift
│   │   ├── Launch
│   │   │   └── Views
│   │   │       ├── LaunchScreen.storyboard
│   │   │       └── LaunchView.swift
│   │   └── Settings
│   │       ├── ViewModels
│   │       │   └── SettingsViewModel.swift
│   │       └── Views
│   │           └── SettingsView.swift
│   ├── Extensions
│   │   ├── Color.swift
│   │   ├── Date.swift
│   │   ├── Double.swift
│   │   ├── PreViewProvider.swift
│   │   ├── String.swift
│   │   └── UIApplication.swift
│   ├── Models
│   │   ├── CoinDetailModel.swift
│   │   ├── CoinModel.swift
│   │   ├── MarketDataModel.swift
│   │   ├── PortfolioContainer.xcdatamodeld
│   │   │   └── PortfolioContainer.xcdatamodel
│   │   │       └── contents
│   │   └── StatisticsModel.swift
│   ├── Services
│   │   ├── CoinDataService.swift
│   │   ├── CoinDetailService.swift
│   │   ├── CoinImageService.swift
│   │   ├── MarketDataService.swift
│   │   └── PortfolioDataService.swift
│   └── Utilities
│       ├── HapticManager.swift
│       ├── LocalFileManager.swift
│       ├── NavigationLazyView.swift
│       └── NetworkingManager.swift
├── CryptoTrackerApp.swift
└── README.md
````

---

##  Getting Started

### Prerequisites

- Xcode (latest stable version)
- iOS SDK (latest iOS version)
- Swift compatibility for SwiftUI

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/SameerNadaf/Crypto-Tracker.git
   cd Crypto-Tracker

2. **Open in Xcode**

   ```bash
   open CryptoTracker.xcodeproj
   ```

3. **Build & Run**

   * Select your iOS Simulator or device.
   * Press **Cmd + R** to run the app.

---

## Usage

* **Home Screen**: Browse live cryptocurrency stats and scroll through coins.
* **Search**: Use the search bar to filter coins of interest.
* **Coin Detail**: Tap a coin to view charts, detail stats, and portfolio insights.
* **Portfolio**: Add or manage holdings to monitor their performance over time.
* **Settings**: Customize app preferences, themes, and more.

---

## Contributing

Contributions are welcome!

1. Fork the repo.
2. Create a feature branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m "Add YourFeature"`).
4. Push to your branch (`git push origin feature/YourFeature`).
5. Open a Pull Request for review.

Please follow the existing code style and SwiftUI best practices.

---

## License

**MIT License** 

---

## Contact & Attribution

Developed by **Sameer Nadaf**.
Reach out via GitHub or drop a star if you find the project useful!

---

## Acknowledgments

* [CoinGecko](https://www.coingecko.com) for crypto data
* SwiftUI and Combine frameworks for reactive and declarative UI

---
