//
//  CompaniesViewRouter.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 08/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import Foundation
import SwiftUI

enum CompaniesViewRouter {
	static var instance: some View {
		CompaniesView().environmentObject(
			Companies(initialData: [], scheduleToReloadEvery: 3)
		)
	}
	static var mockInstance: some View {
		CompaniesView().environmentObject(
			Companies(initialData: [], scheduleToReloadEvery: 3)
		)
	}
}
