//
//  CompaniesViewRouter.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

extension Company.Router {
	enum ItemList {
		static var instance: some View {
			Company.View.ItemList().environmentObject(
				Company.ViewModel.ItemList(initialData: [], scheduleToReloadEvery: 3)
			)
		}
		#if DEBUG
		static var mockInstance: some View {
			Company.View.ItemList().environmentObject(
				Company.ViewModel.ItemList(initialData: Company.ViewModel.ItemList.mockData,
										   scheduleToReloadEvery: 3)
			)
		}
		#endif
	}
}
