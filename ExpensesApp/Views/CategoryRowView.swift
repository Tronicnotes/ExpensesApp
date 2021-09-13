//
//  CategoryRowView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 13/09/21.
//

import SwiftUI

struct CategoryRowView: View {
    private let category: Category
    private let textColor: Color
    private let categoryAvatarSize: CGFloat = 32

    init(category: Category, textColor: Color = .primary) {
        self.category = category
        self.textColor = textColor
    }

    var body: some View {
        Label(
            title: { Text(category.label).foregroundColor(.secondary) },
            icon: {
                ZStack(alignment: .center) {
                    Circle()
                        .foregroundColor(category.color)
                    Image(assetIdentifier: category.imageAsset)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding(4)
                }
                .frame(width: categoryAvatarSize, height: categoryAvatarSize)
            })
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(category: .shopping)
    }
}
