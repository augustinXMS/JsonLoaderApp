public class c_ErrorLog {
    public static  c_ErrorLog__c record( String source, Exception e ) {
        c_ErrorLog__c error=new c_ErrorLog__c(
            Name = source == null ? 'unknown' : source.abbreviate( 80 )
          , c_Topic__c = e.getTypeName() == 'unknown' ? 'unknown' : e.getTypeName()
          , c_Source__c = source == null ? 'unknown' : source
          , c_ErrorMessage__c = e.getMessage() == null ? null : e.getMessage()
          , c_StackTrace__c = e.getStackTraceString() == null ? null : e.getStackTraceString()
        );
        return error;
    }
}