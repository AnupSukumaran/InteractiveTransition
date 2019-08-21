

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Ext1 = \(self.myComputedProperty)")
        self.myComputedProperty = true
        print("Ext2 = \(self.myComputedProperty)")
    }
    
  
    @IBAction func vcCall(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
      
    }
    

}

extension FirstViewController: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return FlipPresentAnimationController(direct: .left)
  }
  
  func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
      
      guard let vc = dismissed as? SecondViewController else { return nil }
      return FlipDismissAnimationController(direct:  .left, interactionController: vc.swipeInteractionController)
      
  }
  
  func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

    guard let animator = animator as? FlipDismissAnimationController, let interactionController = animator.interactionController, interactionController.interactionInProgress else {return nil}
    return interactionController
  }
  
}
