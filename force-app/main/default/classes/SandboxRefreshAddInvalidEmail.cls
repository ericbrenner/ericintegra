global class SandboxRefreshAddInvalidEmail implements SandboxPostCopy { 

    global void runApexClass(SandboxContext context) { 

        System.debug(context.organizationId()); 

        System.debug(context.sandboxId()); 

        System.debug(context.sandboxName()); 

        AddInvalidToContactEmail.addInvalid();

    } 

} 