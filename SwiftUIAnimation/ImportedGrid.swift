//
//  SwiftUIView.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 07/06/2022.
//

import SwiftUI

struct ImportedGrid: View {
    
    let views = SomeView.getViews()
    let grid = [
        GridItem(.adaptive(minimum: 200, maximum: 200), spacing: 10)
    ]
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            ScrollView {
                LazyVGrid(columns: grid) {
                    ForEach(views, id: \.title) { item in
                        HStack {
                            Text(item.title)
                                .font(.system(size: 24))
                            item.view
                                .frame(width: width / 4, height: width / 2)
                        }
                    }
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ImportedGrid()
    }
}
