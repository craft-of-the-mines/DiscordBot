import Foundation
import Sword

guard let config = FileManager.default
    .contents(atPath: FileManager.default.currentDirectoryPath.appending("/config.json"))
    .flatMap({ try? JSONDecoder().decode(Config.self, from: $0) }) else {
        print("""
        You're missing a valid config.json file in the current directory.
        It should contain JSON which can be decoded into a Config instance.
        """)
        #if DEBUG
        print("""
        When running in debug: the target contains a copy build phase which
        copies a config.json file at $(SRCROOT)/Sources/DuetBot. Make sure
        that the Products directory for this target (somewhere in your
        DerivedData) contains this file.
        """)
        #endif
        exit(1)
}

Bot(token: config.token, routines:
    PingRoutine(),
    PongRoutine(),
    InsultRoutine(ignoring: [])
)
    .start()
