//
//  CompanyDetilRouter.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import SwiftUI

enum CompanyDetailRouter {
	static func instance(companyId: CompanyEntry.ID) -> some View {
		CompanyDetailView(companyId: companyId).environmentObject(
			CompanyDetailsViewModel(companyId: companyId, scheduleToReloadEvery: 3)
		)
	}
	static var mockInstance: some View {
		CompanyDetailView(companyId: 1).environmentObject(
			CompanyDetailsViewModel(companyId: 1)
		)
	}
}
