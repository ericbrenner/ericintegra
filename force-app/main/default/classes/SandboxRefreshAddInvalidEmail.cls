global class SandboxRefreshAddInvalidEmail implements SandboxPostCopy { 

    public static void isSandboxFlag(){
    Sandbox__c sand = new Sandbox__c(Sandbox__c=true);
    insert sand;
    }

    //runs on sandbox refresh to add '.invalid' to all Contact emails. 
    global void runApexClass(SandboxContext context) { 

        System.debug(context.organizationId()); 

        System.debug(context.sandboxId()); 

        System.debug(context.sandboxName()); 
        isSandboxFlag();
        AddInvalidToContactEmail.addInvalid();

    } 

} 