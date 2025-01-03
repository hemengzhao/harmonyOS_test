import { router } from "@kit.ArkUI"

@Component
export struct TopBarNav{
  @Prop title: string = ''
  // 右侧插槽
  @BuilderParam rightBox?: () => void

  build() {
    Row(){
      Column(){
        Image($r('app.media.back_icon')).width(10)
      }.width(30).alignItems(HorizontalAlign.Start).onClick(() => {
        router.back()
      })


      Column(){
        Text(this.title).fontSize(20).fontWeight(FontWeight.Bold).fontColor('#333')
      }.flexGrow(1)

      Column(){
        if(this.rightBox){
          this.rightBox()
        }
      }
    }.width('100%')
    .padding({left: 20, right: 20, bottom: 10, top: 10})
    .justifyContent(FlexAlign.SpaceBetween)

  }
}