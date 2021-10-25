@isTest
private class OpportunityTest 
{
    @isTest
    static void TestFollowUp()
    {
        Opportunity opp=new Opportunity(Name='KAB Test',
                                        Amount=100, 
                                        StageName='Prospecting',
                                        CloseDate=System.today());

        insert opp;

        List<Task> tasks=[select id, ActivityDate 
                          from Task 
                          where WhatId=:opp.id
                            and Subject='Follow Up'];

        System.assertEquals(1, tasks.size(), 'Expected a follow up task');
        System.assertEquals(System.today().addDays(10), tasks[0].ActivityDate, 'Follow up task should be due in 10 days time');
    }

    @isTest
    static void TestReduceValue()
    {
        Opportunity opp=new Opportunity(Name='KAB Test',
                                        Amount=1000000, 
                                        StageName='Prospecting',
                                        CloseDate=System.today());

        insert opp;

        List<Task> tasks=[select id, ActivityDate  
                          from Task 
                          where WhatId=:opp.id
                            and Subject='Reduce Value'];

        System.assertEquals(1, tasks.size(), 'Expected a reduce value task');
        System.assertEquals(System.today().addDays(2), tasks[0].ActivityDate, 'Reduce Value task should be due in 2 days time');
    }

    @isTest
    static void TestBulk()
    {
        List<Opportunity> opps=new List<Opportunity>();

        for (Integer idx=0; idx<200; idx++)
        {
            Opportunity opp=new Opportunity(Name='KAB Test ' + idx,
                                            Amount=(0==Math.mod(idx, 5)?1000000:100), 
                                            StageName='Prospecting',
                                            CloseDate=System.today());
            opps.add(opp);
        }

        insert opps;

        List<Task> followUpTasks=[select id, ActivityDate 
                          from Task 
                          where WhatId In:opps
                            and Subject='Follow Up'];

        System.assertEquals(200, followUpTasks.size(), 'Expected 200 follow up tasks');

        List<Task> reduceTasks=[select id, ActivityDate  
                          from Task 
                          where WhatId in :opps
                            and Subject='Reduce Value'];

        System.assertEquals(40, reduceTasks.size(), 'Expected 40 reduce value tasks');
    }
}
