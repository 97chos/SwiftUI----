//
//  CourseRow.swift
//  DesignCodCourse
//
//  Created by 조상호 on 2021/08/24.
//

import SwiftUI

struct CourseRow: View {
  var item: CourseSection = courseSections[0]

    var body: some View {
      HStack(alignment: .top) {
        Image(item.logo)
          .renderingMode(.original)
          .frame(width: 48.0, height: 48.0)
          .imageScale(.medium)
          .background(item.color)
          .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        VStack(alignment: .leading, spacing: 4.0) {
          Text(item.title)
            .font(.subheadline)
          Text(item.subtitle)
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        Spacer()
      }
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow()
    }
}
