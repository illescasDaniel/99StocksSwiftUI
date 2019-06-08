//
//  CompaniesDetailView.swift
//  99_Companies
//
//  Created by Daniel Illescas Romero on 07/06/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import SwiftUI


struct CompanyDetailView: View {
	
	let companyId: CompanyEntry.ID
	
	@EnvironmentObject
	var companyDetails: CompanyDetailsViewModel
	
	//
	
    var body: some View {
		ScrollView {
			VStack(alignment: .center, spacing: 40) {
				if companyDetails.image != nil {
					companyDetails.image!
						.resizable()
						//.interpolation(.high)
						.aspectRatio(contentMode: .fit)
						.frame(width: 120, height: 120)
						.clipShape(Circle())
						.shadow(radius: 2.5)
						.padding(.top, 20)
				}
				VStack(alignment: .center, spacing: 8) {
					Text(self.companyDetails.stockNameAndPossiblyItsFlag())
						.font(.system(.title, design: .monospaced))
						.fontWeight(.bold)
					HStack {
						Image(systemName: companyDetails.stockState.directionImageName)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 10, height: 10)
							.foregroundColor(companyDetails.stockState.color)
						Text(companyDetails.company.sharePrice.currencyFormatted)
							.font(.system(.title, design: .monospaced))
							.fontWeight(.bold)
							.color(companyDetails.stockState.color)
					}
					Text(companyDetails.company.description)
						.font(.body)
						.padding(.vertical, 16)
						.lineLimit(5)
						.allowsTightening(true)
					Spacer(minLength: 20)
					ChartView(data: companyDetails.sharePrices)
						.frame(minHeight: 215)
						.padding(.all, 30)
				}
				Spacer()
			}
			.frame(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height), alignment: .center)
		}
		.navigationBarTitle(
			Text(companyDetails.company.name)
		)
		.navigationBarItems(trailing:
			Button(action: {
				self.companyDetails.reload()
			}, label: {
				HStack {
					Text(L10n.Sections.Companies.Button.reload)
					Image(systemName: "arrow.counterclockwise.circle.fill")
				}
			})
		)
	}
}

#if DEBUG
struct CompanyDetailView_Previews : PreviewProvider {
    static var previews: some View {
        CompanyDetailRouter.mockInstance
    }
}
#endif
