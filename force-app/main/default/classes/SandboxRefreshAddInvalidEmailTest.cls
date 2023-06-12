@isTest
class SandboxRefreshAddInvalidEmailTest {

    static String testEmail ='testcontactsandbox@integratest.com';
    static String testEmailInvalid = testEmail + '.invalid';

    @isTest
    static void SandboxRefreshAddInvalidEmailTest() {
        Contact cont = new Contact(FirstName='Test',LastName='Contact',Email=testEmail);
        insert cont;

        Test.startTest();

        Test.testSandboxPostCopyScript(
            new SandboxRefreshAddInvalidEmail(), UserInfo.getOrganizationId(),
                UserInfo.getOrganizationId(), UserInfo.getOrganizationName(), true);

        Test.stopTest();

        Contact contEmail = [select Id,Email from Contact where Id = :cont.Id];
        System.assertEquals(testEmailInvalid,contEmail.Email);
    }
}