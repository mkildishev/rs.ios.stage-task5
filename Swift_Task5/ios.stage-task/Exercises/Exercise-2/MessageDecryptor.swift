import UIKit


extension Character {
    var isOpenBracket: Bool {
        self == "["
    }
    var isCloseBracket: Bool {
        self == "]"
    }
}

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
//        guard let startIdx = message.firstIndex(where: {$0.isNumber})  else {
//            return message;
//        }
//        let newMessage = String(Array(message)[(startIdx+1)...])
        return buildAndRepeat(message, 1)
    }
    
    func buildAndRepeat(_ message: String, _ count: Int) -> String {
        var needIgnoreCloseBrackets = false
        var numberAgain = false
        var result = ""
        var finalResult = ""
        var prevElem:Character = "z"
        for (num, ch) in message.enumerated() {
            if ch.isLetter {
                result.append(ch)
            }
            if ch.isCloseBracket && !needIgnoreCloseBrackets {
                result = String(repeating: result, count: count)
                needIgnoreCloseBrackets = true
            }
            if ch.isNumber {
                let newMessage = String(Array(message)[(num+1)...])
                numberAgain = prevElem.isOpenBracket
                finalResult = buildAndRepeat(String(newMessage), numberAgain ? (count * Int(String(ch))!) : Int(String(ch))!)
                if needIgnoreCloseBrackets {
                    finalResult = result + finalResult
                } else if let _ = message.lastIndex(where: {$0.isCloseBracket}) {
                    if (message.last?.isCloseBracket ?? false) {
                        finalResult = String(repeating: result + finalResult, count: count)
                    } else {
                        finalResult = String(repeating: result, count: count) + finalResult
                    }
                }
                break
            }
            prevElem = ch
        }
        return finalResult == "" ? result : finalResult
    }
}


