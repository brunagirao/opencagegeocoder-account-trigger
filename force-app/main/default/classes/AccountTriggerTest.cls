/************************************************************************************************
* Name      : AccountTriggerTest
* Purpose   : Test Class to AccountTrigger
* Author    : Bruna Girão
* Date      : 22-06-2023
***************************************************************************************************/
@IsTest
public with sharing class AccountTriggerTest {
    
    @IsTest
    static void insertAccountsTest() {
        //Given
        List<Account> accountToInsertList = createAccountList(50);

        //When
        Test.startTest();
            insert accountToInsertList;
        Test.stopTest();

        //Then
        List<Account> accountsInsertedList = [
            SELECT Id FROM Account WHERE Name LIKE '%Account Test%'
        ];

        System.Assert.areEqual(50, accountsInsertedList.size(), '50 Account records were inserted!');
    }

    @IsTest
    static void updateAccountsTest() {
        //Given
        List<Account> accountToInsertList = createAccountList(50);
        insert accountToInsertList;
        
        for(Account acc : accountToInsertList) {
            acc.Name = 'Updated ' + acc.Name;
        }
        List<Account> accountToUpdateList = new List<Account>(accountToInsertList);

        //When
        Test.startTest();
            update accountToUpdateList;
        Test.stopTest();

        //Then
        List<Account> accountsUpdatedList = [
            SELECT Id FROM Account WHERE Name LIKE '%Updated Account Test%'
        ];

        System.Assert.areEqual(50, accountsUpdatedList.size(), '50 Account records were updated!');
    }


    @IsTest
    static void deleteAccountsTest() {
        //Given
        List<Account> accountToInsertList = createAccountList(50);
        insert accountToInsertList;
        
        for(Account acc : accountToInsertList) {
            acc.Name = 'To Delete ' + acc.Name;
        }
        List<Account> accountToDeleteList = new List<Account>(accountToInsertList);

        //When
        Test.startTest();
            delete accountToDeleteList;
        Test.stopTest();

        //Then
        List<Account> accountsRemainToDeleteList = [
            SELECT Id FROM Account WHERE Name LIKE '%To Delete Account Test%'
        ];

        System.Assert.areEqual(0, accountsRemainToDeleteList.size(), '0 Account records need to be deleted!');
    }



    /**
    * @description Method responsible to create Account records.
    * @param quantity 
    * @return List<Account> 
    **/
    private static List<Account> createAccountList(Integer quantity) {
        List<Account> accountList = new List<Account>();
    
        for(Integer i = 0; i < quantity; i++) {
            accountList.add(
                new Account (
                    Name = 'Account Test ' + i,
                    AccountNumber = '123456'+ i
                )
            );
        }

        return accountList;
    }
}