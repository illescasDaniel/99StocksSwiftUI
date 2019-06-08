//
//  ChartView.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

final class ChartView: UIViewRepresentable, ChartDelegate {
	
	typealias UIViewType = Chart
	
	let data: [(x: Int, y: Double)]
	
	init(data: [(x: Int, y: Double)]) {
		self.data = data
	}

	func makeUIView(context: UIViewRepresentableContext<ChartView>) -> Chart {
		let chart = Chart()
		chart.delegate = self
		chart.hideHighlightLineOnTouchEnd = true
		
		let series = ChartSeries(data: self.data)
		series.area = true
		chart.add(series)
		
		return chart
	}
	
	func updateUIView(_ uiView: Chart, context: UIViewRepresentableContext<ChartView>) {
		
		uiView.layoutIfNeeded()
		
		uiView.removeAllSeries()
		
		let series = ChartSeries(data: self.data)
		series.area = true
		uiView.add(series)
		
		if self.data.count > 10 {
			uiView.xLabelsFormatter = { (_,_) in "" }
		} else {
			uiView.xLabelsFormatter = { (_,value) in "\(value)" }
		}
		
		switch context.environment.colorScheme {
		case .light:
			uiView.labelColor = .black
		case .dark:
			uiView.labelColor = .white
		@unknown default:
			break
		}
	}
	
	// ChartDelegate
	
	func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
		
	}
	
	func didFinishTouchingChart(_ chart: Chart) {
		
	}
	
	func didEndTouchingChart(_ chart: Chart) {
		
	}
}
