
export interface EchartsData{
  gropuName: string
  list: List[]
}

export interface List {
  title: string
  data: Record<string, number>
}

export interface Data {
  "01": number
  "02": number
}
