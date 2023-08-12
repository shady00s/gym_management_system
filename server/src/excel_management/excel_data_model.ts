interface IExcelDataModel{
    playerIndexId:number,
    id:number,
    playerId:number,
    team:number,
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