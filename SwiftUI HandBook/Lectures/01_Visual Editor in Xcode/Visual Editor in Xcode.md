# Ch1. Visual Editor in Xcode

## UI
- SwiftUI는 선언형 코드를 기반으로 작성됩니다.
- UI 요소들을 다음과 같이 정의할 수 있으며, 하위에 각 요소에 맞는 여러 속성들을 나열하여 설정할 수 있습니다. 

```swift
struct ContentView: View {
  var body: some View {
    HStack(alignment: .center) {
      Circle()
        .frame(width: 44, height: 44)
      Text("SwiftUI for iOS 14")
        .font(.title)
        .fontWeight(.bold)
      Text("20 Videos")
    }
    .padding(.all)
    .background(Color.blue)
    .cornerRadius(20)
    .frame(width: 320)
  }
}
```

> <img width="300" alt="스크린샷 2021-08-26 오후 12 31 18" src="https://user-images.githubusercontent.com/59811450/130896090-b1c936fe-1f91-43f8-b23a-e7f71733382e.png">

### 메뉴 삽입
- 삽입 메뉴를 호출(comm + Shift + L) 및 드래그하여 새로운 UI 요소를 배치할 수도 있습니다.
- Button, Date Picker, Label 등 iOS에서 사용할 수 있는 다양한 모든 요소들을 검색할 수 있습니다.

> <이미지>

### Inspector
- 우측 Inspector에서 현재 선택된 UI에 대한 속성들을 변경할 수 있습니다.
- Add Modifier를 통해 background, cornerRadius 같은 원하는 속성을 검색하여 추가할 수 있습니다.

> <이미지>
