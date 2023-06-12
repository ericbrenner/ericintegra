public class AddInvalidToContactEmail {
    //List of all emails from the Contact object that do not end with .invalid, then add .invalid to them

    static String Invalid = '.invalid';
    
    public static void addInvalid() {
        List<Contact> contactEmailList = [select Id,Email from Contact where (email != null) and (not email like :Invalid)];

        for(Contact conEmail : contactEmailList) 
        {
            conEmail.Email = conEmail.Email + Invalid; 
        } 

        if(contactEmailList.size() > 0) 
        { 
            try{
                Update contactEmailList; 
            } catch(DmlException e){
                System.debug('The following error has occured: ' + e.getMessage());
            }
        } 
    }
}