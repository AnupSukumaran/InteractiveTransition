

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
  var interactionInProgress = false
  
  private var shouldCompleteTransition = false
  private weak var viewController: UIViewController!
  
  
  init(viewController: UIViewController) {
    super.init()
    self.viewController = viewController
    prepareGestureRecognizer(in: viewController.view)
  }
  
  private func prepareGestureRecognizer(in view: UIView) {
    let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
    gesture.edges = .left
    view.addGestureRecognizer(gesture)
  }
  
  var initialCenter = CGPoint()
  
  @objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
    // 1
    guard let piece = gestureRecognizer.view else {return}
    
    let translation = gestureRecognizer.translation(in: piece.superview!)
    
    switch gestureRecognizer.state {
      
    // 2
    case .began:
       self.initialCenter = piece.center
       print("initialCenter.x = \(initialCenter.x)")
//      print("initialCenter.x = \(self.initialCenter.x)")
      interactionInProgress = true
      viewController.dismiss(animated: true, completion: nil)
      //update(translation.x)
    // 3
    case .changed:
      let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
      //piece.center = newCenter
      print("newCenter.x = \(newCenter.x)")
      print("new.x = \(1 - (initialCenter.x/newCenter.x))")
      let newX = 1 - (initialCenter.x/newCenter.x)
      shouldCompleteTransition = newX > 0.5
      print("shouldCompleteTransition = \(shouldCompleteTransition)")
      update(newX)
      
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
