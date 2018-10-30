
import UIKit

extension UIView {
    
    func pinSuperview() { // will pin view to it's superview (if present)
        if let superview = superview {
            superview.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            superview.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            superview.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            superview.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
}
