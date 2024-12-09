import { http } from "@kit.NetworkKit";
import { BasicConstants } from "../constants/BasicConstants";

export function myRequest<T, K>(
  url: string,
  method: http.RequestMethod,
  requestData?: K
){
  const httpRequest = http.createHttp()
  return new Promise((resolve:(value: RequestData<T>) => void,
    reject: (value?: string)=> void
  )=> {
    httpRequest.request(BasicConstants.BASE_URL + url, {
      method: method,
      header: {
        'content-type': "application/json"
      },
      extraData: JSON.stringify(requestData) || '',
      connectTimeout: 6000,
      readTimeout: 6000
    }, (err: Error, data: http.HttpResponse) => {
      if(!err){
        resolve(JSON.parse(data.result as string))
      } else {
        reject(err.message)
      }
    })
  })

}


interface RequestData<T> {
  status: boolean;
  message: string;
  data: T;
}
export function myRequestGet<T, K>(url: string, requestData?: K): Promise<RequestData<T>>{
  return myRequest(url, http.RequestMethod.GET, requestData)
}

export function myRequestPost<T, K>(url: string, requestData?: K): Promise<RequestData<T>>{
  return myRequest(url, http.RequestMethod.POST, requestData)
}

export function myRequestPut<T, K>(url: string, requestData?: K): Promise<RequestData<T>>{
  return myRequest(url, http.RequestMethod.PUT, requestData)
}

export function myRequestDelete<T, K>(url: string, requestData?: K): Promise<RequestData<T>>{
  return myRequest(url, http.RequestMethod.DELETE, requestData)
}