/************************************************************************************************
* Name      : AccountTriggerHandler
* Purpose   : Handler to Account Trigger
* TestClass : AccountTriggerTest
* Author    : Bruna Girão
* Date      : 19-06-2023
***************************************************************************************************/
public with sharing class AccountTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {
        System.debug('========== BEFORE INSERT =========');
    }

    public override void afterInsert() {
        System.debug('========== AFTER INSERT =========');
    }

    public override void beforeUpdate() {
        System.debug('========== BEFORE UPDATE =========');
    }

    public override void afterUpdate() {
        System.debug('========== AFTER UPDATE =========');
    }

    public override void beforeDelete() {
        System.debug('========== BEFORE DELETE =========');
    }

    public override void afterDelete() {
        System.debug('========== AFTER DELETE =========');
    }

}