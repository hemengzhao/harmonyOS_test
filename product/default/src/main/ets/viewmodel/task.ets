
export  enum  ETaskType {
  PERSONAL='personal', // 个人
  WORK='work', // 工作
  STUDY='study', // 学习
  PLAY='play'  // 游玩
}
export const taskType: Record<ETaskType,  string> = {
  [ETaskType.PERSONAL]: '个人',
  [ETaskType.WORK]: '工作',
  [ETaskType.STUDY]: '学习',
  [ETaskType.PLAY]: '游玩'
}
export  enum  ETaskState {
  DONE='done',  // 完成
  UNDONE='undone', //未完成
  WAIT='wait', // 等待
  FUTURE='future' // 未来任务
}
export const taskState: Record<ETaskState,  string> = {
  [ETaskState.DONE]: '已完成',
  [ETaskState.UNDONE]: '未完成',
  [ETaskState.WAIT]: '等待中',
  [ETaskState.FUTURE]: '未来任务'
}

export const  taskColor : Record<ETaskState,  string> = {
  [ETaskState.DONE]: '#83c9e3',
  [ETaskState.UNDONE]: '#717be1',
  [ETaskState.WAIT]: '#e98586',
  [ETaskState.FUTURE]: '#9fe8b7'
}
export  class TaskItem {
  id: number
  name: string
  startTime: string
  endTime: string
  date: string
  type: ETaskType
  state: ETaskState
  describe:string
  constructor(id: number, name: string, date: string, startTime: string, endTime:string, type: ETaskType, state: ETaskState, describe: string) {
    this.id = id
    this.name = name
    this.date = date
    this.startTime = startTime
    this.endTime = endTime
    this.type = type
    this.state = state
    this.describe = describe
  }

}

export class TaskOverviewItem {
  type: ETaskState
  num: number
  title: string
  color: string
  img: string
  constructor(type: ETaskState, num: number, img: string) {
    this.type = type
    this.num = num
    this.title = taskState[type]
    this.color = taskColor[type]
    this.img = img
  }
}