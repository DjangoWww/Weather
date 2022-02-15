# Weather

- ## Description
  Basically using MVVM + RxSwift + Moya + PromiseKit to build this demo app.

  The main file is inside `Weather/Modules/`, `Weather/Service/ServerProvider` and `Weather/Constants/ServerAPI`, with some other files just for extension and other purposes


- ## Requirements
  - Xcode Version 13.1 (13A1030d)
  - Swift Version 5.5 (swiftlang-1300.0.31.1 clang-1300.0.29.1)


- ## Installation Instructions
  Install Xcode Version 13.1 (13A1030d) and open Weather.xcworkspace file with Xcode

  You can try `pod install` in case there's some pods missing


- ## About test
  You can find it in `WeatherTests.swift`, only added a few test cases since it's just a demo app.
  - WeatherListVMTests
    - testInitialState to test if the InitialState is correct
    - testReqWeatherList to test if reqWeatherList gets the correct response

  - WeatherDetailVMTests
    - testInitialState to test if the InitialState is correct
    - testIfTheTempStateIsCorrect to test if temp state is correct after setting the detailModel

  - ServerProviderTests
    - testReqWeatherForecast to test if the provider is working correctly and the result from server is valid


- ## File tree
  Check `Tree.md` file


- ## Others
  Feel free to point out if there's something wrong with the architecture, like over engineering or lack of considerations in somewhere.
