

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
  var interactionInProgress = false
  
  private var shouldCompleteTransition = false
  private weak var viewController: UIViewController!
 // var arabicNew = false
  
  init(viewController: UIViewController) {
    super.init()
    self.viewController = viewController
    prepareGestureRecognizer(in: viewController.view)
  }
  
  private func prepareGestureRecognizer(in view: UIView) {
    let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
    print("Gvar.arabic = \(Gvar.arabic)")
    
    gesture.edges = Gvar.arabic ? .right : .left
    view.addGestureRecognizer(gesture)
  }
  
  var initialCenter = CGPoint()
  var initialX: CGFloat = 0.0
  var initalWitdh: CGFloat = 0.0
  
  var value: CGFloat = 0.0
  
  @objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
    // 1
    guard let piece = gestureRecognizer.view else {return}
    
    let translation = gestureRecognizer.translation(in: piece.superview!)

    switch gestureRecognizer.state {
      
    // 2
    case .began:
      
      switch Gvar.arabic {
        
      case true:
        self.initialCenter = piece.center
      
       // self.initialCenter = CGPoint(x: 0, y: 0)
      case false:
        self.initialCenter = piece.center
        
      }
      
      interactionInProgress = true
      viewController.dismiss(animated: true, completion: nil)
      
    // 3
    case .changed:
      
      
      print("Arabicdata = \(Gvar.arabic)")
      
      switch Gvar.arabic {
      case true:
        let newCenter = CGPoint(x: initialCenter.x - translation.x, y: initialCenter.y - translation.y)
    
        value = 1 - (initialCenter.x / newCenter.x)
     
      case false:
        let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
        print("newCenter.x = \(newCenter.x)")
        print("new.x1 = \(1 - (initialCenter.x / newCenter.x))")
        value = 1 - (initialCenter.x / newCenter.x)
        
      }
      
      
     
      
      shouldCompleteTransition = value > 0.5
      print("shouldCompleteTransition = \(shouldCompleteTransition)")
      update(value)
      
    // 4
    case .cancelled:
      interactionInProgress = false
      cancel()
      
    // 5
    case .ended:
      interactionInProgress = false
      if shouldCompleteTransition {
        finish()
      } else {
        cancel()
      }
    default:
      break
    }
  }
}
