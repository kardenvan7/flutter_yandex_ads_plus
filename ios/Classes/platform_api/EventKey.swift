import Foundation

struct EventKey: Hashable {
    var id: String = ""
    var name: String = ""
    var type: String = ""

    static func ==(lhs: EventKey, rhs: EventKey) -> Bool {
        return (lhs.id == rhs.id && lhs.name == rhs.name && lhs.type == rhs.type)
    }
}
