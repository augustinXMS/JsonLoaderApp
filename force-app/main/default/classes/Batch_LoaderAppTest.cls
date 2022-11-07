@isTest
public class Batch_LoaderAppTest {
    static testMethod void successfulTest() {
       String recordsList = '[\n   {\n      \"Name\" : \"Record1\",\n      \"NumberField\" : 3,\n      \"PercentField\" : 0.3\n   }\n]';
        Batch_LoaderApp btclass = new Batch_LoaderApp(recordsList);  
        Test.startTest();
        Id batchJobId = Database.executeBatch(btclass);   
        Test.stopTest();
        //AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE ID =: batchJobId ];
    }
    static testMethod void errorTest() {
       String recordsList = '[\n   {\n      \"Name\" : \"Record1\",\n      \"NumberField\" :\"Record1\",\n      \"PercentField\" : 0.3\n   }\n]';
        Batch_LoaderApp btclass = new Batch_LoaderApp(recordsList);  
        Test.startTest();
        Id batchJobId = Database.executeBatch(btclass);   
        Test.stopTest();
       // AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE ID =: batchJobId ];
    }
}