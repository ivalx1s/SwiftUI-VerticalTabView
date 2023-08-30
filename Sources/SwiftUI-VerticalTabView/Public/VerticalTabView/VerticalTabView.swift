import Foundation
import SwiftUI
import Combine

@available(iOS 15, *)
public struct VerticalTabView<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
	
	private let selection: Binding<SelectionValue>?
	private let content: Content
	
	public init(selection: Binding<SelectionValue>?, @ViewBuilder content: () -> Content) {
		self.selection = selection
		self.content = content()
	}
	
	@StateObject var ls: LocalState = .init()
	
	public var body: some View {
		Color.clear
			.overlay {
				VStack(spacing: 0) {
					Spacer(minLength: 0)
						.layoutPriority(10)
						.storingSize(in: ls.surroundingRectSubject, onQueue: ls.queue, space: .global, logToConsole: true)
					TabView(selection: selection) {
						content
							.layoutPriority(10)
							.rotationEffect(.degrees(-90))
							.padding(.horizontal, ls.props.proposedRectHeight)
							.padding(.vertical, -ls.props.proposedRectHeight)
							.ignoresSafeArea(.all, edges: safeAreaEdgesToIgnore)
					}
					.tabViewStyle(.page(indexDisplayMode: .never))
					.frame(height: ls.props.viewWidth)
					.padding(.leading, -ls.props.proposedRectHeight)
					.padding(.trailing, -ls.props.proposedRectHeight)
					.rotationEffect(.degrees(90))
					.storingSize(in: ls.rectSubject, onQueue: ls.queue, space: .global)
					.layoutPriority(100)
					Spacer(minLength: 0)
						.layoutPriority(10)
				}
			}
	}
	
	private var safeAreaEdgesToIgnore: Edge.Set {
		[.horizontal, .top, .bottom]
	}
}
