# Ch20. Create Widget

## Widget

- iOS 14.0 이상에서 홈 화면에 위젯을 추가하여 앱에 좀 더 쉽게 액세스하도록 구현할 수 있습니다.
- Xcode -> File -> New -> Target에서 Widget Extension을 생성하여 Widget Scheme를 생성합니다.

(이미지)

- DesignCodeWidgetEntryView는 생성된 위젯이 보여지는 공간으로, Environment(\.widwgetFamily) 타입의 변수를 두어 위젯의 크기에 따라 보여지는 화면을 다르게 설정할 수 있습니다.

(이미지)

- DesignCodeWidgetMedium의 경우, 다른 scheme에 있는 소스(CourseRow)를 필요로 하는데, 이 경우 해당 scheme에서 Widget scheme을 참조할 수 있도록 타겟을 설정해주어야 합니다.

### 위젯 기본 구성

- DesignCodeWidget에서 위젯의 기본구성사항을 변경할 수 있습니다.
- configurationDisplayName을 변경하여 화면에서 보여지는 위젯의 이름을 변경할 수 있으며, description을 통해 위젯의 설명란을 수정할 수 있습니다.
- supportedFamilies 속성으로 지원되는 위젯의 크기를 배열로 전달하여 설정할 수 있습니다.

(이미지)

- DesignCodeWidget_Previews의 previewContext 속성을 변경하여 preview에서 보여지는 위젯의 크기 또한 변경이 가능합니다.

- 적용된 위젯

(이미지)
