# Ch17. Navigation Link and Modal

## Navigation Link

- Navigation Link를 사용하여 각 아이템의 터치 이벤트에 따른 Navigation 동작을 추가할 수 있습니다.
- destination 인자값에는 push 동작으로 띄울 View 화면의 클래스를 넣고, 클로저 구문으로 push 동작의 트리거 역할을 수행할 View를 넣을 수 있습니다.

```swift
// CourseView.swift

@Namespace var detailNamespace

  ForEach(courseSections) { item in
  // courseSections = [Course] 타입
    NavigationLink(
      destination: CourseDetail(nameSpace: detailNamespace)) { 
      CourseRow(item: item)
    }
  }
```

<img width="300" alt="스크린샷 2021-08-26 오후 12 31 18" src="https://user-images.githubusercontent.com/59811450/130896090-b1c936fe-1f91-43f8-b23a-e7f71733382e.png">


## Modal Presentation

- sheet를 사용하여 바인딩된 변수의 변화에 맞춰 modal의 present 동작을 수행할 수 있습니다.
- isPresented에 Boolean 타입의 변수를 바인딩하여, 해당 변수가 true로 변경될 때마다 sheet의 클로저 구문에 있는 뷰를 present 합니다. 

```swift
// CourseDetail.swift

// 바인딩할 state 변수
@State var showModal = false

ForEach(courseSections) { item in
  CourseRow(item: item)
  // isP
    .sheet(isPresented: $showModal) {
      CourseSectionDetail()
    }
    .onTapGesture {
      showModal = true
    }
  Divider()
}
```

- presented View가 dismiss 처리되는 과정에서 바인딩된 변수는 자동으로 false로 변경되는 것을 확인할 수 있습니다.

   (이미지)
   
- presented View에서 closeButton을 눌러 dismiss를 처리하는 과정은 다음과 같습니다.
```swift
// CourseSectionDetail.swift

// 현재 present 상태를 담을 변수
@Environment(\.presentationMode) var presentationMode

...

CloseButton()
  .padding()
  .onTapGesture {
    presentationMode.wrappedValue.dismiss()
  }
```

