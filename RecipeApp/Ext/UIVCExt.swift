import UIKit

extension UIViewController {
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKB))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKB() {
        view.endEditing(true)
    }
}
