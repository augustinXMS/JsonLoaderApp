@isTest
public class Batch_LoaderAppTest {
    static testMethod void successfulTest() {
        String recordsList = '[\n   {\n      \"Name\" : \"Record1\",\n      \"NumberField\" : 3,\n      \"PercentField\" : 0.3\n   }\n]';
        Batch_LoaderApp btclass = new Batch_LoaderApp(recordsList);  
        Test.startTest();
        Id batchJobId = Database.executeBatch(btclass);   
        Test.stopTest();
        Account acc=[Select id, Name from Account where Name='Record1'];
        System.assertEquals('Record1', acc.Name, 'Record Not found');
    }
    static testMethod void errorTest() {
        String recordsList = '[\n   {\n      \"Name\" : \"Record1\",\n      \"NumberField\" :\"Record1\",\n      \"PercentField\" : 0.3\n   }\n]';
        Batch_LoaderApp btclass = new Batch_LoaderApp(recordsList);  
        Test.startTest();
        Id batchJobId = Database.executeBatch(btclass);   
        Test.stopTest();
        c_ErrorLog__c error=[Select id, Name from c_ErrorLog__c where Name='ParseJSON batch'];
        System.assertEquals('ParseJSON batch', error.Name, 'Record Not found');    }
}