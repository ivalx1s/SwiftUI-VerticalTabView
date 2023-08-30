import Combine
import Foundation
import SwiftUI

@available(iOS 15, *)
extension VerticalTabView {
	final class LocalState: ObservableObject {
		var pipelines: Set<AnyCancellable> = []
		let queue = DispatchQueue(label: "viewFrameReaderQueue", qos: .userInitiated)
		
		
		let rectSubject = PassthroughSubject<CGRect, Never>()
		var rectPublisher: AnyPublisher<CGRect, Never> {
			rectSubject
				.removeDuplicates()
				.eraseToAnyPublisher()
		}
		
		let surroundingRectSubject = PassthroughSubject<CGRect, Never>()
		var surroundingRectPublisher: AnyPublisher<CGRect, Never> {
			surroundingRectSubject
				.removeDuplicates()
				.eraseToAnyPublisher()
		}
		
		@Published private(set) var props: Props = .default
		
		init() {
			bindFields()
		}
		
		private func bindFields() {
			Publishers.CombineLatest(rectPublisher, surroundingRectPublisher)
				.subscribe(on: queue)
				.receive(on: queue)
				.map { ($0.size, $1.size)  }
				.map { rectSize, proposedSize in
					return Props(
						viewWidth: rectSize.width,
						viewHeight: rectSize.height,
						proposedRectWidth: proposedSize.width,
						proposedRectHeight: proposedSize.height
					)
				}
				.removeDuplicates()
				.receive(on: DispatchQueue.main)
				.sink { [weak self] (props: Props) in
					self?.props = props
				}
				.store(in: &pipelines)
		}
	}
	
	struct Props: Hashable, Equatable, DynamicProperty {
		let viewWidth: CGFloat
		let viewHeight: CGFloat
		let proposedRectWidth: CGFloat
		let proposedRectHeight: CGFloat
		
		
		static var `default`: Self { .init(
			viewWidth: 0,
			viewHeight: 0,
			proposedRectWidth: 0,
			proposedRectHeight: 0
		)
		}
	}
}
