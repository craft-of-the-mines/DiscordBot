import Sword

func parseMessage(message: Message) {
  let messageString = message.content
  if !messageString.hasPrefix("!") {return}
  let command = messageString.lowercased().dropFirst().components(separatedBy: " ")[0]
  switch command {
    case "ping":
      message.reply(with: "Pong!")
    case "pong":
      message.reply(with: "Ping!")
    default:
      return
  }
}
