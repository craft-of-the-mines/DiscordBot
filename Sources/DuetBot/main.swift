import Foundation
import Sword

let missingConfig: () -> Never = {
    print("""
    You're missing a valid config.json file in the current directory.
    It should contain JSON which can be decoded into a Config instance.
    """)
    #if DEBUG
    print("""
    When running in debug from Xcode: the target contains a copy build
    phase which copies a config.json file. Make sure that the phase has a
    valid reference to a config.json file and that the Products directory
    for this target (somewhere in your DerivedData) contains this file.
    """)
    #endif
    exit(1)
}

guard let config = FileManager.default
    .contents(atPath: FileManager.default.currentDirectoryPath.appending("/config.json"))
    .flatMap({ try? JSONDecoder().decode(Config.self, from: $0) }) else { missingConfig() }

Bot(token: config.token, routines:
    PingRoutine(),
    PongRoutine(),
    InsultRoutine(ignoring: [])
)
    .start()
