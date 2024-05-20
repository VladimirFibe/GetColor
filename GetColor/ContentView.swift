import SwiftUI

struct ContentView: View {
    @Environment(\.self) var environment
    @State private var colors = ColorItem.sample
    var totalColor: Color {

        var result = ColorItem()
        colors.forEach {
            result.red += $0.red
            result.blue += $0.blue
            result.green += $0.green
        }
        result.red /= Double(colors.count)
        result.green /= Double(colors.count)
        result.blue /= Double(colors.count)
        return result.color
    }
    var body: some View {
        NavigationStack {
            VStack {
                totalColor
                    .frame(height: 100)
                LazyVGrid(columns: [.init(.adaptive(minimum: 150, maximum: 200))]) {
                    ForEach($colors) { $item in
                        NavigationLink {
                            ColorCell(item: $item)
                        } label: {
                            item.color
                                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        }
                    }

                    AddButtonView().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            colors.append(ColorItem(green: 1))
                        }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Get Color")
        }
    }
}

struct ColorCell: View {
    @Binding var item: ColorItem
    @Environment(\.self) var environment
    @State private var color = Color.red
    @State private var components: Color.Resolved?

    var body: some View {
        VStack {
            ColorPicker("Select your favorite color", selection: $color)

            if let components {
                Text("R: \(components.red)")
                Text("G: \(components.green)")
                Text("B: \(components.blue)")
                Text("A: \(components.opacity)")
                Text("HEX: \(components.description)")
            }

            Button("Save") {
                if let components {
                    item.blue = Double(components.blue)
                    item.red = Double(components.red)
                    item.green = Double(components.green)
                    item.opacity = Double(components.opacity)
                }
            }
        }
        .padding()
        .onChange(of: color, initial: true) { components = color.resolve(in: environment) }
        .onAppear {
            color = item.color
        }
    }
}

#Preview {
    ContentView()
}

struct AddButtonView: View {
    var body: some View {
        Image(systemName: "plus")
            .font(.largeTitle)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 10).stroke(Color.gray)
            }
    }
}
