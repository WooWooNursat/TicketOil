import UIKit

extension UIViewController {
    func showAlert(with title: String?, and message: String?, completion: (() -> Void)? = nil) {
        if message == nil { return }
        let alertVC = UIAlertController(title: title, message: message,
                                        preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Закрыть", style: .default) { _ in
            completion?()
        })
        
        alertVC.modalPresentationStyle = .formSheet
        present(alertVC, animated: true)
    }
    
    func setRootViewController() {
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return }
        
        window.rootViewController = self
    }
}
