import { router } from "@kit.ArkUI"

@Component
export struct TopBar {
  @State isBack: boolean = false
  build() {
    Row(){
      if(this.isBack) {
        Text('<').width(36).height(36).borderRadius(18)
          .backgroundColor(Color.White)
          .textAlign(TextAlign.Center)
          .fontSize(18)
          .onClick(() => {
            router.back()
        })
      } else {
        Text('西安').fontWeight(FontWeight.Bold)
          .fontSize(20)
          .fontColor(0x333333)
      }
      Column(){
        Image($r('app.media.home_my')).width(50).onClick(() => {
          router.pushUrl({
            url: 'pages/MyPage'
          })
        })
      }
    }.justifyContent(FlexAlign.SpaceBetween).width('100%')
    .padding({
      left: 20,
      right: 20,
      top: 20
    })

  }
}