@isTest
private class TaskTest 
{
    @isTest
    static void TestReduce()
    {
        Opportunity opp=new Opportunity(Name='KAB Test',
                                        Amount=10000, 
                                        StageName='Prospecting',
                                        CloseDate=System.today());

        insert opp;

        Task task=new Task(Subject='Reduce Value', 
                                    Status='New',
                                    ActivityDate=System.today(),
                                    WhatId=opp.Id);

        insert task;

        task.Status='Completed';
        update task;

        List<Opportunity> oppsFromDB=[select id, Amount
                                      from Opportunity 
                                      where id=:opp.Id];

        System.assertEquals(5000, oppsFromDB[0].Amount, 'Expected amount to halve');
    }

    @isTest
    static void TestNoReduce()
    {
        Opportunity opp=new Opportunity(Name='KAB Test',
                                        Amount=10000, 
                                        StageName='Prospecting',
                                        CloseDate=System.today());

        insert opp;

        Task task=new Task(Subject='Reduce Value', 
                                    Status='New',
                                    ActivityDate=System.today(),
                                    WhatId=opp.Id);

        insert task;

        task.Status='In Progress';
        update task;

        List<Opportunity> oppsFromDB=[select id, Amount
                                      from Opportunity 
                                      where id=:opp.Id];

        System.assertEquals(10000, oppsFromDB[0].Amount, 'Expected amount to stay the same.');
    }

    @isTest
    static void TestBulk()
    {
        List<Opportunity> opps=new List<Opportunity>();
        for (Integer idx=0; idx<200; idx++)
        {
            Opportunity opp=new Opportunity(Name='KAB Test ' + idx,
                                            Amount=1000+(1000*idx), 
                                            StageName='Prospecting',
                                            CloseDate=System.today());

            opps.add(opp);
        }
        insert opps;

        List<Task> tasks=new List<Task>();
        for (Opportunity opp : opps)
        {
            Task task=new Task(Subject='Reduce Value', 
                                        Status='New',
                                        ActivityDate=System.today(),
                                        WhatId=opp.Id);
            tasks.add(task);
        }

        insert tasks;

        for (Task task : tasks)
        {
            task.Status='Completed';
        }
        update tasks;

        List<Opportunity> oppsFromDB=[select id, Name, Amount
                                      from Opportunity 
                                      where id in :opps
                                      order by Amount asc];

        Double expectedVal=500;
        for (Opportunity oppFromDB : oppsFromDB)
        {
            System.assertEquals(expectedVal, oppFromDB.Amount, 'Incorrect amount for opp ' + oppFromDB.Name);

            expectedVal+=500;
        }
    }
}
