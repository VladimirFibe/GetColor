import SwiftUI

struct ColorItem: Identifiable, Hashable {
    let id = UUID()
    var color: Color {
        .init(red: red, green: green, blue: blue)
    }
    var count = 1
    var red = 0.0
    var green = 0.0
    var blue = 0.0
    var opacity = 1.0

}

extension ColorItem {
    static let sample: [ColorItem] = [.init(green: 1)]
}
