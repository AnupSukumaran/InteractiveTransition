
import UIKit

class SecondViewController: UIViewController {

  var swipeInteractionController: SwipeInteractionController?
  
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeInteractionController = SwipeInteractionController(viewController: self)
    }
    

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
