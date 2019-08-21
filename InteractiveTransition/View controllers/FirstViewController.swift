

import UIKit

class Gvar {
  static var arabic = false
}

//var arabic = false

class FirstViewController: UIViewController {
    
   // var arabic = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Ext1 = \(self.myComputedProperty)")
        self.myComputedProperty = true
        print("Ext2 = \(self.myComputedProperty)")
    }
    
  
    @IBAction func vcCall(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        Gvar.arabic = false
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
      
    }
    
    @IBAction func vcArabicCall(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        Gvar.arabic = true
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
    }
    
    

}

extension FirstViewController: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    print("Atabic1 = \(Gvar.arabic)")
    
    return FlipPresentAnimationController(direct: Gvar.arabic ? .left : .right)
  }
  
  func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
      
      guard let vc = dismissed as? SecondViewController else { return nil }
      print("Atabic2 = \(Gvar.arabic)")
      
      return FlipDismissAnimationController(direct:  Gvar.arabic ? .left : .right, interactionController: vc.swipeInteractionController)
      
  }
  
  func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

    guard let animator = animator as? FlipDismissAnimationController, let interactionController = animator.interactionController, interactionController.interactionInProgress else {return nil}
    return interactionController
  }
  
}
