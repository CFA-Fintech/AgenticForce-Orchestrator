@isTest
public class TestDataFactory {
    public static Account makeAccount(String name) {
        Account a = new Account(Name = name != null ? name : 'Test Account');
        insert a; return a;
    }
}
