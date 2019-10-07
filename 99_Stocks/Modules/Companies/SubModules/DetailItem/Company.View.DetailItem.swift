//
//  CompaniesDetailView.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI

extension Company.View {
	
	struct DetailItem: View {
		
		@EnvironmentObject
		var companyDetailsVM: Company.ViewModel.DetailItem
		
		var body: some View {
			ScrollView {
				VStack(alignment: .center, spacing: 40) {
					self.companyDetailsVM.image?
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 120, height: 120)
						.clipShape(Circle())
						.shadow(radius: 2.5)
						.padding(.top, 20)
					VStack(alignment: .center, spacing: 8) {
						Text(self.companyDetailsVM.stockNameAndPossiblyItsFlag())
							.font(.system(.title, design: .monospaced))
							.fontWeight(.bold)
							.padding(.vertical, self.companyDetailsVM.image == nil ? 16 : 0)
						HStack {
							self.companyDetailsVM.stockState.directionImage?
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 10, height: 10)
								.foregroundColor(self.companyDetailsVM.stockState.color)
							Text(self.companyDetailsVM.company.sharePrice.currencyFormatted)
								.font(.system(.title, design: .monospaced))
								.fontWeight(.bold)
								.foregroundColor(self.companyDetailsVM.stockState.color)
						}
						Text(self.companyDetailsVM.company.description)
							.font(.body)
							.padding(.vertical, 16)
							.lineLimit(5)
							.allowsTightening(true)
						Spacer(minLength: 20)
						ChartView(data: self.companyDetailsVM.sharePrices)
							.frame(minHeight: 215)
							.padding(.all, 30)
					}
					Spacer()
				}
				.frame(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height), alignment: .center)
			}
			.navigationBarTitle(
				Text(self.companyDetailsVM.company.name)
			)
			.navigationBarItems(trailing:
				Button(action: {
					self.companyDetailsVM.reload()
				}, label: {
					HStack {
						Text(L10n.Sections.Companies.Button.reload)
						Images.System.reloadIcon
					}
				})
			)
		}
	}
}

#if DEBUG
struct CompanyDetailView_Previews : PreviewProvider {
    static var previews: some View {
        Company.Router.DetailItem.mockInstance
    }
}
#endif
