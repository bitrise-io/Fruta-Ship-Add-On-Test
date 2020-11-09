/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that represents nutritional facts
*/

import SwiftUI

public struct NutritionFactView: View {
    public var nutritionFact: NutritionFact

    public init(nutritionFact: NutritionFact) {
        self.nutritionFact = nutritionFact.converted(toVolume: .cups(1))
    }

    var kilocalories: Int {
        Int(nutritionFact.kilocalories)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
                Text("Nutrition Facts", bundle: .module)
                    .font(.title2)
                    .bold()
                Text("Serving Size 1 Cup", bundle: .module)
                    .font(.footnote)
                Text("\(kilocalories) Calories", bundle: .module)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
            }
            .padding(20)
            .accessibilityElement(children: .combine)
            
            Divider()
                .padding(.horizontal, 20)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(nutritionFact.nutritions) { nutrition in
                        NutritionRow(nutrition: nutrition)
                            .padding(.vertical, 4)
                            .padding(.leading, nutrition.indented ? 10 : 0)
                        Divider()
                    }
                }
                .padding(.horizontal, 20)
                .accessibilityElement(children: .combine)
            }
        }
        .accessibilityElement(children: .contain)
    }
}

struct NutritionFactView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["en", "de", "pt"], id: \.self) { lang in
                NutritionFactView(nutritionFact: .banana)
                    .previewLayout(.fixed(width: 300, height: 500))
                    .environment(\.locale, .init(identifier: lang))
            }
        }
    }
}
