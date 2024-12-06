import { myRequestGet } from '@ohos/common'

export function findProductById<T, K> (params: K){
    return myRequestGet<T, K>('/productById', params)
}