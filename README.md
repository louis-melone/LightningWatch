# LightningWatch
App For Monitoring Active Lightning Network Nodes

## Build tools & versions used

XCode Version 16.2

- **Xcode:** 16.2 (Build 15C500b)
- **Swift:** 6.0.3
- **macOS:** 14.7.2 (Sonoma)

## Steps to run the app

- In your console

```sh 
git clone https://github.com/louis-melone/LightningWatch
cd LightningWatch
```

Open LightningWallet.xcodeproj. Once the project loads, select the scheme/target LightningWallet. Click Run.

## What areas of the app did you focus on?

__UI / UX__

- Grid-based list layout combined with a Sheet View for an intuitive and scannable UI.
    - Inspired by market leaders such as CoinGecko
- Separated static data and dynamic data
    - Static Data: country, city, pub key, first-seen date are displayed as more info in a sheet
    - Dynamic data: capacity, channels, last updated time are displayed in list
- User-friendly date formatting 
    - Updated date is shown in relative format for better readability
    - First seen date is a historical reference 
- Sorting feature to help users quickly analyze nodes based on key parameters

__Arcitecture__ 

- MVVM architecture to manage bussiness logic and increase testability 
- Modularization with LoadableView and LightningLoader protocol
- Resusable view components
- `Identifiable` protocol (using public key as the identifier) to imporve UI responsiveness and performance.
https://www.dhiwise.com/post/swift-identifiable-explained-how-to-use-it-in-your-swiftui

## What was the reason for your focus? What problems were you trying to solve?

- A clearly defined scope of the project given the timeframe 
- Scale into a production-ready app with an expanding feature set and growing userbase 
- Clean user experience with scalable and dynamic view components 

## How long did you spend on this project?

- 6-7 hours 

## Did you make any trade-offs for this project? What would you have done differently with more time?

__Trade Offs__

- Portrait-mode only to avoid using a Geometry Reader to format the rows 

__Future Features__

- ContentPolling feature to automatically update data. 
- ThemeCoordinator to style the list better. 
- Network monitor to listen to changes in connection status. 
- Filter by city / country 
- Statistics above the grid (total capacity)

Most of these features were part of my initial vision for the app's expansion, and I designed the architecture with future scalability in mind.

## What do you think is the weakest part of your project?

Theme and constants management, as well as advanced error handling, are areas for improvement. Implementing a ThemeCoordinator and a more robust error-handling strategy would enhance maintainability and UX.
