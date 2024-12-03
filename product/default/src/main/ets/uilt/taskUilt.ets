import  { ETaskState, ETaskType, TaskItem} from '../viewmodel/task'
import { getRandomDate, formatDate } from './date'

export  const createTask: () => TaskItem[] = () => {
  const arr: TaskItem[] = []
  for (let index = 0; index < 20; index++) {
    const startTime =  getRandomDate('2024/11/20', '2024/12/05')
    const endTime =  startTime.getTime() + Math.random() * (1000 * 60 * 60 * 5 - -1000 * 60 * 60 * 5)
    const type = [ETaskType.PERSONAL, ETaskType.WORK, ETaskType.STUDY, ETaskType.PLAY][Math.floor(Math.random() * 4)]
    const state = [ETaskState.DONE, ETaskState.UNDONE, ETaskState.WAIT, ETaskState.FUTURE][Math.floor(Math.random() * 4)]
    arr.push(new TaskItem(index + 1, `任务名称${index + 1}`, formatDate(startTime, 'YYYY-MM-DD'), formatDate(startTime, 'HH:mm'),formatDate(endTime, 'HH:mm'), type, state , 'assa'))
  }
  return arr
}

