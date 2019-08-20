

import UIKit

enum Direction {
  case up
  case down
  case left
  case right
}

class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  let bounds = UIScreen.main.bounds
  var xdirection = CGFloat()
  var ydirection = CGFloat()
  
  init(direct: Direction) {
    
    switch direct {
    case .up:
      xdirection = 0.0
      ydirection = -bounds.size.height
    case .down:
      xdirection = 0.0
      ydirection = bounds.size.height
    case .left:
      xdirection = -bounds.size.width
      ydirection = 0.0
    case .right:
      xdirection = bounds.size.width
      ydirection = 0.0
    }
  
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.6
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromVC = transitionContext.viewController(forKey: .from),
      let toVC = transitionContext.viewController(forKey: .to) else {return}

    let finalFrame = transitionContext.finalFrame(for: toVC)
    let containerView = transitionContext.containerView
    
    toVC.view.frame = finalFrame.offsetBy(dx: xdirection, dy: ydirection)

    containerView.addSubview(toVC.view)
    
    let duration = transitionDuration(using: transitionContext)
    
    UIView.animate(withDuration: duration, animations: {
      fromVC.view.alpha = 0.5
      
      toVC.view.frame = finalFrame
      
    }) { (finished) in
      transitionContext.completeTransition(true)
      fromVC.view.alpha = 1.0

    }
    
  }
  

}
