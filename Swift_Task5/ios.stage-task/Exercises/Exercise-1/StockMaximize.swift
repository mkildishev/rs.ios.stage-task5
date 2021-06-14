import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        guard let maxPrice = prices.max() else {
            return 0
        }
        let maxPriceIdx = prices.firstIndex(of: maxPrice)!
        let priceSlice = prices[0...maxPriceIdx]
        let profit = priceSlice.reduce(0) {
            $0 + (maxPrice - $1)
        }
        return profit + countProfit(prices: Array(prices.dropFirst(maxPriceIdx + 1)))
    }
}
