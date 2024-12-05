@Component
export  struct  EmptyView {
  private defaultHeight: string = '100%'
  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }){
      Image('https://hbimg.huabanimg.com/64040f275307f37d8fa0491f115f80cdab911bc14c77-FBQjRV_fw658')
        .width(100)
      Text('页面空空如也')
        .fontColor(Color.Gray)
    }.width('100%')
    .height(this.defaultHeight)
  }
}