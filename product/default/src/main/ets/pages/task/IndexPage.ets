import { createTask } from '../../uilt/taskUilt';
import { TaskListItem } from '../../view/task/TaskItem';
import { TaskOverview } from '../../view/task/TaskOverview'
import { TaskItem } from '../../viewmodel/task';
import { router } from '@kit.ArkUI';
@Extend(Text) function fancyText(fontSize: number = 30){
  .fontSize(fontSize)
  .fontWeight(FontWeight.Bold)
}

@Entry
@Component
struct IndexPage {
  @State message: string = 'Hello World';
  @StorageLink('taskList') taskList: TaskItem[] = []
  aboutToAppear(): void {
    this.taskList =  createTask()
  }
  build() {
    Stack(){
      Column(){
        //    头部
        Column(){
          Text('你好！ 小何').fancyText()
          Text('让每一天更美好').fontSize(20)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        // 我的计划
        Column(){
          Text('我的计划').fancyText()
          TaskOverview({
            list: this.taskList
          })
        }.margin({
          top: 20
        }).alignItems(HorizontalAlign.Start)

        Row(){
          Text('今日任务').fancyText()
          Text('查看全部')
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .margin({top: 20})
        .alignItems(VerticalAlign.Bottom)

        Column(){
          TaskListItem({
            list: this.taskList
          })
        }.layoutWeight(1)

      }
      .width('100%')
      .height('100%')
      .padding(10)
      .backgroundColor(Color.White)


      Stack(){
        Image($r('app.media.background')).width('100%').borderRadius('50%')
        Image($r('app.media.add')).width('80%').borderRadius('50%')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/task/addTaskPage'
            })

          })
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .clip(true)
      .margin({
        right: 20
      })



    }.align(Alignment.BottomEnd)
  }
}