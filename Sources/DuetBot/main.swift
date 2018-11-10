import Sword

let bot = Sword(token: "token")
var insultUsernames = [String]()

bot.editStatus(to: "online", playing: "with Sword!")

bot.on(.messageCreate) { data in
    guard let message = data as? Message else { return }
    if let acquiredTarget = message.author?.username, insultUsernames.contains(acquiredTarget) {
        return message.reply(with: "Hey, screw you \(acquiredTarget)!")
    }
    
    switch message.content {
    case "!ping": message.reply(with: "Pong!")
    case let toInsult where toInsult.hasPrefix("!insult "):
        let username = String(toInsult.dropFirst(8))
        insultUsernames.append(username)
        message.reply(with: "Okay, whenever \(username) tries to message me they'll regret it!")
    default: break
    }

}

bot.connect()
