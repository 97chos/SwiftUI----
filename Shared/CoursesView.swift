//
//  CoursesView.swift
//  DesignCodCourse
//
//  Created by 조상호 on 2021/08/24.
//

import SwiftUI

struct CoursesView: View {
  @State var show = false

  var body: some View {
    ZStack {
      CourseItem()
        .frame(width: 335, height: 250)
      // zIndex를 사용하여 뷰의 순서르 변경하는 것보다 VStack을 사용하는 것이 더 자연스러움
      VStack {
        if show {
          CourseItem()
            .transition(.move(edge: .leading))
            // safeArea 무시
            .edgesIgnoringSafeArea(.all)
        }
      }
    }
    // 프리뷰에서는 노출 애니메이션이 제대로 동작하지 않으나, 앱에서는 정상적으로 동작됨
    .onTapGesture {
      // 두 애니메이션 방법 모두 사용 가능하나, 기하학적인 애니메이션은 이 방법이 더 적합하다고 판단,
      // 애니메이션 도중 여러번 터치해도 부드럽게 동작됨.
      withAnimation(.spring()) {
        show.toggle()
      }
    }
//    .animation(.spring())
  }
}

struct CoursesView_Previews: PreviewProvider {
  static var previews: some View {
    CoursesView()
  }
}
