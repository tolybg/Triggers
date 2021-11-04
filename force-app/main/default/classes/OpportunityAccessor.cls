public with sharing class OpportunityAccessor 
{
    public static List<Opportunity> getOppAmounts(Set<Id> oppIds)
    {
        return new List<Opportunity>([SELECT Id, Amount FROM Opportunity WHERE Id IN : oppIds]);
    }
}
