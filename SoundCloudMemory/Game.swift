
import UIKit

class Game: NSObject {
    
    private var cards: [Card] = [Card]()
    
    private var pairedCards: [Card] = [Card]()
    
    private var shownIndices: [Int] = [Int]()
    
    internal var delegate: GameDelegate?
    
    struct GameLayout {
        static let columns: Int = 4
        static let rows: Int = 4
    }
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    public func initialise() throws{
        let numOfCardsRequired = (GameLayout.rows * 2)
        if self.cards.count < numOfCardsRequired { // there must be sufficient images for the game.
            throw AppError.Game(.unsufficientImage)
        }
        
        var selectedCards: [Card] = self.cards
        selectedCards = Array(selectedCards[0..<numOfCardsRequired]) // slice array, we require only 4*2 = 8 images
        selectedCards.append(contentsOf: selectedCards) // duplicate entries (we have now 16(8*2) images)
        self.cards = selectedCards // assign to cards
        self.cards.shuffle() // shuffle again
    }
    
    public func cardAt(index: Int) -> Card? {
        if index < self.cards.count{
            return self.cards[index]
        }
        
        return nil
    }
    
    public func existInPaired(card: Card) -> Bool {
        return pairedCards.contains(card)
    }

    public func didSelectCardAt(index: Int) {
        let card = cards[index] // selected
        
        // if you image is shown already, needs to be ignored or already exist in paired cards, ignore
        if shownIndices.contains(index) || pairedCards.contains(card){
            return
        }
        
        delegate?.show(card: card, atIndex: index)
        
        if isUnpaired(), // if unpaired that means two cards are visible right now, then check whether same or not.
            let lastCardIndex = shownIndices.last { // get last shown index
            Logger.debug("check cards for a match")
            let lastCard = self.cards[lastCardIndex]
            
            if lastCard.id == card.id {
                // this is a match, append it to match array
                Logger.debug("matching cards found")
                pairedCards.append(contentsOf: [lastCard, card])
            }else{
                Logger.debug("cards don't match, will hide in a second")
                delegate?.hide(cards: [lastCard, card], atIndices: [lastCardIndex, index]) // hide cards
            }
            shownIndices.removeAll() // clear indices
        } else { // append card to shown list
            Logger.debug("will append new card")
            shownIndices.append(index)
        }
        
        checkIfFinished()
    }

    // MARK: - Private

    private func checkIfFinished() {
        if pairedCards.count == cards.count { // if number of paired cards equal to cards count, then game is finished
            delegate?.gameDidFinish()
        }
    }
    
    private func isUnpaired() -> Bool {
        return shownIndices.count % 2 != 0
    }
    
}
