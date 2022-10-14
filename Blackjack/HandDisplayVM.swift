import Foundation

class HandDisplayViewModel {
    // Retreive a list of image locations from the deck
    public func getImageLocations(hand: [Card]) -> [String] {
        var stringLocations: [String] = []
        for card in hand {
            stringLocations.append(card.location)
        }
        return stringLocations
    }

    // Adjust cards to center whenver the hand increases
    func cardAlignment(numOfCards: Int, index: Int) -> CGFloat {
        var offsetX: CGFloat

        if numOfCards == 2 {
            offsetX = -30.0 + (CGFloat(index) * 50.0)
        } else if numOfCards == 3 {
            offsetX = -50.0 + (CGFloat(index) * 50.0)
        } else if numOfCards == 4 {
            offsetX = -70.0 + (CGFloat(index) * 50.0)
        } else if numOfCards == 5 {
            offsetX = -80.0 + (CGFloat(index) * 40.0)
        } else if numOfCards == 6 {
            offsetX = -80.0 + (CGFloat(index) * 30.0)
        } else {
            offsetX = -80.0 + (CGFloat(index) * 20.0)
        }

        return offsetX
    }
}
