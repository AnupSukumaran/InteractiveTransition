

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
    gesture.edges = .right
    view.addGestureRecognizer(gesture)
  }
  
  var initialCenter = CGPoint()
  var initialX: CGFloat = 0.0
  var initalWitdh: CGFloat = 0.0
  
  @objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
    // 1
    guard let piece = gestureRecognizer.view else {return}
    
    let translation = gestureRecognizer.translation(in: piece.superview!)
    
    switch gestureRecognizer.state {
      
    // 2
    case .began:
       self.initialCenter = piece.center
       self.initalWitdh = piece.frame.width
       print("initialCenter.x = \(initialCenter.x)")
       let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
       self.initialX = newCenter.x
       print("initialX = \(self.initialX)")
//      print("initialCenter.x = \(self.initialCenter.x)")
      interactionInProgress = true
      viewController.dismiss(animated: true, completion: nil)
      //update(translation.x)
    // 3
    case .changed:
      let newCenter = CGPoint(x: initialCenter.y + translation.y, y: initialCenter.x + translation.x)
      //piece.center = newCenter
      print("Transalation.x = \( (translation.x ) )")
      
      print("width/2 = \(piece.frame.width/2)")
      print("value.x = \( (translation.x / (piece.frame.width/2) ) )")
     // print("Transalation.x = \( (translation.x / (piece.frame.width/2) ) )")
      print("newCenter.x = \(newCenter.x)")
      print("newCenter.y = \(newCenter.y)")
      
      print("newCenter.x = \(newCenter.x)")
      print("new.x = \(1 - (initialCenter.x/newCenter.x))")
      let newX = 1 - (initialCenter.x/newCenter.x)
      
//      print("new.g = \((self.initialX - 1)/self.initialX)")
//
//      print("new.J = \(initialCenter.x/newCenter.x)")
//
//      print("new.x = \(1 - (initialCenter.x/newCenter.x))")
//      let newX = 1 - (initialCenter.x/newCenter.x)
//
     // print("new.J = \((initialCenter.x / newCenter.x ))")
//      print("new.x = \((initialCenter.x / newCenter.x ) - 1 )")
//      let newX =  (initialCenter.x / newCenter.x) - 1
      
//      print("new.x = \(1 - ( newCenter.x / initialX))")
//      let newX = 1 - ( newCenter.x / initialX)
      
//      print("new.x = \(1 - ( newCenter.x / piece.frame.width))")
//      let newX = 1 - ( newCenter.x / piece.frame.width)
      
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
