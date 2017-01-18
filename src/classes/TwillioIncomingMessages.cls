@RestResource(urlMapping = '/SMStoApexReply/')
global class TwillioIncomingMessages {
    @HttpPost
    global static String readIncoingSMS() {  
        RestRequest request = RestContext.request;  
        RestResponse response = RestContext.response; 
        system.debug('request'+request);
        system.debug('response'+response);
        
        request.addHeader('Accept', '*/*');
        Map<String,String> headers = request.headers ; 
        Map<String,String> reqParams = request.params ;
        
        String fromNumber = reqParams.get('FROM');
        fromNumber.replaceAll('(','');
        fromNumber.replaceAll(')','');
        fromNumber.replaceAll('-','');
        String toNumberNumber = reqParams.get('TO');
        toNumberNumber.replaceAll('(','');
        toNumberNumber.replaceAll(')','');
        toNumberNumber.replaceAll('-','');
        
        
        SMS_Reply__c  rq = new SMS_Reply__c ();
        rq.SMS__c =[Select Id from SMS__c where From_Number__c =:fromNumber AND To_Number__c =:toNumberNumber order by CreatedDate].Id ;
        rq.Reply_Message__c= reqParams.get('Body');
        insert rq ; 
        return 'Success';  
    }  
    
    
    
}