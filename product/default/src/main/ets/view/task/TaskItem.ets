import { formatDate } from "../../uilt/date"
import { createTask } from "../../uilt/taskUilt";
import { TaskItem } from "../../viewmodel/task"

@Component
export  struct  TaskListItem{
  @Prop list: TaskItem[] = []

  build() {
    List(){
      ForEach(this.list.filter(item => item.date === formatDate(new Date(), 'YYYY-MM-DD')),
        (item: TaskItem) => {
        ListItem(){
          Column({
            space: 10
          }){
            Row(){
              Image($r('app.media.file')).width(30).margin({right: 10})
              Text(item.name).fontSize(20).fontWeight(FontWeight.Bold)
            }
            Text(`${item.startTime}-${item.startTime}`).fontSize(16)

            Text('工作')
              .padding({left: 10, right: 10})
              .backgroundColor(Color.Red)
              .fontColor(Color.White)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .borderRadius(10)

          }.alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(20)
          .margin({bottom: 10})
          .backgroundColor(Color.Gray)
          .borderRadius(10)
        }
      }, (item: TaskItem) => item.id.toString())

    }.height('100%')
  }
}