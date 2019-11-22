<p align="center">
   <img width="500" src="https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/header_CiaoTransitions.png" alt="CiaoTransitions  Logo">
</p>

<p align="center">
   <a href="https://cocoapods.org/pods/CiaoTransitions">
      <img src="https://img.shields.io/cocoapods/v/CiaoTransitions.svg?style=flat&colorB=2EC9DD" alt="Version">
   </a>
   <!--
   <a href="https://github.com/Carthage/Carthage">
      <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage Compatible">
   </a>
   -->
   <a href="https://cocoapods.org/pods/CiaoTransitions">
      <img src="https://img.shields.io/cocoapods/l/CiaoTransitions.svg?style=flat)" alt="License">
   </a>
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.0-blue.svg?style=flat&colorB=2EC9DD" alt="Swift 5.0">
   </a>
   <a href="https://cocoapods.org/pods/CiaoTransitions">
      <img src="https://img.shields.io/cocoapods/p/CiaoTransitions.svg?style=flat&colorB=2EC9DD" alt="Platform">
   </a>
   <!--
   <a href="https://alberdev.github.io/CiaoTransitions">
      <img src="https://github.com/alberdev/CiaoTransitions/blob/gh-pages/badge.svg" alt="Documentation">
   </a>
   -->
   <a href="https://twitter.com/alberdev/">
      <img src="https://img.shields.io/badge/Twitter-@alberdev-blue.svg?style=flat&colorB=2EC9DD" alt="Twitter">
   </a>
   
</p>

<br/>

<p align="center">
   With <b>CiaoTransitions</b> you can make fancy custom push and modal transitions in your ios projects. You only need to follow some simple steps to implement it. Ciao is customizable and easy to use.
</p>

<br/>

<p align="center" >
<img src="https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/video_ciao.gif" alt="CiaoTransitions" title="CiaoTransitions demo">
</p>

# CiaoTransitions

