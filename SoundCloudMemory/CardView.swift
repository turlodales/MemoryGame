
import UIKit

class CardView: UIView {
    
    public var isFlipped: Bool = false

    private var image: UIImage!

    private let flipInterval: TimeInterval = 0.3 // time interval for flip anim.

    private lazy var frontImageView: UIImageView = {
        let imageView = UIImageView(image: self.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "card-background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        return imageView
    }()
    
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        
        self.image = image
        
        addSubview(frontImageView)
        frontImageView.pinSuperview()
        frontImageView.isHidden = true
        
        addSubview(backImageView)
        backImageView.pinSuperview()
        backImageView.isHidden = false
        
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func flip() {
        if isFlipped {
            showBackImage()
        } else {
            showFrontImage()
        }
    }
    
    private func showBackImage() {
        if !isFlipped {
            return
        }
        
        isFlipped = false
        
        UIView.transition(from: frontImageView, to: backImageView, duration: flipInterval,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews],
                          completion: nil)
    }
    
    private func showFrontImage() {
        if isFlipped {
            return
        }
        
        isFlipped = true
        
        UIView.transition(from: backImageView, to: frontImageView, duration: flipInterval,
                          options: [.transitionFlipFromRight, .showHideTransitionViews],
                          completion: nil)
    }
    
    
}
