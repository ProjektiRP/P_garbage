RegisterNetEvent('P_garbage:pay')
AddEventHandler('P_garbage:pay', function(bagCount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local payAmount = Config.PayPerBag * bagCount

    if payAmount > 0 then
        exports['ox_inventory']:AddItem(xPlayer.source, 'Money', payAmount)
        Notify(source, 'inform', Config.Locales[Config.Language]['pay_received']:format(payAmount))
    else
        Notify(source, 'inform', Config.Locales[Config.Language]['no_pay_received'])
    end
end)