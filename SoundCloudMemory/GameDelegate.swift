
import UIKit

protocol GameDelegate {
    func show(card: Card, atIndex index: Int)
    func hide(cards: [Card], atIndices indices: [Int])
    func gameDidFinish()
}
