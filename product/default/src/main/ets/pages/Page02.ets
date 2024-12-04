import {router} from '@kit.ArkUI'
// import  {BreakPointSystem} from "@ohos/common"
@Entry
@Component
struct Page02 {
  @State message: string = 'Hello World';
  @State num: number = 3
  @State flag: number = 1
  private timer: number = 0
  // private  breakPointSystem = new BreakPointSystem()
  @StorageProp('currentBreakPoint') currentBreakPoint: string = 'sm'
  aboutToAppear(): void {
    // this.breakPointSystem.register()
    switch (this.currentBreakPoint){
      case 'sm':
        this.flag *= 1
        break;
      case 'md':
        this.flag *= 1.4
        break;
      case 'lg':
        this.flag *= 1.6
        break;
      case 'xl':
        this.flag *= 2
        break;
    }
    this.timer = setInterval(() => {
      this.num--
      if(this.num === 0){
        router.replaceUrl({
          url: 'pages/Index'
        })
      }

    }, 1000)
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }
  build() {
    Stack({
      alignContent: Alignment.TopEnd
    }){
      Text(`倒计时${this.num}`).margin({right: 20}).fontSize(20  *this.flag)
      Flex({
        direction: FlexDirection.Column,
        alignItems: ItemAlign.Center
      }){
        Column(){
          Image("https://p8.itc.cn/mpbp/pro/20210730/eeb28f5b34ea4b01bf683208cc42ae5f.jpeg").width(200*this.flag)
        }.flexGrow(1)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Image('https://img1.baidu.com/it/u=2341236784,1365968175&fm=253&fmt=auto&app=138&f=JPEG?w=1066&h=500')
          .width(200*this.flag).height(27*this.flag)
        Text('WoniuMall超市')
          .fontColor('#66000000')
          .fontSize(20*this.flag)
          .letterSpacing(16)
          .margin({
            top: 12 * this.flag,
            bottom: 136
          })
      }.width('100%')
      .height('100%')
    }

  }
}