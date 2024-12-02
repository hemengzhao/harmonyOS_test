@Component
export struct OverviewItem{
  @Prop color: string | Color = 'red'
  @Prop num: number
  @Prop title: string

  @State h: number = 130
  build() {
    Column({
      space: 5
    }){
      Image($r('app.media.background')).width(40)
      Text(`${this.title}`).fontSize(20).fontWeight(FontWeight.Bold)
      Text(`${this.num}任务`).fontSize(16)
    }
    .width('100%')
    .borderRadius(10)
    .backgroundColor(this.color)
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .height(this.h)
  }
}