//
//  CompanyDetilRouter.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

extension Company.Router {
	enum DetailItem {
		static func instance(companyId: Company.Model.ItemList.ID) -> some View {
			Company.View.DetailItem().environmentObject(
				Company.ViewModel.DetailItem(companyId: companyId, scheduleToReloadEvery: 3)
			)
		}
		#if DEBUG
		static var mockInstance: some View {
			Company.View.DetailItem().environmentObject(
				Company.ViewModel.DetailItem(companyId: 1)
			)
		}
		#endif
	}
}
