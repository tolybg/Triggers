public with sharing class OpportunityAccessor 
{
    public static Map<Id,Opportunity> getOppAmounts(Set<Id> oppIds)
    {
        return new Map<Id,Opportunity>([SELECT Id, Amount FROM Opportunity WHERE Id IN : oppIds]);
    }
}
