//
//  ValueInputTests.swift
//
//
//  Created by Carson Katri on 1/26/23.
//

import XCTest
import SwiftUI
@testable import LiveViewNative

@MainActor
final class ValueInputTests: XCTestCase {
    func testSliderSimple() throws {
        try assertMatch(#"<slider />"#, size: .init(width: 100, height: 100)) {
            Slider(value: .constant(0))
        }
    }
    
    func testSliderLabels() throws {
        try assertMatch(#"""
<slider>
    <slider:label>
        <text>Label</text>
    </slider:label>
    <slider:minimum-value-label>
        <text>Min</text>
    </slider:minimum-value-label>
    <slider:maximum-value-label>
        <text>Max</text>
    </slider:maximum-value-label>
</slider>
"""#, size: .init(width: 300, height: 100)) {
            Slider(value: .constant(0)) {
                Text("Label")
            } minimumValueLabel: {
                Text("Min")
            } maximumValueLabel: {
                Text("Max")
            }
        }
    }
    
    func testToggleSimple() throws {
        try assertMatch(#"<toggle>Switch</toggle>"#, lifetime: .keepAlways) {
            Toggle("Switch", isOn: .constant(false))
        }
    }
}
