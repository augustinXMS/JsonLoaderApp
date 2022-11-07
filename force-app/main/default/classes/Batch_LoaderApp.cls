public without sharing class Batch_LoaderApp implements Database.Batchable<sObject>{
    public class JsonWrapper{
        @AuraEnabled
        public String name{ get; set; }
        @AuraEnabled
        public Integer numberField{ get; set; }
        @AuraEnabled
        public Decimal percentField{ get; set; }

    }

    List<c_ErrorLog__c> errorRecordList=new List<c_ErrorLog__c>();
    List<JsonWrapper> batchList = new List<JsonWrapper>();
    public Batch_LoaderApp(String records){
        try{
            this.batchList.addAll((List<JsonWrapper>)JSON.deserialize(records, List<JsonWrapper>.class));
        } catch (Exception e){
            this.errorRecordList.add(c_ErrorLog.record('ParseJSON batch', e));
        }
    }
    //use empty Iterable to implement the method
    public Iterable<sObject> start(Database.BatchableContext info){
        List<Account> objlist = new List<Account>();
        objlist.add(new Account());
        return objlist;
    }

    public void execute(Database.BatchableContext info, List<sObject> scope){
        try{
            List<Account> accountList = new List<Account>();
            for (JsonWrapper rec : batchList){
                Account act = new Account();
                act.name = rec.name;
                act.NumberField__c = rec.NumberField;
                act.PercentField__c = rec.PercentField;
                accountList.add(act);
            }
            insert accountList;
        } catch (Exception e){
            this.errorRecordList.add(c_ErrorLog.record('Batch_LoaderApp.execute batch', e));
        }
    }

    public void finish(Database.BatchableContext info){
        if(errorRecordList!=null){
            insert this.errorRecordList;
        }
        
    }

}