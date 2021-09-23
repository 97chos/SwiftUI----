# Ch2. Stack And Spacer

## VStack
- VStack을 사용하면 위에서 아래로 수직으로 View를 쌓을 수 있습니다.
- 인자값으로 정렬 기준이나 간격 값을 전달하여 속성 값을 정의할 수 있습니다.
```swift
    VStack(alignment: .trailing, spacing: 30) {
      Circle()
        .frame(width: 44, height: 44)
      Text("SwiftUI for iOS 14")
        .font(.title)
        .fontWeight(.bold)
      Text("20 Videos")
    }
```

> <img width="300" alt="스크린샷 2021-08-26 오후 12 31 18" src="https://user-images.githubusercontent.com/59811450/130896090-b1c936fe-1f91-43f8-b23a-e7f71733382e.png">

## HStack
- View를 수평방향으로 쌓는데 사용됩니다.
- HStack과 마찬가지로 정렬 기준 및 간격 값을 정의할 수 있습니다.
 ```swift
    HStack(alignment: .center, spacing: 20) {
      Circle()
        .frame(width: 44, height: 44)
      Text("SwiftUI for iOS 14")
        .font(.title)
        .fontWeight(.bold)
      Text("20 Videos")
    }
```
> 

## Spacer
- spacer는 SwiftUI의 Stack 구조에서 콘텐츠를 밀어내어 일정 부분의 여백을 차지하기위해 사용됩니다.
- 적절한 곳에 여러 spacer를 배치하여 요소를 정렬하는 목적에 유용하게 사용됩니다. 

> <img width="300" alt="spacing: 20, padding: 10, GridItem 3개" src="https://user-images.githubusercontent.com/59811450/130897184-d13e8aaf-0034-4d4a-8418-e217df3ce34f.png">


## ZStack
- 겹쳐지는 콘텐츠에 주로 사용됩니다. 3차원 평면에서 각 View 위에 레이어를 쌓는 방식으로 동작합니다.
```swift
    ZStack(alignment: .top) {
      Circle()
        .frame(width: 44, height: 44)
      Text("SwiftUI for iOS 14")
        .font(.title)
        .fontWeight(.bold)
      Text("20 Videos")
    }
```

>
