# SwiftUI VerticalTabView

SwiftUI TabView wrapper with vertical scrolling behavior.

## Example

```swift
@main
struct test_vertical_tabviewApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}

struct ContentView: View {
	
	@State private var idx: Int = 1
	
	var body: some View {
		VerticalTabView(selection: $idx) {
			ForEach(1..<3) { idx in
				color(for: idx)
					.tag(idx)
			}
		}
//		.edgesIgnoringSafeArea(.all)
	}
	
	
	@ViewBuilder
	func color(for idx: Int) -> some View {
		VStack(spacing: 0) {
			switch idx {
				case 1:
					Color.mint
						.border(.red, width: 2)
						.overlay {
							Text("Hello")
						}
				case 2:
					Color.yellow
						.border(.purple, width: 2)
						.overlay {
							Text("World")
						}
				default:
					Color.gray
			}
		}
		
	}
}
```
