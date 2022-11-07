@isTest
public class LoaderAppTest {
    @testSetup
    static void testData(){
        //Content version record to be created with the json
         String jsonFile = '[\n   {\n      \"Name\" : \"Record1\",\n      \"NumberField\" :\"Record1\",\n      \"PercentField\" : 3\n   }\n]';
        ContentVersion  testDocument= new ContentVersion();
        Blob tempBlob = Blob.valueOf(jsonFile);
		insert testDocument;
    }
   /* static testMethod void successfulTest() {
       String recordsList = '[{\"name\":\"TestData.json\",\"documentId\":'+ +',\"contentVersionId\":\"0685r000001Spz2AAC\",\"contentBodyId\":\"05T5r000005ZeKfEAK\",\"mimeType\":\"application/json\"}]';
        Test.startTest();
        
        Test.stopTest();
    }*/
}