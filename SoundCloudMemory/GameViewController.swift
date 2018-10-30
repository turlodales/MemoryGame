
import UIKit

class GameViewController: UIViewController {
    
    internal var game: Game!
    
    internal var listOfCardsViews : [CardView] = [CardView]()
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCards()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backButtonDidTouch(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cardViewDidTap(sender: UITapGestureRecognizer) {
        if let cardView = sender.view as? CardView,
            let index = listOfCardsViews.firstIndex(of: cardView){
            Logger.debug("cardViewDidTap : \(index)")
            game.didSelectCardAt(index: index) // notify the game instance, card is selected
        }
    }
}

// MARK: - Game UI Layout
extension GameViewController {
    
    private func loadCards() {
        Logger.debug("will build card layouts")
        
        for rowIndex in 0..<Game.GameLayout.rows { // we have 4 rows
            let row = createRow()
            stackView.addArrangedSubview(row) // create row and add to stackView
            
            for columnIndex in  0..<Game.GameLayout.columns { // for each column (we have 4 columns)
                let index = (rowIndex * Game.GameLayout.columns) + columnIndex // convert matrix row-column index to linear index
                if let card = game.cardAt(index: index){
                    // create card view
                    let cardView = CardView(image: card.image)
                    cardView.layer.cornerRadius = 5 // rounded corners
                    cardView.layer.masksToBounds = true
                    cardView.isUserInteractionEnabled = true // set interaction enabled
                    
                    // add tap gesture
                    let recogniser: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cardViewDidTap(sender:)))
                    cardView.addGestureRecognizer(recogniser) // add gesture to view
    
                    row.addArrangedSubview(cardView) // add card to row
                    listOfCardsViews.append(cardView) 
                }
            }
        }
    }
    
    private func createRow() -> UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = self.stackView.spacing
        view.backgroundColor = UIColor.white
        return view
    }
}

// MARK: - GameDelegate
extension GameViewController: GameDelegate {
    
    func show(card: Card, atIndex index: Int) {
        Logger.debug("showCard")
        let view = self.listOfCardsViews[index]
        view.flip()
    }
    
    func hide(cards: [Card], atIndices indices: [Int]) {
        Logger.debug("hideCards")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            indices.forEach { (index) in
                let view = self.listOfCardsViews[index]
                view.flip()
            }
        }
    }
    
    func gameDidFinish() {
        Logger.debug("game finished!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // wait till last card is flipped
            self.performSegue(withIdentifier: "gameFinished", sender: self)
        }
    }
}

