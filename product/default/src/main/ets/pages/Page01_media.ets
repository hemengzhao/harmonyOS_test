import { mediaquery } from '@kit.ArkUI'

@Entry
@Component
struct Page01_media {
  @State message: string = 'Hello World';
  @State  screenDir: string = '竖屏'
  // 是否为横屏
  @Provide listener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync('(orientation: landscape)')
  onPortrait = (mediaQueryResult: mediaquery.MediaQueryResult) => {

        this.screenDir = mediaQueryResult.matches ? '横屏' : '竖屏'

  }
  aboutToAppear(): void {
    this.listener.on('change', this.onPortrait)
  }
  build() {
    Column()  {
      Text('媒体查询')
      Text(`屏幕是为${this.screenDir }`)
    }
    .height('100%')
    .width('100%')
  }
}