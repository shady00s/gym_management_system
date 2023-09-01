interface IExcelDataModel{
    playerIndexId:number,
    id:number,
    playerId:number,
    team:any,
    name:string,
    subscriptions?: ISubscriptions[]

}

interface ISubscriptions{
    subscriptionCollectionDate:string,
    playerSubscriptionId:number,
    team:number,
    beginDate:string,
    finishDate:string,
    subscriptionDuration:number,
    subscriptionValue:number,
    billId:number


}
export default IExcelDataModel