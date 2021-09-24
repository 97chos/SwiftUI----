# Ch2. Image, Shape and Stroke

## Image
- Image 메소드를 이용하여 Image View를 추가할 수 있습니다.
- Asset에 추가된 이미지를 불러올 경우 인자값으로 해당 이미지의 name string을 전달하며, SF Symbol의 경우에는 Image(systemName: <String>)을 사용합니다.

```swift
    Image(systemName: "cross.fill")
```

## Shape
- 여러 도형 모양을 View로 추가할 수 있습니다.
- stack과 다르게 최대 공간을 차지하며, 색상 지정시 background 대신 foregroundColor를 사용합니다.
- 콘텐츠를 자르거나 테두리 스타일을 정의하는데 유용하게 사용됩니다.

### Circle
- Circle은 완벽한 원형 모양을 나타냅니다.
- 지름은 width, height 중 더 낮은 값으로 결정되며, 나머지 값은 여백으로 설정됩니다.

### Ellipse
- Ellipse는 타원형을 의미합니다.
- Circle과 같지만 종횡비가 완벽한 1:1 비율이 아니며, 너비와 높이가 다를 경우 늘어나 타원 모양으로 공간을 채우게됩니다.

### Rectangle
- Rectangle은 직사각형을 의미합니다.

### RoundedRectangle
- RoundedRectangle은 둥근 사각형을 의미합니다.
- cornerRadius를 사용하여 곡률을 정의할 수 있습니다.

### Capsule
- RoundedRectangle과 유사하게 동작하나, 알약 모양처럼 각 끝이 반원 형태로 되어있습니다.
- 주로 버튼에서 많이 사용됩니다.

```swift
      VStack(spacing: 20) {
        Image(systemName: "cross.fill")
          .foregroundColor(Color.black)
          .frame(width: 150)

        Circle()
          .stroke(lineWidth: 3)
          .frame(width: 150, height: 100)

        Ellipse()
          .stroke(lineWidth: 3)
          .frame(width: 150, height: 100, alignment: .center)

        Rectangle()
          .stroke(lineWidth: 3)
          .frame(width: 150, height: 100)

        RoundedRectangle(cornerRadius: 20)
          .stroke(lineWidth: 3)
          .frame(width: 150, height: 100)

        Capsule()
          .stroke(lineWidth: 3)
          .frame(width: 150, height: 100)
      }
```

> <img width="300" alt="스크린샷 2021-09-24 오후 5 33 59" src="https://user-images.githubusercontent.com/59811450/134647727-37e1b407-8dbd-4d00-8cf8-fbd051a60d84.png">

- Stroke 속성을 이용하여 도형의 layer만 그릴 수 있습니다.

## 활용 예제

```swift
struct ContentView: View {
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(Color.blue)
        .ignoresSafeArea()

      VStack() {
        Circle()
          .stroke(Color.black, lineWidth: 2)
          .frame(width: 44, height: 44)
        Text("Sangho Cho")
          .font(.title2).bold()
        Text("iOS Developer")
          .foregroundColor(Color.secondary)
        Capsule()
          .fill(Color.green)
          .frame(height: 44)
          .overlay(Text("Sign up").bold()) // overlay: 도형 위에 다른 View를 얹을경우 사용합니다.
      }
      .padding()  // VStack 내부에 대한 Padding
      .background(Color.white)
      .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
      .padding()  // VStack 외부의 Multi Container에 대한 padding, 상위 View와 VStack 사이의 간격 조절
    }
  }
}
```
> <img width="300" alt="스크린샷 2021-09-24 오후 5 57 39" src="https://user-images.githubusercontent.com/59811450/134647810-1a03115b-29b2-4ae9-a085-36c3c1e191f6.png">
 
