//
//  CustomGrid.swift
//  SwiftUIAnimation
//
//  Created by Сергей Веретенников on 06/06/2022.
//

//
//
//Пробую понять как сделать свою сетку вручную как в уроке
//
//

import SwiftUI

struct CustomGrid<Content, T>: View where Content: View {
    
    let columns: Int
    let items: [T]
    let content: (CGFloat, T) -> Content
    
    var rows: Int {
        items.count / columns
    }
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size.width / CGFloat(columns)
            ForEach(0...rows, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<columns) { columnIndex in
                        if let index = checkIndexWith(row: rowIndex, column: columnIndex) {
                            content(size, items[index])
                        } else {
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    
    private func checkIndexWith(row: Int, column: Int) -> Int? {
        let index = row * columns + column
        return index < items.count ? index : nil
    }
}



struct CustomGrigTest: View {
    
    let views = SomeView.getViews()
    var height: Double?
    
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                let width = geo.size.width * 0.95
                let height = geo.size.height * 0.95
                CustomGrid(columns: 3, items: views) { size, item in
                    VStack {
                        item.view
                        Text("\(item.title)")
                    }
                    .frame(width: size, height: size * 2.2)
                }
                .frame(width: width, height: height)
            }
        }
    }
}

struct CustomGrid_Previews: PreviewProvider {
    static var previews: some View {
        CustomGrigTest()
    }
}
