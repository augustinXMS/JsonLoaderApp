public with sharing class LoaderApp {

    public class UploadedFilesWrapper{
        @AuraEnabled
        public String name {get; set;}
        @AuraEnabled
        public String documentId {get; set;}
        @AuraEnabled
        public String contentVersionId {get; set;}
        @AuraEnabled
        public String contentBodyId {get; set;}
        @AuraEnabled
        public String mimeType {get; set;}
    }
    
    static List<UploadedFilesWrapper> dataList = new List<UploadedFilesWrapper>();
    static String records='';

    @AuraEnabled(cacheable=true)
    public static string jsonLoader( String uploadedFiles) {
        
        Set<Id>documentIdSet = new Set<Id>();
        List<ContentVersion>versionDataFiles = new List<ContentVersion>();

        dataList = (List<UploadedFilesWrapper>) JSON.deserialize(uploadedFiles, List<UploadedFilesWrapper>.class);
       
        for(UploadedFilesWrapper obj : dataList){
            documentIdSet.add((id)obj.documentId);
        }
        
        versionDataFiles = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId in:documentIdSet WITH SECURITY_ENFORCED];
        
        for(ContentVersion cv : versionDataFiles){
            records += cv.VersionData.toString();
        }
        Database.executeBatch(new Batch_LoaderApp(records));
        return records;
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name ,PercentField__c, NumberField__c FROM Account WITH SECURITY_ENFORCED ];
    }
}