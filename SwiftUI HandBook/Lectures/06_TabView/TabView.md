# Ch6. TabView

## TabView
- TabView를 사용하여 여러 View들을 가로로 슬라이드하며 넘겨볼 수 있습니다.

```swift
// pagenation.swift

    var body: some View {
      TabView {
        RoundedRectangle(cornerRadius: 20)
          .foregroundColor(.blue)
          .padding()
        RoundedRectangle(cornerRadius: 20)
          .foregroundColor(.purple)
          .padding()
        RoundedRectangle(cornerRadius: 20)
          .foregroundColor(.red)
          .padding()
        RoundedRectangle(cornerRadius: 20)
          .foregroundColor(.green)
          .padding()
      }

      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
```
> ![Simulator Screen Recording - iPhone 13 Pro Max - 2021-09-27 at 16 53 45](https://user-images.githubusercontent.com/59811450/134868006-67165810-c4a5-465f-b1e3-9a85df6a4bc2.gif)

- TabView 내부에 여러 View들을 만들어 슬라이드하며 View를 넘겨볼 수 있도록 구성하였습니다.
- tabViewStyle은 하단의 indicator를 의미합니다. PageTabViewStyle의 indexDisplayMode에 따라 하단 indicator의 노출 방식이 달라지게 됩니다.
