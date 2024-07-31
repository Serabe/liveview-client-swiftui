//
//  StrikethroughModifier.swift
//
//
//  Created by Carson Katri on 2/21/24.
//

import SwiftUI
import LiveViewNativeStylesheet

/// See [`SwiftUI.View/strikethrough(_:pattern:color:)`](https://developer.apple.com/documentation/swiftui/view/strikethrough(_:pattern:color:)) for more details on this ViewModifier.
///
/// ### strikethrough(_:pattern:color:)
/// - `isActive`: `attr("...")` or ``Swift/Bool``
/// - `pattern`: ``SwiftUI/Text/LineStyle/Pattern``
/// - `color`: `attr("...")` or ``SwiftUI/Color`` or `nil`
///
/// See [`SwiftUI.View/strikethrough(_:pattern:color:)`](https://developer.apple.com/documentation/swiftui/view/strikethrough(_:pattern:color:)) for more details on this ViewModifier.
///
/// Example:
///
/// ```heex
/// <Element style='strikethrough(attr("isActive"), pattern: .solid, color: attr("color"))' isActive={@isActive} color={@color} />
/// ```
@_documentation(visibility: public)
@ParseableExpression
struct _StrikethroughModifier<Root: RootRegistry>: TextModifier {
    static var name: String { "strikethrough" }

    let isActive: AttributeReference<Bool>
    let pattern: SwiftUI.Text.LineStyle.Pattern
    let color: Color.Resolvable?

    @ObservedElement private var element
    @LiveContext<Root> private var context
    
    init(
        _ isActive: AttributeReference<Bool> = .init(storage: .constant(true)),
        pattern: SwiftUI.Text.LineStyle.Pattern = .solid,
        color: Color.Resolvable? = nil
    ) {
        self.isActive = isActive
        self.pattern = pattern
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .strikethrough(
                isActive.resolve(on: element, in: context),
                pattern: pattern,
                color: color?.resolve(on: element, in: context)
            )
    }
    
    func apply<R: RootRegistry>(to text: SwiftUI.Text, on element: ElementNode, in context: LiveContext<R>) -> SwiftUI.Text {
        text
            .strikethrough(
                isActive.resolve(on: element, in: context),
                pattern: pattern,
                color: color?.resolve(on: element, in: context)
            )
    }
}
