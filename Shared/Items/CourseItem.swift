//
//  CourseItem.swift
//  DesignCodCourse
//
//  Created by 조상호 on 2021/08/25.
//

import SwiftUI

struct CourseItem: View {
  var course: Course = courses[0]
  #if os(iOS)
  var cornerRadius: CGFloat = 22
  #else
  var cornerRadius: CGFloat = 10
  #endif

  var body: some View {
    VStack(alignment: .leading) {
      Spacer()
      HStack {
        Spacer()
        Image(course.image)
          .resizable()
          .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
        Spacer()
      }
      Text(course.title).fontWeight(.bold).foregroundColor(Color.white)
      Text(course.subtitle).font(.footnote).foregroundColor(Color.white)
    }
    .padding(.all)
    .background(course.color)
    // clipShape -> CornerRadius보다 부드러운 모서리를 적용할 때 사용
    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    .shadow(color: course.color.opacity(0.3), radius: 20, x: 0, y: 10)
  }
}

struct CourseItem_Previews: PreviewProvider {
    static var previews: some View {
        CourseItem()
    }
}