- [x] Make awesome transitions
- [x] Totally customizable
- [x] App Store simulated transition included!
- [x] Easy usage
- [x] Supports iOS, developed in Swift 4

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
	- [CiaoConfigurator](#ciaoconfigurator)
	- [CiaoScaleConfigurator](#ciaoscaleconfigurator)
	- [CiaoAppStoreConfigurator](#ciaoappstoreconfigurator)
- [Transition Types](#transitiontypes)
	- [Basic Transitions](#basictransitions)
	- [Special Transitions](#specialtransitions)
- [Apps using CiaoTransitions](#apps-using-ciaotransitions)
- [Author](#author)
- [Credits](#credits)
- [Contributing](#contributing)
- [License](#license)


## Installation

Ciao is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile and run `pod install`:

```ruby
pod 'CiaoTransitions'
```

Then you can import it when you need

```swift
import CiaoTransitions
```

## Usage

In the example you will see some custom transitions that can be used in your project. Once you've installed, follow next steps. It's really simple:

### 1. Add CiaoTransition to your presented view controller

Add `CiaoTransition` to your presented view controller. This is neccessary to save your retain your transition for dismissed interaction. Also you could need it if have some scroll view. In this case, you should call  `didScroll` method when the view is scrolled

```swift
class DetailViewController: CiaoBaseViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var ciaoTransition: CiaoTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ciaoTransition?.didScroll(scrollView)
    }
}
```

> Important: If the view have some **Scroll View**, you must implement UIScrollViewDelegate protocol and call  `didScroll` method when the view is scrolled. This is needed by `CiaoTransition` to manage interactive transitions.

### 2. Instace CiaoTransition with your values

Before presenting your view controller, you need to create an instance of `CiaoTransition` and add it to your presented view controller.

```swift
// How to instance a CiaoTransition object
let ciaoTransition = CiaoTransition(
		style: CiaoTransitionStyle, 
		configurator: CiaoConfigurator? = nil, 
		scaleConfigurator: CiaoScaleConfigurator? = nil, 
		appStoreConfigurator: CiaoAppStoreConfigurator? = nil)
```
>**CiaoConfigurator** is used to setup your custom values for transition animation
>
>**CiaoScaleConfigurator** is required to make `scale` style transitions
>
>**CiaoAppStoreConfigurator** is required to make `appStore` style transitions


#### Example with Storyboard

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let detailViewController = segue.destination as? DetailViewController else { return }
    let ciaoTransition = CiaoTransition(style: .vertical)
    detailViewController.ciaoTransition = ciaoTransition
    navigationController?.delegate = ciaoTransition
}
```

#### Example push with Xibs
```swift
func presentDetailView() {
	let ciaoTransition = CiaoTransition(style: .vertical)
	let detailViewController = DetailViewController()
	detailViewController.ciaoTransition = ciaoTransition
	navigationController?.delegate = ciaoTransition
	navigationController?.pushViewController(detailViewController, animated: true)
}
```

#### Example modal with Xibs
```swift
func presentDetailView() {
	let ciaoTransition = CiaoTransition(style: .vertical)
	let detailViewController = DetailViewController()
	detailViewController.ciaoTransition = ciaoTransition
	detailViewController.transitioningDelegate = ciaoTransition
	present(detailViewController, animated: true, completion: nil)
}
```

#### Example modal with Navigation Controller
```swift
func presentDetailView() {
let ciaoTransition = CiaoTransition(style: .vertical)
let detailViewController = DetailViewController()
detailViewController.ciaoTransition = ciaoTransition

let navigationController = UINavigationController(rootViewController: detailViewController)
navigationController.transitioningDelegate = ciaoTransition

present(navigationController, animated: true, completion: nil)
}
```

## Configuration

### CiaoConfigurator
Customize your transition creating an instance of `CiaoConfigurator`

```swift
/// Present animation duration
public var duration: TimeInterval = 0.8

/// This block is executed when the view has been presented
public var presentCompletion: (()->Void)? = nil

/// This block is executed when the view has been dismissed
public var dismissCompletion: (()->Void)? = nil

/// Enable or disable fade effect on main view controller
public var fadeOutEnabled = true

/// Enable or disable fade effect on presented view controller
public var fadeInEnabled = false

/// Enable or disable scale 3d effect on back main view controller
public var scale3D = true

/// Enable or disable lateral translation on main view controller
public var lateralTranslationEnabled = false

/// Enable or disable lateral swipe to dismiss view
public var dragLateralEnabled = false

/// Enable or disable vertical swipe to dismiss view
public var dragDownEnabled = true
```

Then, you can pass these configuration params through CiaoTransition instance:

```swift
let configurator = CiaoConfigurator()
let ciaoTransition = CiaoTransition(style: .vertical, configurator: configurator)
```

### CiaoScaleConfigurator
Scale transition configurator is required to make scale transitions. For this, Ciao need some information about view you are going to scale. First create an instance of `CiaoScaleConfigurator ` and setup your custom params.

```swift
/// Source image view is going to be scaled from your initial view controller
public var scaleSourceImageView: UIImageView?
    
/// Source image view frame converted to superview in view controller.
public var scaleSourceFrame: CGRect = .zero
    
/// This is the tag asigned to your image view in presented view controller
public var scaleDestImageViewTag: Int = 1000000000
    
/// Destination image view frame in presented view controller
public var scaleDestFrame: CGRect = .zero
```
>To setup `scaleSourceFrame ` it's important convert rect in source image view frame to superview in view controller. See next example:

```swift
// Convert image view frame to view under collection view
let rectInView = cell.convert(cell.imageView.frame, to: collectionView.superview)
scaleConfigurator.scaleSourceFrame = rectInView
```
>Tagging your image view in presented view controller is required to help `CiaoTransition` getting the view to make interactive transitions. Remember using the same tag in your image view & `scaleDestImageViewTag`

![Sample1](https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/sample_screenshot1.png)

```swift
scaleConfigurator. scaleDestImageViewTag = 100
```

### CiaoAppStoreConfigurator
App Store transition configurator is required to simulate app store interactive transitions. For this, Ciao need some information about view you are going to scale. First create an instance of `CiaoAppStoreConfigurator` and setup your custom params.

```swift
/// Collection view cell used to expand the card view
let fromCell: CiaoCardCollectionViewCell

/// This is the tag asigned to your expanded view in presented view controller
let toViewTag: Int
```
>See next example to instance the configurator:

```swift
let appStoreConfigurator = CiaoAppStoreConfigurator(fromCell: cell, toViewTag: 100)
```

## Transition Types

### Basic Transitions

```swift
/// Vertical transition. Drag down or lateral to dismiss the view (by default).
CiaoTransitionStyle.vertical

/// Lateral translation transition. Drag down or lateral to dismiss the view (by default).
CiaoTransitionStyle.lateral

/// Transition with scaled image. Drag down or lateral to dismiss the view (by default).
CiaoTransitionStyle.scaleImage
```

### Special Transitions

```swift
/// Special simulated App Store transition. Drag down or lateral to dismiss the view (by default).
CiaoTransitionStyle.appStore
```

## Extra
Additionally you can enable or disable dismiss gesture transitions whenever you want. 

```swift
// Enable gesture interactive transitions on dismiss
ciaoTransition.enable()

// Disable gesture interactive transitions on dismiss
ciaoTransition.disable()
```

## Apps using CiaoTransitions

If you use `CiaoTransitions` I'd love to hear about it and feature your app here!

<img src="Images/Apps/fashtime.png" width="50" height="50" valign="middle"> [FashTime](https://itunes.apple.com/app/fashtime-the-new-way/id1126538070?mt=8)

## Author

Alberto Aznar, info@alberdev.com

## Credits

I used open source project [iOS 11 App Store Transition](https://github.com/aunnnn/AppStoreiOS11InteractiveTransition) made by [Wirawit Rueopas](https://github.com/aunnnn) to simulate one of transitions.

## Contributing

Feel free to collaborate with ideas 💭, issues ⁉️ and/or pull requests 🔃.

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

Ciao is available under the MIT license. See the LICENSE file for more info.

## Libraries by @alberdev

<a href="https://github.com/alberdev/AnimatedField"><img align="left" width="100" src="https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/Pods/AnimatedField.png" alt="AnimatedField  Logo" vspace="10"></a>
<a href="https://github.com/alberdev/ContentLoader"><img align="left" width="100" src="https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/Pods/ContentLoader.png" alt="ContentLoader  Logo" vspace="10"></a>
<a href="https://github.com/alberdev/CiaoTransitions"><img align="left" width="100" src="https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/Pods/CiaoTransitions.png" alt="CiaoTransitions  Logo" vspace="10"></a>
<a href="https://github.com/alberdev/DateScrollPicker"><img align="left" width="100" src="https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/Pods/DateScrollPicker.png" alt="DateScrollPicker  Logo" vspace="10"></a>
<a href="https://github.com/alberdev/EmptyStateKit"><img align="left" width="100" src="https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/Pods/EmptyStateKit.png" alt="EmptyStateKit  Logo" vspace="10"></a>
<a href="https://github.com/alberdev/GridTimerView"><img align="left" width="100" src="https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/Pods/GridTimerView.png" alt="GridTimerView  Logo" vspace="10"></a>
<a href="https://github.com/alberdev/PaintCodeKit"><img align="left" width="100" src="https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/Pods/PaintCodeKit.png" alt="PaintCodeKit  Logo" vspace="10"></a>
