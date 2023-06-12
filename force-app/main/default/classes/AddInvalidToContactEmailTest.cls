@isTest
public class AddInvalidToContactEmailTest {

    static String testEmail ='testcontact@integratest.com';
    static String testEmailInvalid = testEmail + '.invalid';

    @isTest static void addInvalidTest(){
        Contact cont = new Contact(FirstName='Test',LastName='Contact',Email=testEmail);
        insert cont;

        AddInvalidToContactEmail.addInvalid();

        Contact contEmail = [select Id,Email from Contact where Id = :cont.Id];
        System.assertEquals(testEmailInvalid,contEmail.Email);
    }


}