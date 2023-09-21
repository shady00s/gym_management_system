"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function sendDataOffline(req, res) {
    let results = req.session.playerList;
    const prossedPlayerSet = new Set();
    const resultData = [];
    let playerData = {
        notOriginalId: false,
        id: 0,
        playerIndexId: 0,
        playerId: 0,
        team: undefined,
        name: ""
    };
    let playerId;
    let prossedPlayerId;
    for (const player of results) {
        playerId = player.name;
        prossedPlayerId = player.name;
        if (playerData[playerId]) {
            if ((playerData[playerId].name === player.name)) {
                if (!(playerData[playerId].subscriptions.every(e => player.subscriptions.every(f => e.team === f.team && e.beginDate === f.beginDate && e.billId === f.billId && e.subscriptionDuration === f.subscriptionDuration && e.subscriptionValue === f.subscriptionValue)))) {
                    playerData[playerId].subscriptions.push(...player.subscriptions);
                }
                for (var e of playerData[playerId].subscriptions) {
                    e.playerSubscriptionId = playerData[playerId].playerIndexId;
                }
            }
            let teamId = new Set();
            for (const iterator of playerData[playerId].subscriptions) {
                if (!teamId.has(iterator.team)) {
                    teamId.add(iterator.team);
                }
                playerData[playerId].team = Array.from(teamId);
            }
            if (!prossedPlayerSet.has(playerId)) {
                prossedPlayerSet.add(playerId);
                resultData.push(playerData[playerId]);
            }
        }
        else {
            playerData[playerId] = player;
            for (var e of playerData[playerId].subscriptions) {
                e.playerSubscriptionId = playerData[playerId].playerIndexId;
            }
            if (!prossedPlayerSet.has(playerId)) {
                prossedPlayerSet.add(playerId);
                resultData.push(playerData[playerId]);
            }
        }
    }
    res.json({ message: "succssess", resultData });
}
exports.default = sendDataOffline;
//# sourceMappingURL=send_data_offline.js.map