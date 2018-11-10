import Sword

Bot(token: "token", routines:
    PingRoutine(),
    PongRoutine(),
    InsultRoutine(ignoring: ["Dizzz"])
)
    .start()
