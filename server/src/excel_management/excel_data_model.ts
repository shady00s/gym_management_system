interface IExcelDataModel{
    id:number,
    playerId:number,
    team:string,
    name:string,
    subscriptions?: ISubscriptions[]

}

interface ISubscriptions{

    beginDate:string,
    finishDate:string,
    subscriptionDuration:number,
    subscriptionValue:number,
    billId:number


}
export default IExcelDataModel