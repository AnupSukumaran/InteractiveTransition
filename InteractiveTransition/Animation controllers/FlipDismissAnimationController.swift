

import UIKit

class FlipDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  let interactionController: SwipeInteractionController?
  let bounds = UIScreen.main.bounds
  var xdirection = CGFloat()
  var ydirection = CGFloat()
  
  init(direct: Direction, interactionController: SwipeInteractionController?) {
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
    self.interactionController = interactionController
   
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.6
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
   
    guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {return}
    
    let finalFrameForVC = transitionContext.finalFrame(for: toVC)

    let containerView = transitionContext.containerView

    
    toVC.view.frame = finalFrameForVC
    toVC.view.alpha = 0.5
    
    containerView.addSubview(toVC.view)
    containerView.sendSubview(toBack: toVC.view)
    
    let duration = transitionDuration(using: transitionContext)
    
    UIView.animate(withDuration: duration, animations: {
      
      fromVC.view.frame = fromVC.view.frame.offsetBy(dx: self.xdirection , dy: self.ydirection)
      toVC.view.alpha = 1.0
      
    }) { (finished) in
      
       if transitionContext.transitionWasCancelled {
          toVC.view.removeFromSuperview()
       }
      
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      
    
     
    }
    
  }
  
  

}
