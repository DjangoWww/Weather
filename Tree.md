.
├── AppDelegate.swift
├── Base.lproj
│   └── LaunchScreen.storyboard
├── Components
│   └── Print
│       └── Print.swift
├── Constants
│   └── ServerAPI
│       ├── ServerAPI.swift
│       ├── ServerWeatherForcastModelReq.swift
│       └── ServerWeatherForcastModelRes.swift
├── Extensions
│   ├── Foundation
│   │   ├── Array+Extension.swift
│   │   ├── Codable+Extension.swift
│   │   ├── Error+Extension.swift
│   │   ├── Int+Extension.swift
│   │   ├── NonIntegerNumber+Extension.swift
│   │   ├── Sequence+Extension.swift
│   │   ├── String+Extension.swift
│   │   └── URL+Extension.swift
│   ├── Moya
│   │   └── Moya+Extension.swift
│   └── UIKit
│       ├── UIColor+Extension.swift
│       ├── UINavigationController+Pop.swift
│       ├── UIView+Awakable.swift
│       ├── UIView+ContainingVC.swift
│       ├── UIView+Frame.swift
│       ├── UIView+Gradient.swift
│       ├── UIView+IB.swift
│       └── UIView+Rotate.swift
├── Modules
│   ├── WeatherDetail
│   │   ├── WeatherDetailVC.swift
│   │   ├── WeatherDetailVC.xib
│   │   └── WeatherDetailVM.swift
│   └── WeatherList
│       ├── Views
│       │   ├── WeatherListTableViewCell.swift
│       │   └── WeatherListTableViewCell.xib
│       ├── WeatherListVC.swift
│       ├── WeatherListVC.xib
│       └── WeatherListVM.swift
├── Resources
│   ├── Assets
│   │   └── Assets.xcassets
│   │       ├── AccentColor.colorset
│   │       │   └── Contents.json
│   │       ├── AppIcon.appiconset
│   │       │   ├── Contents.json
│   │       │   ├── Icon-20@2x.png
│   │       │   ├── Icon-20@3x.png
│   │       │   ├── Icon-29@2x.png
│   │       │   ├── Icon-29@3x.png
│   │       │   ├── Icon-40@2x.png
│   │       │   ├── Icon-40@3x.png
│   │       │   ├── Icon-60@2x.png
│   │       │   ├── Icon-60@3x.png
│   │       │   └── iTunesArtwork@2x.png
│   │       ├── Contents.json
│   │       └── LaunchStoryboard
│   │           ├── Contents.json
│   │           └── spongebob.imageset
│   │               ├── Contents.json
│   │               └── spongebob@3x.png
│   ├── CoreData
│   │   └── Weather.xcdatamodeld
│   │       └── Weather.xcdatamodel
│   │           └── contents
│   └── Plists
│       └── Info.plist
├── Service
│   ├── Network
│   │   └── Plugins
│   │       ├── NetWorksActivityPlugin.swift
│   │       ├── NetWorksIndicatorScheduler.swift
│   │       └── NetWorksLoggerPlugin.swift
│   └── ServerProvider
│       ├── ServerModelTypeRes.swift
│       ├── ServerProvider.swift
│       ├── ServerRedirectHandler.swift
│       ├── ServerRequestInterceptor.swift
│       └── ServerTrusManager.swift
└── Vendors
    ├── Then
    │   └── Then.swift
    └── Toast
        └── Toast.swift

31 directories, 58 files
