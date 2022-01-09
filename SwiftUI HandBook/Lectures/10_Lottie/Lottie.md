# Ch10. Lottie(UIViewRepresentable)

## UIViewRepresentable
- UIViewRepresentable은 **UIKit을 SwiftUI에서 구현할 수 있도록 Wrapping 해주는 Protocol**입니다.
- UIViewRepresentable를 상속받은 객체는 makeUIView(context:) -> UIView, updateUIView(:context:) 총 2개의 메소드를 구현해주어야 합니다.

### makeUIView(context:) -> UIView
- **UIView를 생성해주는 메소드**로, SwiftUI에서 UIViewRepresentable을 상속받은 객체를 호출하는 시점에 단 한 번 호출됩니다. 래핑하고자 하는 UIView를 내부에 구현해주고 return시키면, 해당 UIView를 Wrapping하여 SwiftUI의 View로 보여지게 됩니다.

### updateUIView(:context:)
- **SwiftUI View의 state가 변경될 때마다 트리거되어 메소드를 실행**합니다. 해당 메소드 내부에서 view 정보를 업데이트할 수 있으며, @Binding 기능을 이용하여 SwiftUI View의 상태값을 read-only로 참조할 수 있습니다. 


## Lottie
- 위에서 살펴본 UIViewRepresentable을 이용하여 Lottie를 보여주는 View를 구현해보겠습니다.
- 필요한 Lottie JSON 파일을 준비하고, Lottie 라이브러리를 Import하여 Lottie를 구성할 수 있는 환경을 만들어줍니다.

```swift
struct Lottie: UIViewRepresentable {
  @Binding var fileName: String
  let animationView = AnimationView()
  
  func makeUIView(context: Context) -> some UIView {
    let view = UIView(frame: .zero)
      
    animationView.animation = .named(fileName)
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .loop
    animationView.play()
    
    view.addSubview(animationView)
    animationView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
      animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
    
    return view
  }
  
  func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Lottie>) {
    animationView.animation = .named(fileName)
    animationView.play()
  }
}
```

- UIViewRepresentable을 상속받는 Lottie라는 이름의 구조체를 만들고, 해당 구조체 내부에 lottie 파일의 이름을 참조하여 불러올 수 있도록 @Binding String과 animationView를 만들어줍니다.
- makeUIView에는 SwiftUI에서 실제로 보여질 view를 만들고, 해당 view에 animationView를 자식뷰로 추가하여 return합니다. **makeUIView는 View가 처음 생성될 때 호출**됩니다. 위 코드에서는 Binding된 fileName을 읽어와 해당 파일을 animation으로 지정, 이를 view에 담아 리턴하는 코드를 구현하였습니다. 
- updateUIView에는 State가 변경될 때마다 업데이트 될 View의 내용을 구현합니다. 위 코드에서는 Binding String인 fileName 값이 변경될 때마다 메소드가 호출되며, 변경된 fileName을 가지고 View animation을 재정의하여 animation을 재생하는 코드를 구현하였습니다.  

```swift
// LottieView.swift
import SwiftUI
import UIKit
import Lottie

struct LottieView: View {
  @State var fileName: String = "success"
  
    var body: some View {
      VStack {
        Lottie(fileName: $fileName)

        Spacer()
        
        Button(action: {
          self.fileName = self.fileName == "success" ? "loading" : "success"
        }) {
          Text("Changed Animation")
        }
      }
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
      LottieView(fileName: "success")
    }
}
```

- SwiftUI의 View가 될 LottieView를 구현합니다.
- State 값이 될 fileName을 생성하고, 이를 Lottie에 Binding으로 전달합니다.
- 하단에 구현된 Button의 Action에는 fileName을 변경하는 코드를 작성하여, 누를 때마다 다른 Lottie Animation이 보여지도록 구현하였습니다.  


> ![Simulator Screen Recording - iPhone 13 Pro Max - 2022-01-09 at 15 24 57](https://user-images.githubusercontent.com/59811450/148671704-ee024553-5c54-4054-b1cd-5507011227be.gif)

