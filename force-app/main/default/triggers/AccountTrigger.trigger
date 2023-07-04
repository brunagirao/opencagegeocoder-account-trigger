/************************************************************************************************
* Name      : AccountTrigger
* Purpose   : Trigger to Account Object
* TestClass : AccountTriggerTest
* Author    : Bruna Girão
* Date      : 19-06-2023
***************************************************************************************************/
trigger AccountTrigger on Account (
    before insert, before update, before delete,
    after insert, after update, after delete, after undelete
) {
    System.debug('======= AccountTrigger ========');
    new AccountTriggerHandler().run();

}