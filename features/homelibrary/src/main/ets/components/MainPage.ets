@Component
export struct MainPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Stack({
        alignContent: Alignment.Top
      }){
          Image($r('app.media.southeast'))
            .width('100%')
            .height(220)
            .objectFit(ImageFit.Auto)

        Flex({direction: FlexDirection.Column}){
          //  搜索模块
          Column(){
              Flex({
                justifyContent: FlexAlign.SpaceBetween
              }){
                Image($r('app.media.sao')).height('100%')
                Image($r('app.media.sao')).height('100%')
              }.height(24)
            .width('100%')
            .margin({
              bottom: 8
            })
            Row(){
              Image($r('app.media.search')).height(20).width(20)
            }
            .height(40)
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(20)

          }

          // 轮播图
          Column(){

          }

          // 楼诚
          Column(){

          }

          //商品列表
          Column(){

          }

        }
        .padding({
          left: 12,
          right: 12,
          top: 10
        })
      }

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f3f5')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
  }
}
