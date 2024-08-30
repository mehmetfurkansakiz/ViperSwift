import Foundation
import UIKit

// push, pop eklenebilir...

protocol Viewable {
    func present(_ viewController: UIViewController)
    func dismiss()
}

extension Viewable where Self: UIViewController {
    func present(_ viewController: UIViewController) {
        self.present(viewController, animated: true)
    }
    
    func dismiss() {
        self.dismiss()
    }
}
