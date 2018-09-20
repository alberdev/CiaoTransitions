![CiaoTransitions logo](https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/header_Ciao.png)

# CiaoTransitions

[![Version](https://img.shields.io/cocoapods/v/CiaoTransitions.svg?style=flat&colorB=2EC9DD)](https://cocoapods.org/pods/CiaoTransitions)
[![License](https://img.shields.io/cocoapods/l/CiaoTransitions.svg?style=flat)](https://cocoapods.org/pods/CiaoTransitions)
[![Platform](https://img.shields.io/cocoapods/p/CiaoTransitions.svg?style=flat)](https://cocoapods.org/pods/CiaoTransitions)
![Swift](https://img.shields.io/badge/%20in-swift%204.2-orange.svg?style=flat&colorB=2EC9DD)


## Table of Contents

- [Description](#description)
- [Example](#example)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
	- [Default Transition Params](#defaulttransitionparams)
	- [Scale Transition Params](#scaletransitionparams)
- [Transition Types](#transitiontypes)
	- [Push Transitions](#pushtransitions)
	- [Modal Transitions](#modaltransitions)
- [Author](#author)
- [Credits](#credits)
- [Contributing](#contributing)
- [License](#license)

## Description

With `CiaoTransitions` you can make fancy custom push and modal transitions in your ios projects. You only need to follow some simple steps to implement it. Ciao is customizable and easy to use.

- [x] Make awesome transitions
- [x] Totally customizable
- [x] App Store simulated transition included!
- [x] Easy usage
- [x] Supports iOS, developed in Swift 4

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Ciao is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CiaoTransitions'
```

Then you can import it when you need

```swift
import CiaoTransitions
```

## Usage

In the example you will see some custom transitions that can be used in your project. Once you've installed this pod, follow next steps. It's really simple:

### 1. Subclass your presented view controller

Subclass your presented view controller with `CiaoBaseViewController`. This will add `CiaoTransition` to your class. 

```swift
class DetailViewController: CiaoBaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ciaoTransition?.scrollView = scrollView
    }
}
```

> Important: If the view have some **Scroll View**, you must add it to your transition object once view is loaded. This is needed by `CiaoTransition` to manage interactive transitions.

### 2. Instace CiaoTransition with your values

Before presenting your view controller, you need to create an instance of `CiaoTransition`. Use depending on Push or Modal transitions:

```swift
// Push transitions
let ciaoTransition = CiaoTransition(pushTransitionType: CiaoTransitionType.Push.pushLateral)

// Modal transitions
let ciaoTransition = CiaoTransition(modalTransitionType: CiaoTransitionType.Modal.appStore, toViewTag: 100)
```
>**Modal transitions**: Tagging your expanded view in presented view controller is required to help `CiaoTransition` getting the view to make interactive transitions.

#### Example with Storyboard

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let detailViewController = segue.destination as? DetailViewController else { return }
    let ciaoTransition = CiaoTransition(pushTransitionType: CiaoTransitionType.Push.pushLateral)
    detailViewController.ciaoTransition = ciaoTransition
    navigationController?.delegate = ciaoTransition
}
```

#### Example with Xibs
```swift
func presentDetailView() {
	let ciaoTransition = CiaoTransition(pushTransitionType: CiaoTransitionType.Push.pushLateral)
	let detailViewController = DetailViewController()
	detailViewController.ciaoTransition = ciaoTransition
	navigationController?.delegate = ciaoTransition
	navigationController?.pushViewController(detailViewController, animated: true)
}
```
## Configuration

### Default Transition Params
Customize your transition creating an instance of `CiaoTransition.Params`

```swift
/// Present animation duration
var presentDuration: TimeInterval = 0.8
    
/// Enable or disable fade effect on presented view controller
var presentFadeEnabled: Bool = false
    
/// Enable or disable fade effect on back view on present & dismiss animation
var backfadeEnabled: Bool = false
    
/// Enable or disable scale effect on back view on present & dismiss animation
var backScaleEnabled: Bool = false
    
/// Enable or disable lateral translation on back view on present & dismiss animation
var backLateralTranslationEnabled: Bool = false
    
/// Enable or disable lateral swipe to dismiss view
var dragLateralEnabled: Bool = false
    
/// Enable or disable vertical swipe to dismiss view
var dragDownEnabled: Bool = true
```

And how can I add it? Simple:

```swift
let params = CiaoTransition.Params()
let ciaoTransition = CiaoTransition(pushTransitionType: CiaoTransitionType.Push.pushLateral, params: params)
```

### Scale Transition Params
Scale transition params is required to make scale push transitions. For this, Ciao need some information about view you are going to scale. First create an instance of `CiaoTransition.ScaleParams` and add your custom params.

```swift
/// Source image view is going to be scaled from your initial view controller
var sourceImageView: UIImageView
/// Source image view frame converted to superview in view controller.
var sourceFrame: CGRect
/// This is the tag asigned to your image view in presented view controller
var destImageViewTag: Int
/// Destination image view frame in presented view controller
var destFrame: CGRect
```
>To setup `sourceFrame` it's important convert rect in source image view frame to superview in view controller. See next example:

```swift
// Convert image view frame to view under collection view
let rectInView = cell.convert(cell.imageView.frame, to: collectionView.superview)
params.sourceFrame = rectInView
```
>Tagging your image view in presented view controller is required to help `CiaoTransition` getting the view to make interactive transitions. Remember using the same tag in your image view & `destImageViewTag`

![Sample1](https://raw.githubusercontent.com/alberdev/CiaoTransitions/master/Images/sample1.png)

```swift
params.destImageViewTag = 100
```


## Transition Types

### Push Transitions

```swift
/// Vertical transition. Drag down or lateral to dismiss the view (by default).
CiaoTransitionType.Push.vertical

/// Lateral translation transition. Drag down or lateral to dismiss the view (by default).
CiaoTransitionType.Push.lateral

/// Fade transition with scaled image. Drag down or lateral to dismiss the view (by default).
CiaoTransitionType.Push.scaleImage
```


### Modal Transitions

```swift
/// Special simulated App Store transition. Drag down or lateral to dismiss the view (by default).
CiaoTransitionType.Modal.appStore
```

## Author

Alberto Aznar, info@alberdev.com

## Credits

I used open source project [iOS 11 App Store Transition](https://github.com/aunnnn/AppStoreiOS11InteractiveTransition) made by [Wirawit Rueopas](https://github.com/aunnnn) to simulate one of transitions.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

Ciao is available under the MIT license. See the LICENSE file for more info.
