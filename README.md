# LightningWatch
iOS App for monitoring the 100 most well-connected nodes in the Lightning Network. 

<img src="https://github.com/user-attachments/assets/07886b45-29e8-4fa1-976b-56ceb155cbb6" alt="simulator_screenshot" style="width:25%;">

<img src="https://github.com/user-attachments/assets/9f2a2b16-12e4-46a2-8932-dd14be416e84" alt="simulator_screenshot" style="width:25%;">

## Build tools & versions used

- **Xcode:** 16.2
- **Swift:** 6.0.3
- **macOS:** 14.7.2 (Sonoma)

## Steps to run the app

- In your console

```sh 
git clone https://github.com/louis-melone/LightningWatch
```

Open LightningWallet.xcodeproj. Once the project loads, select the scheme/target LightningWallet. Click Run.

## Focus Areas

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

__Reasons for Focus Areas__

- A clearly defined scope of the project
- Scale into a production-ready app with an expanding feature set and growing userbase 
- Clean user experience with scalable and dynamic view components 

## Time Spent

~6 hours 

## Tradeoffs

- Portrait-mode only to avoid using a Geometry Reader to format the rows 

## Future Features

- ContentPolling feature to automatically update data. 
- Network monitor to listen to changes in connection status. 
- Filter by city / country 
- Statistics above the grid (eg. total capacity)

## Weak Areas

Theme and constants management, as well as advanced error handling. Implementing a ThemeCoordinator and a more robust error-handling strategy would address this.
